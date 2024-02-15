import 'package:flutter/material.dart';
import 'package:todoapp/providers/option_time/option_time_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomRadio extends ConsumerStatefulWidget {
  const CustomRadio({super.key, required this.option});
  final int option;
  @override
  ConsumerState<CustomRadio> createState() => _CutomRadioState();
}

class _CutomRadioState extends ConsumerState<CustomRadio> {
  late int value;
  @override
  void initState() {
    super.initState();
    value = widget.option; // Set initial value from the option
  }

  Widget customRadioButton(String text, int index) {
    final optionValue = ref.watch(optionProvider).option;

    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.transparent,
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
              return BorderSide(
                color: (optionValue == index) ? Colors.purple : Colors.black,
              );
            },
          ),
        ),
        onPressed: () {
          ref.read(optionProvider.notifier).setOption(index);
          // setState(() {
          //   value = index;
          // });
        },
        child: Text(
          text,
          style: TextStyle(
            color: (optionValue == index) ? Colors.purple : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0), // Add left padding
      child: Row(
        children: <Widget>[
          customRadioButton("All", 0),
          const SizedBox(width: 10),
          customRadioButton("Today", 1),
          const SizedBox(width: 10),
          customRadioButton("Up Comming", 2),
        ],
      ),
    );
  }
}
