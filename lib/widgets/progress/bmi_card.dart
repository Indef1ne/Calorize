import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calorize/data/models/user_profile.dart';

class BmiCard extends StatelessWidget {
  final UserProfile? userProfile;

  const BmiCard({super.key, this.userProfile});

  @override
  Widget build(BuildContext context) {
    if (userProfile == null || userProfile!.height == null || userProfile!.weight == null) {
      return const SizedBox();
    }

    final heightM = userProfile!.height! / 100;
    final bmi = userProfile!.weight! / (heightM * heightM);
    
    String status;
    Color statusColor;
    
    if (bmi < 18.5) {
      status = 'Underweight';
      statusColor = Colors.lightBlue;
    } else if (bmi < 25) {
      status = 'Healthy';
      statusColor = Colors.green;
    } else if (bmi < 30) {
      status = 'Overweight';
      statusColor = Colors.orange;
    } else {
      status = 'Obese';
      statusColor = Colors.red;
    }

    // Calculate marker position (0.0 to 1.0)
    // Range: 15 to 40
    double percent = (bmi - 15) / (40 - 15);
    percent = percent.clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your BMI',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('BMI Categories'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCategoryRow(context, 'Underweight', '<18.5', Colors.lightBlue),
                          _buildCategoryRow(context, 'Healthy', '18.5 - 24.9', Colors.green),
                          _buildCategoryRow(context, 'Overweight', '25 - 29.9', Colors.orange),
                          _buildCategoryRow(context, 'Obese', '30+', Colors.red),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: Icon(Icons.help_outline, size: 20, color: Theme.of(context).disabledColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                bmi.toStringAsFixed(2),
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Text(
                      'Your weight is ',
                      style: GoogleFonts.inter(color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Gauge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    colors: [Colors.lightBlue, Colors.green, Colors.orange, Colors.red],
                    stops: [0.0, 0.33, 0.66, 1.0],
                  ),
                ),
              ),
              Positioned(
                left: (MediaQuery.of(context).size.width - 48 - 24) * percent - 1, // Approximate width adjustment
                top: -4,
                child: Container(
                  width: 2,
                  height: 16,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLegendItem(context, Colors.lightBlue, 'Underweight'),
              _buildLegendItem(context, Colors.green, 'Healthy'),
              _buildLegendItem(context, Colors.orange, 'Overweight'),
              _buildLegendItem(context, Colors.red, 'Obese'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryRow(BuildContext context, String label, String range, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text(
            range,
            style: GoogleFonts.inter(color: Theme.of(context).textTheme.bodyMedium?.color),
          ),
        ],
      ),
    );
  }
}
