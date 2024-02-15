import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import ProviderScope
import 'package:todoapp/app/todo_app.dart';
import 'package:todoapp/utils/local_notifications.dart';
import 'package:todoapp/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();

  runApp(
    const ProviderScope(
      // Wrap your app with ProviderScope
      child: TodoApp(),
    ),
  );
}
