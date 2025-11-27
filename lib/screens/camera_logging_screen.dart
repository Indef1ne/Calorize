import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calorize/services/food_sourcing_service.dart';
import 'package:calorize/widgets/food_edit_sheet.dart';

class CameraLoggingScreen extends StatefulWidget {
  final bool initialBarcodeMode;
  const CameraLoggingScreen({super.key, this.initialBarcodeMode = true});

  @override
  State<CameraLoggingScreen> createState() => _CameraLoggingScreenState();
}

class _CameraLoggingScreenState extends State<CameraLoggingScreen> with WidgetsBindingObserver {
  // Barcode Scanner
  final MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: [BarcodeFormat.all],
    returnImage: false,
  );

  // AI Camera
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;

  late bool _isBarcodeMode;
  bool _isFlashOn = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _isBarcodeMode = widget.initialBarcodeMode;
    WidgetsBinding.instance.addObserver(this);
    if (!_isBarcodeMode) {
      _initCameras().then((_) => _initCameraController());
    } else {
      _initCameras();
    }
  }

  Future<void> _initCameras() async {
    try {
      _cameras = await availableCameras();
    } catch (e) {
      debugPrint('Error getting cameras: $e');
    }
  }

  Future<void> _initCameraController() async {
    if (_cameras.isEmpty) return;
    
    final camera = _cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => _cameras.first,
    );

    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid 
          ? ImageFormatGroup.jpeg 
          : ImageFormatGroup.bgra8888,
    );

    try {
      await _cameraController!.initialize();
      if (mounted) {
        setState(() => _isCameraInitialized = true);
      }
    } catch (e) {
      debugPrint('Error initializing camera controller: $e');
    }
  }

  Future<void> _disposeCameraController() async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
      _cameraController = null;
      _isCameraInitialized = false;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scannerController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (!_isBarcodeMode) {
        _initCameraController();
      }
    }
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      if (_isBarcodeMode) {
        _scannerController.toggleTorch();
      } else {
        _cameraController?.setFlashMode(
          _isFlashOn ? FlashMode.torch : FlashMode.off
        );
      }
    });
  }

  void _switchMode(bool isBarcode) async {
    if (_isBarcodeMode == isBarcode) return;

    setState(() {
      _isBarcodeMode = isBarcode;
      _isFlashOn = false; // Reset flash on mode switch
    });

    if (isBarcode) {
      // Switching to Barcode: Dispose Camera, Start Scanner
      await _disposeCameraController();
      _scannerController.start();
    } else {
      // Switching to AI: Stop Scanner, Init Camera
      _scannerController.stop();
      await _initCameraController();
    }
  }

  Future<void> _onBarcodeDetect(BarcodeCapture capture) async {
    if (!_isBarcodeMode || _isProcessing) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final code = barcodes.first.rawValue;
    if (code == null) return;

    setState(() => _isProcessing = true);
    HapticFeedback.mediumImpact();

    try {
      final log = await FoodSourcingService().getProductByBarcode(code);
      if (mounted && log != null) {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => FoodEditSheet(initialLog: log),
        );
        if (mounted) Navigator.pop(context);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product not found')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _captureAndAnalyze({bool fromGallery = false}) async {
    setState(() => _isProcessing = true);
    
    try {
      File? imageFile;
      
      if (fromGallery) {
        final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (picked != null) imageFile = File(picked.path);
      } else {
        // Capture using CameraController
        if (_cameraController != null && _cameraController!.value.isInitialized) {
          final xFile = await _cameraController!.takePicture();
          imageFile = File(xFile.path);
        }
      }

      if (imageFile != null && mounted) {
        // Show Context Dialog
        final contextController = TextEditingController();
        final shouldAnalyze = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Add Context'),
            content: TextField(
              controller: contextController,
              decoration: const InputDecoration(
                hintText: 'e.g. "Lunch at a cafe", "Homemade pasta"',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Analyze'),
              ),
            ],
          ),
        );

        if (shouldAnalyze == true) {
          final log = await FoodSourcingService().analyzeImage(imageFile, contextController.text);
          if (mounted) {
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => FoodEditSheet(initialLog: log),
            );
            if (mounted) Navigator.pop(context);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Analysis failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Preview Layer
          if (_isBarcodeMode)
            MobileScanner(
              controller: _scannerController,
              onDetect: _onBarcodeDetect,
              overlayBuilder: (context, constraints) {
                return Stack(
                  children: [
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.black54,
                        BlendMode.srcOut,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              backgroundBlendMode: BlendMode.dstOut,
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 300,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          else if (_isCameraInitialized && _cameraController != null)
            SizedBox.expand(
              child: CameraPreview(_cameraController!),
            )
          else
            const Center(child: CircularProgressIndicator(color: Colors.white)),

          // Top Controls
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                  IconButton(
                    icon: Icon(
                      _isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: _toggleFlash,
                  ),
                ],
              ),
            ),
          ),

          // Bottom Controls
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.6),
              padding: const EdgeInsets.only(bottom: 32, top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mode Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildModeButton('Scan Barcode', true),
                      const SizedBox(width: 24),
                      _buildModeButton('AI Analyze', false),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Shutter Area
                  SizedBox(
                    height: 80,
                    child: _isBarcodeMode
                      ? Center(
                          child: Text(
                            'Point at a barcode',
                            style: GoogleFonts.inter(color: Colors.white70),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Gallery Icon
                            IconButton(
                              icon: const Icon(Icons.photo_library, color: Colors.white, size: 32),
                              onPressed: () => _captureAndAnalyze(fromGallery: true),
                            ),
                            // Shutter Button
                            GestureDetector(
                              onTap: () => _captureAndAnalyze(fromGallery: false),
                              child: Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 4),
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            // Spacer to balance layout
                            const SizedBox(width: 48), 
                          ],
                        ),
                  ),
                ],
              ),
            ),
          ),
          
          // Processing Indicator
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildModeButton(String text, bool isBarcode) {
    final isSelected = _isBarcodeMode == isBarcode;
    return GestureDetector(
      onTap: () => _switchMode(isBarcode),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: isSelected ? Colors.yellow : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }
}
