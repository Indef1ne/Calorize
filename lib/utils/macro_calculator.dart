import 'package:calorize/data/models/user_profile.dart';

class MacroCalculator {
  /// Calculates Basal Metabolic Rate (BMR) using Mifflin-St Jeor Equation
  static int calculateBMR({
    required double weightKg,
    required double heightCm,
    required int age,
    required String gender, // 'Male' or 'Female'
  }) {
    // Base: 10 * weight + 6.25 * height - 5 * age
    double base = (10 * weightKg) + (6.25 * heightCm) - (5 * age);
    
    if (gender == 'Male') {
      return (base + 5).round();
    } else {
      return (base - 161).round();
    }
  }

  /// Calculates Total Daily Energy Expenditure (TDEE)
  static int calculateTDEE({
    required int bmr,
    required String activityLevel,
  }) {
    double multiplier;
    switch (activityLevel) {
      case 'Sedentary':
        multiplier = 1.2;
        break;
      case 'Light':
        multiplier = 1.375;
        break;
      case 'Moderate':
        multiplier = 1.55;
        break;
      case 'Active':
        multiplier = 1.725;
        break;
      case 'Very Active':
      case 'Extra Active': // Handling both names
        multiplier = 1.93; // Updated from 1.9
        break;
      default:
        multiplier = 1.2;
    }
    return (bmr * multiplier).round();
  }

  /// Calculates Daily Calorie Target based on Goal and Rate
  static int calculateDailyTarget({
    required int tdee,
    required String goalType, // 'lose', 'maintain', 'gain'
    required double weightLossRate, // kg per week
  }) {
    // 1kg of fat is approx 7700 kcal
    // Daily deficit/surplus needed = (Rate * 7700) / 7
    int adjustment = ((weightLossRate * 7700) / 7).round();

    if (goalType == 'lose') {
      return tdee - adjustment;
    } else if (goalType == 'gain') {
      return tdee + adjustment;
    } else {
      return tdee;
    }
  }

  /// Calculates Weeks to Goal
  static int calculateWeeksToGoal({
    required double currentWeight,
    required double targetWeight,
    required double rate,
  }) {
    if (rate <= 0) return 0;
    double diff = (currentWeight - targetWeight).abs();
    return (diff / rate).ceil();
  }

  // Calculates Macros and Micros
  static Map<String, double> calculateMacros({
    required int targetCalories,
    required double weightKg,
    required String goalType,
    required String gender, // Added for Fiber
    required int age, // Added for Fiber
    String dietPreference = 'Balanced',
  }) {
    double proteinRatio;
    double fatRatio;
    double carbsRatio;

    // Ratios based on User Specs
    switch (dietPreference) {
      case 'High Protein':
        // 40% C / 40% P / 20% F
        carbsRatio = 0.40;
        proteinRatio = 0.40;
        fatRatio = 0.20;
        break;
      case 'Low Carb':
        // 30% C / 35% P / 35% F
        carbsRatio = 0.30;
        proteinRatio = 0.35;
        fatRatio = 0.35;
        break;
      case 'Low Fat':
        // 50% C / 30% P / 20% F
        carbsRatio = 0.50;
        proteinRatio = 0.30;
        fatRatio = 0.20;
        break;
      case 'Balanced':
      default:
        // 40% C / 30% P / 30% F
        carbsRatio = 0.40;
        proteinRatio = 0.30;
        fatRatio = 0.30;
        break;
    }

    // Calculate grams
    // Protein & Carbs = 4 kcal/g, Fat = 9 kcal/g
    double protein = (targetCalories * proteinRatio) / 4;
    double fat = (targetCalories * fatRatio) / 9;
    double carbs = (targetCalories * carbsRatio) / 4;

    // Micro Nutrients
    // Sugar: < 10% of total calories
    // 1g Sugar = 4 kcal
    double sugarLimit = (targetCalories * 0.10) / 4;

    // Fiber: Based on Age/Gender (Standard Guidelines)
    double fiberGoal;
    if (gender == 'Male') {
      fiberGoal = age > 50 ? 30.0 : 38.0;
    } else {
      fiberGoal = age > 50 ? 21.0 : 25.0;
    }

    return {
      'protein': double.parse(protein.toStringAsFixed(1)),
      'fat': double.parse(fat.toStringAsFixed(1)),
      'carbs': double.parse(carbs.toStringAsFixed(1)),
      'calories': targetCalories.toDouble(),
      'fiber': fiberGoal,
      'sugar': double.parse(sugarLimit.toStringAsFixed(1)),
      'sodium': 2300.0, // Standard limit
    };
  }
}
