import 'package:flutter/material.dart';
import 'package:NRS_Quickchat/global_function/app_debug.dart';
import 'package:NRS_Quickchat/screens/livechat.dart';
import 'package:NRS_Quickchat/widget/custom_appbar.dart';
import 'package:NRS_Quickchat/widget/custom_button.dart';
import 'package:NRS_Quickchat/widget/custom_dialog.dart';
import 'package:NRS_Quickchat/widget/custom_modal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class QuickChatDetails extends StatefulWidget {
  const QuickChatDetails({super.key});

  @override
  State<QuickChatDetails> createState() => _QuickChatDetailsState();
}

class _QuickChatDetailsState extends State<QuickChatDetails> {
  bool isOpenModal = false;
  List dataList = [
    {
      'P1no': '6272317700000000103',
      'name': 'Gan Poh Yin',
      'mobileNo': '01234567890',
      'subject': 'Delivery',
      'message': 'Im doing testing for ios',
      'status': 'Pending',
      'branch': '83',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'QUICKCHAT DETAILS'),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Adaptive.h(2),
                ),
                buildForm('P1 No', dataList[0]['P1no']),
                buildForm('Name', dataList[0]['name']),
                buildForm('Mobile No', dataList[0]['mobileNo']),
                buildForm('Subject', dataList[0]['subject']),
                buildForm('Message', dataList[0]['message']),
                buildForm('Status', dataList[0]['status']),
                buildForm('Nearest Branch', dataList[0]['branch']),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomButton(
                  backgroundColor: Colors.white,
                  color: const Color(0xFFED1C24),
                  borderSide: const Color(0xFFED1C24),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LiveChat(
                          name: dataList[0]['name'].toUpperCase(),
                        ),
                      ),
                    );
                  },
                  title: 'LIVE CHAT',
                  width: Adaptive.w(95),
                  isNotification: true,
                  textNotification: '2',
                ),
                SizedBox(
                  height: Adaptive.h(1),
                ),
                CustomButton(
                  color: Colors.white,
                  backgroundColor: Color(0xFFED1C24),
                  borderSide: Color(0xFFED1C24),
                  onPressed: () {
                    // showCustomDialog(
                    //     context, '', 'Are you sure to submit?', 'OK', () {});

                    openModal();
                  },
                  title: 'MARK AS RESOLVED',
                  width: Adaptive.w(95),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget buildForm(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        width: Adaptive.w(95),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openModal() {
    // isOpenModal = true;
    // AppDebug().printDebug(msg: 'isopenmodal:$isOpenModal');
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: CustomModal(
              title: 'Enquiry Resolved',
              subtitle:
                  'The enquiry is successfully resolved and will be closed.',
              button: 'OK',
              onNext: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          );
        });
  }
}
