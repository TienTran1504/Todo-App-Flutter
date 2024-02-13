import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import ProviderScope
import 'package:todoapp/app/todo_app.dart';

void main() {
  runApp(
    const ProviderScope(
      // Wrap your app with ProviderScope
      child: TodoApp(),
    ),
  );
}
