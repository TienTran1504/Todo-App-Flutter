import 'package:flutter/material.dart';
import 'package:todoapp/utils/utils.dart';

class CustomRadio extends StatefulWidget {
  const CustomRadio({super.key, required this.option});
  final int option;
  @override
  State<CustomRadio> createState() => _CutomRadioState();
}

class _CutomRadioState extends State<CustomRadio> {
  late int value;
  @override
  void initState() {
    super.initState();
    value = widget.option; // Set initial value from the option
  }

  Widget customRadioButton(String text, int index) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.transparent,
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
              return BorderSide(
                color: (value == index) ? Colors.purple : Colors.black,
              );
            },
          ),
        ),
        onPressed: () {
          setState(() {
            value = index;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: (value == index) ? Colors.purple : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 18.0), // Add left padding
      child: Row(
        children: <Widget>[
          customRadioButton("All", 0),
          SizedBox(width: 10),
          customRadioButton("Today", 1),
          SizedBox(width: 10),
          customRadioButton("Up Comming", 2),
        ],
      ),
    );
  }
}
