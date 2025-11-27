import 'package:isar/isar.dart';

part 'food_log.g.dart';

@collection
class FoodLog {
  Id id = Isar.autoIncrement;

  late String foodName;
  String? brandName;
  late int calories;
  late DateTime timestamp;

  late Macros macros;
}

@embedded
class Macros {
  double? protein;
  double? carbs;
  double? fat;
  
  // Extended nutrition
  double? fiber;
  double? sugar;
  double? sodium;
}
