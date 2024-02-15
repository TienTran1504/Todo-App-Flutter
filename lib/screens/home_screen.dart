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
    // final completedTasks = _completedTasks(taskState.tasks, ref);
    // final incompletedTasks = _incompletedTasks(taskState.tasks, ref);
    final completedTasks = _filterTasks(taskState.tasks, option, search, true);
    final incompletedTasks =
        _filterTasks(taskState.tasks, option, search, false);
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
                    const Gap(20),
                    ElevatedButton.icon(
                      icon: Icon(Icons.notification_add_outlined),
                      onPressed: () async {
                        // NotificationManager().simpleNotificationShow();
                        // LocalNotifications.showSimpleNotification(
                        //     title: 'title', body: 'body', payload: 'payload');
                        await LocalNotifications.scheduleNotification();
                      },
                      label: Text('simple'),
                    )
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

  List<Task> _filterTasks(
      List<Task> tasks, int option, String search, bool isCompleted) {
    final currentDate = DateTime.now();
    final List<Task> filteredTasks = [];

    for (var task in tasks) {
      final isTaskDay = Helpers.isTaskFromSelectedDate(task, currentDate);
      if ((isCompleted && task.isCompleted ||
              !isCompleted && !task.isCompleted) &&
          (option == 0 ||
              (option == 1 && isTaskDay) ||
              (option == 2 && !isTaskDay))) {
        if (search == '') {
          filteredTasks.add(task);
        } else {
          if (task.title.toLowerCase().contains(search.toLowerCase())) {
            filteredTasks.add(task);
          }
        }
      }
    }

    return filteredTasks;
  }

  void sendNotification(Task task) async {
    final NotificationService notificationService = NotificationService();

    // Parse task date and time to DateTime object
    DateTime taskDateTime = DateTime.parse('${task.date} ${task.time}');

    // Calculate notification time
    DateTime notificationTime = taskDateTime.subtract(Duration(minutes: 10));

    // Send notification
    await notificationService.scheduleNotification(
      'Task Reminder',
      'Your task "${task.title}" is due in 10 minutes',
      notificationTime,
    );
  }
}
