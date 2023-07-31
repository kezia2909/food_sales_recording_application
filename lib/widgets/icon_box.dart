import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final double marginRight;

  const IconBox(
      {super.key,
      required this.icon,
      required this.iconColor,
      required this.backgroundColor,
      required this.size,
      this.marginRight = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: marginRight),
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(8.0)),
      child: FittedBox(
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
