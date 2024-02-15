import 'package:flutter/material.dart';
import 'package:todoapp/config/routes/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoApp extends ConsumerWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final routeConfig = ref.watch(routesProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routeConfig,
        );
      },
    );
  }
}
