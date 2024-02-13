import 'package:flutter/material.dart';
import 'package:todoapp/utils/utils.dart';
import 'package:gap/gap.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.suffixIcon,
    this.readOnly = false,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium,
        ),
        const Gap(10),
        TextField(
          readOnly: readOnly,
          controller: controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colors.primary, // Border color
                width: 1, // Border width
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.purple, // Border color when focused
                width: 1, // Border width when focused
              ),
            ),
            fillColor: colors.primaryContainer, // Màu nền
            filled: true,
          ),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
