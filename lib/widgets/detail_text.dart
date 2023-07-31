import 'package:flutter/material.dart';

class DetailText extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  final bool isBold;
  const DetailText(
      {super.key,
      required this.text,
      this.color = const Color(0xFF0C0C0C),
      this.size = 14,
      this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
