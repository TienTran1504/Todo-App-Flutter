import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todoapp/data/data.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'dart:math';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            macOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) => null,
    );
  }

  //simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            icon: 'flutter_logo',
            largeIcon: DrawableResourceAndroidBitmap('flutter_logo'),
            ticker: 'ticker');

    const DarwinNotificationDetails iOSNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  static Future scheduleNotificationForTask(Task task) async {
    // Parse task date and time to DateTime object
    tz.initializeTimeZones();
    DateTime dateTime = DateFormat('MMM dd, yyyy').parse(task.date);

    List<String> timeParts = task.time.split('\u202F');
    List<String> timeNumbers = timeParts[0].split(':');
    int hour = int.parse(timeNumbers[0]);
    int minute = int.parse(timeNumbers[1]);
    if (timeParts[1] == 'PM') {
      hour += 12;
    }

    DateTime taskDateTime =
        dateTime.add(Duration(hours: hour, minutes: minute));

    // Calculate notification time
    DateTime notificationTime =
        taskDateTime.subtract(const Duration(minutes: 10));
    // Check if the notification time is in the future
    if (notificationTime.isAfter(DateTime.now())) {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('channel 3', 'your channel name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              icon: 'flutter_logo',
              largeIcon: DrawableResourceAndroidBitmap('flutter_logo'),
              ticker: 'ticker');

      const DarwinNotificationDetails iOSNotificationDetails =
          DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iOSNotificationDetails,
      );

      Random random = Random();
      int id = random.nextInt(999999);
      await _flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          'Task Reminder',
          'Your task "${task.title}" is due in 10 minutes',
          tz.TZDateTime.from(notificationTime, tz.local),
          notificationDetails,
          // androidAllowWhileIdle: true,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: 'empty');
    }
  }

  static Future showScheduleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones();
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'channel 3', 'your channel name',
                channelDescription: 'your channel description',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);
  }
}
