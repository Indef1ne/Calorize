import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:calorize/data/models/user_profile.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
// Note: We removed 'flutter_timezone' import because we use manual offsets now.

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // 1. Initialize Timezone Database
    tz.initializeTimeZones();
    
    // 2. Set Default to UTC (We will handle offsets manually in the logic)
    tz.setLocalLocation(tz.getLocation('UTC'));

    // 3. Initialize Settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('🔔 Notification tapped: ${response.payload}');
      },
    );
  }

  Future<bool> requestPermissions() async {
    final bool? notificationGranted = await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.requestExactAlarmsPermission();
    }

    return notificationGranted ?? false;
  }

  Future<void> scheduleDailyNotifications(UserProfile profile) async {
    if (!profile.notificationsEnabled) {
      await cancelAll();
      debugPrint('🔕 Notifications disabled.');
      return;
    }

    await requestPermissions();
    await cancelAll();

    debugPrint('📅 Scheduling Daily Meals (Offset: UTC${profile.utcOffset >= 0 ? '+' : ''}${profile.utcOffset})...');

    await _scheduleNotification(
      id: 1,
      title: 'Breakfast Time! 🍳',
      body: 'Don\'t forget to log your breakfast.',
      minutesFromMidnight: profile.breakfastTime,
      utcOffset: profile.utcOffset,
    );

    await _scheduleNotification(
      id: 2,
      title: 'Lunch Time! 🥗',
      body: 'Time to log your lunch.',
      minutesFromMidnight: profile.lunchTime,
      utcOffset: profile.utcOffset,
    );

    await _scheduleNotification(
      id: 3,
      title: 'Dinner Time! 🥩',
      body: 'Remember to log your dinner.',
      minutesFromMidnight: profile.dinnerTime,
      utcOffset: profile.utcOffset,
    );
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int minutesFromMidnight,
    required int utcOffset,
  }) async {
    try {
      // 1. Get Current UTC Time
      final nowUTC = tz.TZDateTime.now(tz.UTC);
      
      // 2. Calculate User's "Wall Clock" Time
      // We simulate what time it is on the user's phone right now
      final offsetDuration = Duration(hours: utcOffset);
      final userWallTime = nowUTC.add(offsetDuration);

      // 3. Construct the Target Time for TODAY based on User's Wall Time
      // Example: If user wants 8:00 AM, we create "Today at 8:00 AM" in their simulated time
      var targetUserTime = tz.TZDateTime(
        tz.UTC, // We keep the container UTC for math safety
        userWallTime.year,
        userWallTime.month,
        userWallTime.day,
        minutesFromMidnight ~/ 60,
        minutesFromMidnight % 60,
      );

      // 4. If that time has passed for the user today, add 1 day
      if (targetUserTime.isBefore(userWallTime)) {
        targetUserTime = targetUserTime.add(const Duration(days: 1));
      }

      // 5. Convert back to System UTC for the Alarm Manager
      // If Target is "8:00 AM User Time", subtract offset to get "0:00 AM UTC"
      final finalScheduleTime = targetUserTime.subtract(offsetDuration);

      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        finalScheduleTime, // This is the absolute UTC instant the alarm should ring
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'meal_reminders_v2', 
            'Meal Reminders V2',
            channelDescription: 'Reminders to log your meals',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/launcher_icon',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: 
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      
      debugPrint('✅ Scheduled [$title] for $finalScheduleTime (UTC)');
    } catch (e) {
      debugPrint('❌ Error scheduling notification $id: $e');
    }
  }

  Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }
}