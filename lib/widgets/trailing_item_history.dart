import 'package:flutter/material.dart';

class TrailingItemHistory extends StatelessWidget {
  final bool isExpanded;
  const TrailingItemHistory({super.key, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.width * 0.1,
      child: FittedBox(
        child: Icon(
          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_right,
          color: Colors.black,
        ),
      ),
    );
  }
}
