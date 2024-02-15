import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import ProviderScope
import 'package:todoapp/app/todo_app.dart';
import 'package:todoapp/utils/local_notifications.dart';
import 'package:todoapp/utils/utils.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // NotificationManager().initNotification();
  // final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
  // tz.setLocalLocation(tz.getLocation(timeZoneName!));
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
  await LocalNotifications.init();
  // Khởi tạo local
  // tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));

  runApp(
    const ProviderScope(
      // Wrap your app with ProviderScope
      child: TodoApp(),
    ),
  );
}
