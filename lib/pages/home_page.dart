import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/zondicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var isExpanded = false;
  final isExpandedList = List<bool>.generate(10, (int index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amberAccent,
        child: Column(
          children: [
            Container(
              color: Colors.brown,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Saturday, 29 July 2023"),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(8.0)),
                        child: FittedBox(
                          child: Icon(
                            Icons.assignment_outlined,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Target This Month"),
                            Text("IDR 1,000,000"),
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                // color: Colors.blue,
                                gradient: LinearGradient(colors: [
                                  Colors.green,
                                  Colors.green,
                                  Colors.white,
                                  Colors.white
                                ], stops: [
                                  0.0,
                                  0.5,
                                  0.5,
                                  1.0
                                ]),
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              color: Colors.grey[300],
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Saturday, 29 July 2023"),
                    Text("IDR 525,000")
                  ]),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      // margin: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                      child: ListTileTheme(
                        shape: Border.all(color: Colors.green),
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 0,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: Column(
                            children: [
                              ExpansionTile(
                                onExpansionChanged: (value) {
                                  setState(() => isExpandedList[index] = value);
                                },
                                trailing: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: FittedBox(
                                    child: Icon(
                                      isExpandedList[index]
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 4),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          child: FittedBox(
                                            child: Icon(
                                              Icons.warning_amber_rounded,
                                              color: Colors.brown,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Kezia Angeline"),
                                                      Text("UNPAID")
                                                    ],
                                                  ),
                                                  Text("300,000")
                                                ]),
                                          ),
                                        ),
                                      ]),
                                ),
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                color: Colors.white,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 4),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                        child: Text("1x"),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                    "Beef Galantine"),
                                                                Text("300,000")
                                                              ]),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
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
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
