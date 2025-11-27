import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calorize/data/models/user_profile.dart';

class WeightCard extends StatelessWidget {
  final UserProfile? userProfile;
  final VoidCallback onLogWeight;

  const WeightCard({
    super.key,
    required this.userProfile,
    required this.onLogWeight,
  });

  @override
  Widget build(BuildContext context) {
    final isMetric = userProfile?.isMetric ?? true;
    final unit = isMetric ? 'kg' : 'lbs';
    
    double currentWeight = userProfile?.weight ?? 0;
    double targetWeight = userProfile?.targetWeight ?? 0;

    if (!isMetric) {
      currentWeight *= 2.20462;
      targetWeight *= 2.20462;
    }

    return GestureDetector(
      onTap: onLogWeight,
      child: Container(
        // height: 180, // Removed fixed height
        constraints: const BoxConstraints(minHeight: 180),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My Weight',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${currentWeight.toStringAsFixed(1)} $unit',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 8),
            // Progress Bar (Mock visual)
            Container(
              height: 6,
              width: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.7, // Mock progress
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Goal ${targetWeight.toStringAsFixed(1)} $unit',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16), // Replaced Spacer with SizedBox
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onLogWeight,
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Log Weight',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
