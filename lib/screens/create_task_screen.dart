import 'package:flutter/material.dart';
import 'package:todoapp/utils/utils.dart';
import 'package:todoapp/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateTaskScreen extends StatelessWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

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
              const CommonTextField(
                title: 'Task Title',
                hintText: 'Task Title',
              ),
              const Gap(16),
              const SelectCategory(),
              const Gap(16),
              const SelectDateTime(),
              const Gap(16),
              const CommonTextField(
                title: 'Note',
                hintText: 'Task Note',
                maxLines: 6,
              ),
              const Gap(60),
              ElevatedButton(
                onPressed: () {},
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
}
