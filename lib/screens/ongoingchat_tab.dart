import 'package:NRS_Quickchat/screens/livechat.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OngoingchatTab extends StatefulWidget {
  const OngoingchatTab({super.key});

  @override
  State<OngoingchatTab> createState() => _OngoingchatTabState();
}

class _OngoingchatTabState extends State<OngoingchatTab> {
  List ongoingChat = [
    {'name': 'Salmi Mohd', 'subject': 'Online order delivery'},
    {'name': 'Salmi Mohd', 'subject': 'Online order delivery'},
    {'name': 'Salmi Mohd', 'subject': 'Online order delivery'},
    {'name': 'Salmi Mohd', 'subject': 'Online order delivery'},
    {'name': 'Salmi Mohd', 'subject': 'Online order delivery'},
    {'name': 'Salmi Mohd', 'subject': 'Online order delivery'},
    {'name': 'Salmi Mohd', 'subject': 'Online order delivery'},
    {'name': 'Salmi Mohd', 'subject': 'Online order delivery'},
    {'name': 'Salmi Mohd', 'subject': 'Online order delivery'},
    {'name': 'Salmi Mohd', 'subject': 'Online order delivery'},
  ];

  Widget custContainer(int index, String custName, String subject) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Adaptive.w(3),
      ),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                custName,
                style: const TextStyle(
                    fontFamily: 'Poppins', color: Colors.black, fontSize: 13),
              ),
              Text(subject,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w300))
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.only(top: Adaptive.h(2)),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: ongoingChat.length,
                  itemBuilder: (BuildContext context, int index) {
                    String custName = ongoingChat[index]['name'];
                    String subject = ongoingChat[index]['subject'];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LiveChat(
                                    name: custName,
                                  ),
                                ));
                          },
                          child: custContainer(index, custName, subject)),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
