import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class AppAlerts {
  const AppAlerts._();

  static void displaySnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16, // Tùy chỉnh kích thước font chữ
            fontWeight: FontWeight.bold, // Tùy chỉnh độ đậm của font chữ
            color: Colors.white, // Tùy chỉnh màu sắc của font chữ
          ),
        ),
        backgroundColor: Colors.black, // Tùy chỉnh màu nền của Snackbar
        duration: const Duration(
            seconds: 1), // Tùy chỉnh thời gian hiển thị của Snackbar
        behavior: SnackBarBehavior
            .floating, // Tùy chỉnh hiệu ứng hiển thị của Snackbar
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Tùy chỉnh góc bo của Snackbar
        ),
      ),
    );
  }

  static Future<void> showDeleteAlertDialog(
      BuildContext context, WidgetRef ref, Task task) async {
    Widget cancelButton = TextButton(
      onPressed: () => context.pop(),
      child: const Text('NO'),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref.read(taskProvider.notifier).deleteTask(task).then((value) {
          AppAlerts.displaySnackbar(context, 'Task is deleted successfully');
          //exit the dialog
          context.pop();
        });
      },
      child: const Text('YES'),
    );

    AlertDialog alert = AlertDialog(
      title: const Text(
        'Are you sure you want to delete task?',
        style: TextStyle(
          fontSize: 18, // Tùy chỉnh kích thước font chữ của tiêu đề
          fontWeight:
              FontWeight.bold, // Tùy chỉnh độ đậm của font chữ của tiêu đề
          color: Colors.purple, // Tùy chỉnh màu sắc của font chữ của tiêu đề
        ),
      ),
      actions: [
        deleteButton,
        cancelButton,
      ],
      backgroundColor: Colors.white, // Tùy chỉnh màu nền của AlertDialog
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10), // Tùy chỉnh góc bo của AlertDialog
      ),
    );
    await showDialog(
        context: context,
        builder: (ctx) {
          return alert;
        });
  }
}
