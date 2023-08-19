import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;

  CustomTextField(
      {super.key,
      required this.textEditingController,
      required this.labelText,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: new InputDecoration(
        hintText: hintText,
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(8),
          ),
          borderSide: new BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
