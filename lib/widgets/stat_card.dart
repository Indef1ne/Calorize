import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? value;
  final String? unit;
  final double? progress;
  final Color? progressColor;
  final Color? backgroundColor;
  final IconData? icon;
  final Color? iconColor;
  final bool isLarge;
  final Widget? customContent;

  const StatCard({
    super.key,
    required this.title,
    this.subtitle,
    this.value,
    this.unit,
    this.progress,
    this.progressColor,
    this.backgroundColor,
    this.icon,
    this.iconColor,
    this.isLarge = false,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: customContent ?? _buildDefaultContent(context),
    );
  }

  Widget _buildDefaultContent(BuildContext context) {
    if (isLarge) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value ?? '0',
                style: GoogleFonts.inter(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null) ...[
                      TextSpan(
                        text: ' $subtitle',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (progress != null)
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 12,
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progressColor ?? Theme.of(context).colorScheme.primary,
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  ),
                  if (icon != null)
                    Center(
                      child: Icon(
                        icon,
                        size: 32,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ),
        ],
      );
    }

    // Small Card Layout
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  value ?? '0',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            ),
            if (unit != null)
              Text(
                unit!,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
          ],
        ),
        const SizedBox(height: 2),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    TextSpan(
                      text: ' $subtitle',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        if (progress != null)
          Center(
            child: SizedBox(
              width: 50, // Reduced from 60
              height: 50, // Reduced from 60
              child: Stack(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 6, // Reduced from 8
                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progressColor ?? Theme.of(context).colorScheme.primary,
                      ),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  if (icon != null)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(6), // Reduced from 8
                        decoration: BoxDecoration(
                          color: (iconColor ?? Theme.of(context).colorScheme.primary).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          size: 14, // Reduced from 16
                          color: iconColor ?? Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
