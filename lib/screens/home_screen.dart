import 'package:flutter/material.dart';
import 'package:todoapp/config/routes/routes.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/providers/option_time/option_time_provider.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/providers/search/search.dart';
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
    final option = ref.watch(optionProvider).option;
    final search = ref.watch(searchProvider).search;
    final completedTasks = _filterTasks(taskState.tasks, option, search, true);
    final incompletedTasks =
        _filterTasks(taskState.tasks, option, search, false);
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
                  const Gap(20),
                  const DisplayWhiteText(
                    text: 'TODO LIST',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(5),
                  InkWell(
                    // onTap: () => Helpers.selectDate(context, ref),
                    child: DisplayWhiteText(
                      text: DateFormat.yMMMd().format(currentDate),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            const SearchBox(),
            const Gap(10),
            CustomRadio(option: option),
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
                        child: DisplayWhiteText(
                          text: 'Add New Task',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ]),
    );
  }

  List<Task> _filterTasks(
      List<Task> tasks, int option, String search, bool isCompleted) {
    final currentDate = DateTime.now();
    final List<Task> filteredTasks = [];

    for (var task in tasks) {
      final isTaskDay = Helpers.isTaskFromSelectedDate(task, currentDate);
      final isFutureTaskDay = Helpers.isTaskFromFutureDate(task, currentDate);
      bool shouldAddTask = false;
      if (option == 0) {
        shouldAddTask = true;
      } else if (option == 1) {
        shouldAddTask = isTaskDay;
      } else if (option == 2) {
        shouldAddTask = isFutureTaskDay;
      }

      if (shouldAddTask && task.isCompleted == isCompleted) {
        if (search.isEmpty ||
            task.title.toLowerCase().contains(search.toLowerCase())) {
          filteredTasks.add(task);
        }
      }
    }

    return filteredTasks;
  }
}
