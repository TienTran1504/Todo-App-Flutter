import 'package:flutter/material.dart';
import 'package:todoapp/config/routes/routes.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/utils/utils.dart';
import 'package:todoapp/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteText(text: 'Add New Task'),
        backgroundColor: colors.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              CommonTextField(
                title: 'Task Title',
                hintText: 'Task Title',
                controller: _titleController,
              ),
              const Gap(16),
              const SelectCategory(),
              const Gap(16),
              const SelectDateTime(),
              const Gap(16),
              CommonTextField(
                title: 'Note',
                hintText: 'Task Note',
                maxLines: 8,
                controller: _noteController,
              ),
              const Gap(70),
              ElevatedButton(
                onPressed: _createTask,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: colors.primary,
                  minimumSize: Size(
                      deviceSize.width * 0.9, 0), // Width 90% of screen width
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DisplayWhiteText(text: 'Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);
    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        note: note,
        date: DateFormat.yMMMd().format(date),
        time: Helpers.timeToString(time),
        category: category,
        isCompleted: false,
      );
      await ref.read(taskProvider.notifier).createTask(task).then((value) {
        AppAlerts.displaySnackbar(context, 'Task created successfully');
        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackbar(context, 'Task title cannot be empty');
    }
  }
}
