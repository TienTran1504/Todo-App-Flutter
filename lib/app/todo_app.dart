import 'package:flutter/material.dart';
import 'package:todoapp/config/config.dart';
import 'package:todoapp/screens/home_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: AppTheme.light,
        home: const HomeScreen());
  }
}
