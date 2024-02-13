import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/data/repositories/task_repository_provider.dart';
import 'package:todoapp/providers/providers.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});
