import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/widgets/detail_text.dart';

import '../utils/app_colors.dart';
import '../widgets/title_text.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            width: double.infinity,
            color: Appcolors.darkColor,
            child: TitleText(
              text: "Menu",
              isBold: true,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DetailText(
                                    text: "Beef Galantine",
                                    size: 16,
                                  ),
                                  DetailText(
                                    text: "180,000",
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: FittedBox(
                                child: Icon(
                                  Icons.delete,
                                  color: Appcolors.redColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: FittedBox(
                                child: Icon(
                                  Icons.edit,
                                  color: Appcolors.mediumColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  );
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}
