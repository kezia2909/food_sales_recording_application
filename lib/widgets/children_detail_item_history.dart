import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'detail_text.dart';

class ChildrenDetailItemHistory extends StatelessWidget {
  final int pcs;
  final String name;
  final int total;
  const ChildrenDetailItemHistory(
      {super.key, required this.pcs, required this.name, required this.total});

  @override
  Widget build(BuildContext context) {
    var totalText = NumberFormat.decimalPattern().format(total);

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 4),
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: DetailText(text: "${pcs}x"),
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DetailText(text: name),
                                DetailText(text: totalText)
                              ]),
                        ),
                      ),
                    ]),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
            ),
          ],
        ));
  }
}
