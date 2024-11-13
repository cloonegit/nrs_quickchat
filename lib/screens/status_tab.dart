import 'package:flutter/material.dart';
import 'package:NRS_Quickchat/global_function/app_debug.dart';
import 'package:NRS_Quickchat/screens/listpage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StatusTab extends StatefulWidget {
  const StatusTab({super.key});

  @override
  State<StatusTab> createState() => _StatusTabState();
}

class _StatusTabState extends State<StatusTab> {
  List dataList = [
    {'status': 'Pending', 'quantity': 10},
    {'status': 'Ongoing', 'quantity': 8},
    {'status': 'Redirected', 'quantity': 5},
    {'status': 'Resolved', 'quantity': 7},
  ];

  int getTotalQuantity() {
    return dataList.fold(0, (sum, item) => sum + item['quantity'] as int);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // color: Colors.blue[30],
        color: Colors.grey[100],

        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: Adaptive.w(6),
                right: Adaptive.w(10),
                top: Adaptive.h(5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Qty',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dataList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  bool isLastItem = index == dataList.length;

                  if (isLastItem) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Adaptive.h(0),
                        horizontal: Adaptive.w(4),
                      ),
                      child: Container(
                        height: Adaptive.h(7),
                        width: Adaptive.w(50),
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Adaptive.w(4), right: Adaptive.w(6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                getTotalQuantity().toString(),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    final item = dataList[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Adaptive.h(1),
                        horizontal: Adaptive.w(4),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          AppDebug()
                              .printDebug(msg: 'status:${item['status']}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListPage(
                                status: item['status'].toUpperCase(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: Adaptive.h(7),
                          width: Adaptive.w(50),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['status'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      item['quantity'].toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: Adaptive.w(1)),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
