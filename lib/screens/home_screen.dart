import 'package:flutter/material.dart';
import 'package:todoapp/config/routes/routes.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);
    final completedTasks = _completedTasks(taskState.tasks, ref);
    final incompletedTasks = _incompletedTasks(taskState.tasks, ref);
    final selectedDate = ref.watch(dateProvider);
    final currentDate = DateTime.now();
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      body: Stack(children: [
        Column(
          children: [
            Container(
              height: deviceSize.height * 0.15,
              width: deviceSize.width,
              color: colors.primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    // onTap: () => Helpers.selectDate(context, ref),
                    child: DisplayWhiteText(
                      text: DateFormat.yMMMd().format(currentDate),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const DisplayWhiteText(
                    text: 'My Todo List',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            const Gap(10),
            const SearchBox(),
            const Gap(10),
            const CustomRadio(option: 0),
          ],
        ),
        Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayListOfTasks(
                      tasks: incompletedTasks,
                    ),
                    const Gap(20),
                    // const Text(
                    //   'Completed',
                    //   style: context.textTheme.headlineMedium,
                    // ),
                    Text(
                      'Completed',
                      style: context.textTheme.headlineSmall,
                    ),
                    const Gap(20),
                    DisplayListOfTasks(
                      tasks: completedTasks,
                      isCompletedTasks: true,
                    ),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () => context.push(RouteLocation.createTask),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: colors.primary,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DisplayWhiteText(text: 'Add New Task'),
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ]),
    );
  }

  List<Task> _completedTasks(List<Task> tasks, WidgetRef ref) {
    final selectedDate = ref.watch(dateProvider);
    final currentDate = DateTime.now();
    final List<Task> filteredTasks = [];
    for (var task in tasks) {
      if (task.isCompleted) {
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, currentDate);
        filteredTasks.add(task);
        // if (isTaskDay) {
        //   filteredTasks.add(task);
        // }
      }
    }
    return filteredTasks;
  }

  List<Task> _incompletedTasks(List<Task> tasks, WidgetRef ref) {
    final selectedDate = ref.watch(dateProvider);
    final currentDate = DateTime.now();
    final List<Task> filteredTasks = [];
    for (var task in tasks) {
      if (!task.isCompleted) {
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, currentDate);
        filteredTasks.add(task);
        // if (isTaskDay) {
        //   filteredTasks.add(task);
        // }
      }
    }
    return filteredTasks;
  }
}
