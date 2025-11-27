import 'package:flutter_test/flutter_test.dart';
import 'package:calorize/utils/macro_calculator.dart';

void main() {
  group('MacroCalculator Tests', () {
    test('Calculate BMR for Male', () {
      // 10*80 + 6.25*180 - 5*25 + 5 = 800 + 1125 - 125 + 5 = 1805
      final bmr = MacroCalculator.calculateBMR(
        weightKg: 80,
        heightCm: 180,
        age: 25,
        gender: 'Male',
      );
      expect(bmr, 1805);
    });

    test('Calculate BMR for Female', () {
      // 10*60 + 6.25*165 - 5*30 - 161 = 600 + 1031.25 - 150 - 161 = 1320.25
      final bmr = MacroCalculator.calculateBMR(
        weightKg: 60,
        heightCm: 165,
        age: 30,
        gender: 'Female',
      );
      expect(bmr, 1320.25);
    });

    test('Calculate TDEE (Moderate Activity)', () {
      final tdee = MacroCalculator.calculateTDEE(
        bmr: 1800,
        activityLevel: ActivityLevel.moderate,
      );
      // 1800 * 1.55 = 2790
      expect(tdee, 2790);
    });

    test('Calculate Macros for Muscle Gain (Protein Prioritization)', () {
      // 80kg Male, TDEE 2800
      // Target Calories = 2800 + 250 = 3050
      // Protein = 80 * 2.0 = 160g (640 cal)
      // Fat = 80 * 0.8 = 64g (576 cal)
      // Remaining for Carbs = 3050 - 1216 = 1834 cal -> 458.5g
      
      final macros = MacroCalculator.calculateMacros(
        tdee: 2800,
        weightKg: 80,
        goal: Goal.buildMuscle,
      );

      expect(macros['protein'], 160.0);
      expect(macros['fat'], 64.0);
      expect(macros['carbs'], 458.5);
      expect(macros['calories'], 3050.0);
    });

    test('Calculate Macros for Weight Loss (Standard Split)', () {
      // TDEE 2500
      // Target = 2000
      // Protein 40% = 800 cal / 4 = 200g
      // Fat 30% = 600 cal / 9 = 66.7g
      // Carbs 30% = 600 cal / 4 = 150g
      
      final macros = MacroCalculator.calculateMacros(
        tdee: 2500,
        weightKg: 80,
        goal: Goal.loseWeight,
      );

      expect(macros['protein'], 200.0);
      expect(macros['fat'], 66.7);
      expect(macros['carbs'], 150.0);
      expect(macros['calories'], 2000.0);
    });
  });
}
