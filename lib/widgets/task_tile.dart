import 'package:flutter/material.dart';
import 'package:todoapp/data/data.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/utils/utils.dart';
import 'package:todoapp/widgets/widgets.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, this.onCompleted});
  final Task task;
  final Function(bool?)? onCompleted;
  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    final double iconOpacity = task.isCompleted ? 0.3 : 0.5;
    final backgroundOpacity = task.isCompleted ? 0.1 : 0.3;
    final textDecoration =
        task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
    final fontWeight = task.isCompleted ? FontWeight.normal : FontWeight.bold;
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          CircleContainer(
            color: task.category.color.withOpacity(iconOpacity),
            child: Center(
              child: Icon(
                task.category.icon,
                color: task.category.color.withOpacity(iconOpacity),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: style.titleMedium?.copyWith(
                    decoration: textDecoration,
                    fontSize: 16,
                    fontWeight: fontWeight,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      task.date,
                      style: style.titleMedium
                          ?.copyWith(decoration: textDecoration),
                    ),
                    const Gap(10),
                    Text(
                      task.time,
                      style: style.titleMedium
                          ?.copyWith(decoration: textDecoration),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Checkbox(
            value: task.isCompleted,
            onChanged: onCompleted,
          ),
        ],
      ),
    );
    ;
  }
}
