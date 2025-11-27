import 'package:isar/isar.dart';

part 'daily_stat.g.dart';

@collection
class DailyStat {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime date;

  late int totalCalories;
  
  // Macros
  double totalProtein = 0;
  double totalCarbs = 0;
  double totalFat = 0;



  double? weightEntry;
  double? bmi;

  // Rollover tracking
  double rolloverFromPreviousDay = 0;  // Calories carried from yesterday
  double rolloverToNextDay = 0;        // Calories to carry to tomorrow
  bool goalMetWithinRange = false;     // Did this day meet success criteria?
}
