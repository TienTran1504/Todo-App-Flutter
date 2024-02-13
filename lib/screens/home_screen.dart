import 'package:flutter/material.dart';
import 'package:todoapp/config/routes/routes.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      body: Stack(children: [
        Column(
          children: [
            Container(
              height: deviceSize.height * 0.15,
              width: deviceSize.width,
              color: colors.primary,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DisplayWhiteText(
                    text: 'Aug 7, 2023',
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  DisplayWhiteText(
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
                    const DisplayListOfTasks(
                      tasks: [
                        Task(
                          title: 'title 1',
                          note: '',
                          time: '10:12',
                          date: 'Aug 07',
                          isCompleted: false,
                          category: TaskCategories.shopping,
                        ),
                        Task(
                          title: 'title 2',
                          note: 'note 2',
                          time: '13:12',
                          date: 'Aug 07',
                          isCompleted: false,
                          category: TaskCategories.education,
                        )
                      ],
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
                    const DisplayListOfTasks(
                      tasks: [
                        Task(
                          title: 'title 3',
                          note: 'note 3',
                          time: '12:12',
                          date: 'Aug 20',
                          isCompleted: true,
                          category: TaskCategories.personal,
                        ),
                        Task(
                          title: 'title 4',
                          note: 'note 4',
                          time: '18:12',
                          date: 'Aug 10',
                          isCompleted: true,
                          category: TaskCategories.work,
                        ),
                        Task(
                          title: 'title 4',
                          note: 'note 4',
                          time: '18:12',
                          date: 'Aug 10',
                          isCompleted: true,
                          category: TaskCategories.social,
                        )
                      ],
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
}
