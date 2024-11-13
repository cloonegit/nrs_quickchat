import 'package:flutter/material.dart';
import 'package:NRS_Quickchat/global_function/app_back_button.dart';
import 'package:NRS_Quickchat/screens/quickchatdetails.dart';
import 'package:NRS_Quickchat/widget/custom_appbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListPage extends StatefulWidget {
  String? status;
  ListPage({super.key, this.status});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final AppDeviceBackBtn backBtnHandler = AppDeviceBackBtn();

  List dataList = [
    {'name': 'GAN POH YI', 'date': '16/07/2024 07:58 PM', 'notification': 2},
    {'name': 'ALI ABU', 'date': '10/1/2024 05:58 PM', 'notification': 1},
    {'name': 'ABU BABA', 'date': '16/10/2024 02:58 PM', 'notification': 2},
    {'name': 'GAN POH YI', 'date': '16/07/2024 07:58 PM', 'notification': 2},
    {'name': 'ALI ABU', 'date': '10/1/2024 05:58 PM', 'notification': 1},
    {'name': 'ABU BABA', 'date': '16/10/2024 02:58 PM', 'notification': 2},
    {'name': 'GAN POH YI', 'date': '16/07/2024 07:58 PM', 'notification': 2},
    {'name': 'ALI ABU', 'date': '10/1/2024 05:58 PM', 'notification': 1},
    {'name': 'ABU BABA', 'date': '16/10/2024 02:58 PM', 'notification': 2},
    {'name': 'GAN POH YI', 'date': '16/07/2024 07:58 PM', 'notification': 2},
    {'name': 'ALI ABU', 'date': '10/1/2024 05:58 PM', 'notification': 1},
    {'name': 'ABU BABA', 'date': '16/10/2024 02:58 PM', 'notification': 2},
    {'name': 'GAN POH YI', 'date': '16/07/2024 07:58 PM', 'notification': 2},
    {'name': 'ALI ABU', 'date': '10/1/2024 05:58 PM', 'notification': 1},
    {'name': 'ABU BABA', 'date': '16/10/2024 02:58 PM', 'notification': 2},
    {'name': 'GAN POH YI', 'date': '16/07/2024 07:58 PM', 'notification': 2},
    {'name': 'ALI ABU', 'date': '10/1/2024 05:58 PM', 'notification': 1},
    {'name': 'ABU BABA', 'date': '16/10/2024 02:58 PM', 'notification': 2}
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: '${widget.status} LIST'),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = dataList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuickChatDetails(),
                              ),
                            );
                          },
                          child: Container(
                            // height: Adaptive.h(7),
                            width: Adaptive.w(50),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['name'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            item['date'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Color(0xFFED1C24),
                                          child: Text(
                                            item['notification'].toString(),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                color: Colors.white),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
          ],
        ),
      )),
    );
  }
}
