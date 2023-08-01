import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'detail_text.dart';
import 'icon_box.dart';

class HistoryItem extends StatefulWidget {
  final bool isExpanded;
  const HistoryItem({super.key, this.isExpanded = false});

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  // bool isExpandeds = idget.isExpanded;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTileTheme(
        shape: Border.all(color: Colors.green),
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Column(
            children: [
              ExpansionTile(
                onExpansionChanged: (value) {
                  setState(() => widget.isExpanded == value);
                },
                trailing: Container(
                  margin: EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                  child: FittedBox(
                    child: Icon(
                      widget.isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: Container(
                  margin: EdgeInsets.only(left: 20),
                  color: Colors.white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconBox(
                          icon: Icons.warning_amber_rounded,
                          iconColor: Appcolors.mediumColor,
                          backgroundColor: Colors.transparent,
                          size: MediaQuery.of(context).size.width * 0.15,
                          marginRight: 4,
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DetailText(
                                        text: "Kezia Angeline",
                                      ),
                                      DetailText(
                                        text: "UNPAID",
                                        color: Appcolors.mediumColor,
                                        isBold: true,
                                      )
                                    ],
                                  ),
                                  DetailText(
                                    text: "300,000",
                                    color: Appcolors.greenColor,
                                    isBold: true,
                                  )
                                ]),
                          ),
                        ),
                      ]),
                ),
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 4),
                                        alignment: Alignment.centerRight,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: DetailText(text: "1x"),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                DetailText(
                                                    text: "Beef Galantine"),
                                                DetailText(text: "300,000")
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
                        ))
                ],
              ),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
