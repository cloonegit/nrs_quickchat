import 'dart:io';
import 'package:flutter/material.dart';
import 'package:NRS_Quickchat/global_function/app_back_button.dart';
import 'package:NRS_Quickchat/global_function/app_debug.dart';
import 'package:NRS_Quickchat/screens/ongoingchat_tab.dart';
import 'package:NRS_Quickchat/screens/staffaccess_tab.dart';
import 'package:NRS_Quickchat/screens/status_tab.dart';
import 'package:NRS_Quickchat/widget/custom_appbar.dart';
import 'package:NRS_Quickchat/widget/custom_modal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  File? _imageFile;
  late final TabController _tabController;
  final AppDeviceBackBtn backBtnHandler = AppDeviceBackBtn();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  openModal() {
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: CustomModal(
              isCloseButton: true,
              onClose: () {
                // Navigator.pop(context);
              },
              title: 'Confirm Logout',
              subtitle: 'Do you want to logout?',
              button: 'YES',
              button2: 'NO',
              onNext: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              onCancel: () {},
            ),
          );
        });
  }

  String generateGreetings() {
    final timeNow = DateTime.now();
    final hour = timeNow.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 14) {
      return 'Good Afternoon';
    } else if (hour >= 14 && hour < 19) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, dynamic) async {
        await backBtnHandler.popped(context);
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: CustomAppbar(title: 'QUICKCHAT'),
          body: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: Adaptive.w(6), top: Adaptive.h(3)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AppDebug().printDebug(msg: 'tap profile pic');
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        // backgroundImage:
                        //     _imageFile != null ? FileImage(_imageFile!) : null,
                        child: _imageFile == null
                            ? Icon(
                                Icons.camera_alt,
                                color: Colors.grey[700],
                                size: 30,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(width: Adaptive.w(5)),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: Adaptive.h(1)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              generateGreetings(),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: Adaptive.h(1),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'SH11541 (83)',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: Adaptive.w(2)),
                                GestureDetector(
                                  onTap: () {
                                    openModal();
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Adaptive.h(4)),
              TabBar(
                tabs: const [
                  Tab(text: 'Status'),
                  Tab(text: 'Ongoing Chat'),
                  Tab(text: 'Staff Access'),
                ],
                // padding:
                //     EdgeInsets.only(right: Adaptive.w(4), left: Adaptive.w(0)),
                dividerColor: Colors.transparent,
                // indicatorPadding: EdgeInsets.only(left: Adaptive.w(3)),
                labelPadding:
                    EdgeInsets.only(right: Adaptive.w(3), left: Adaptive.w(0)),
                indicatorSize: TabBarIndicatorSize.tab,
                controller: _tabController,
                tabAlignment: TabAlignment.fill,
                labelColor: const Color(0xFFED1C24),
                unselectedLabelColor: Colors.black,
                indicatorColor: const Color(0xFFED1C24),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    StatusTab(),
                    OngoingchatTab(),
                    StaffAccessTab()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
