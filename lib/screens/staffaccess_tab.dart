import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:NRS_Quickchat/global_function/app_debug.dart';
import 'package:NRS_Quickchat/widget/custom_modal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StaffAccessTab extends StatefulWidget {
  const StaffAccessTab({super.key});

  @override
  State<StaffAccessTab> createState() => _StaffAccessTabState();
}

class _StaffAccessTabState extends State<StaffAccessTab> {
  bool selectedValue = false;
  List<ValueNotifier<bool>> controllers = [];
  List staffData = [
    {'staffcode': 'SH10334 (83)', 'staffname': 'SOH SEH YEE'},
    {'staffcode': 'SH10567 (29)', 'staffname': 'LEE CHONG WEI'},
    {'staffcode': 'SH10789 (56)', 'staffname': 'TAN BOON HEONG'},
    {'staffcode': 'SH10921 (12)', 'staffname': 'WONG MEW CHOO'},
    {'staffcode': 'SH11034 (47)', 'staffname': 'CHONG WEI LING'},
    {'staffcode': 'SH11245 (38)', 'staffname': 'LIM CHONG YEW'},
    {'staffcode': 'SH11367 (44)', 'staffname': 'GOH LIU YING'},
    {'staffcode': 'SH11589 (23)', 'staffname': 'TAN KAH YING'},
    {'staffcode': 'SH11801 (52)', 'staffname': 'NG HUI LIN'},
    {'staffcode': 'SH12023 (19)', 'staffname': 'CHAN PENG SOON'},
    {'staffcode': 'SH12234 (61)', 'staffname': 'LEE SIN YEE'},
    {'staffcode': 'SH12456 (33)', 'staffname': 'HOH KOK HOI'},
  ];
  TextEditingController searchController = TextEditingController();
  List filteredStaffData = [];

  @override
  void initState() {
    super.initState();
    controllers =
        List.generate(staffData.length, (index) => ValueNotifier<bool>(false));
    filteredStaffData = staffData;
    searchController.addListener(_filterStaff);
  }

  @override
  void dispose() {
    AppDebug().printDebug(msg: 'in dispose staffaccess tab');

    searchController.removeListener(_filterStaff);
    searchController.dispose();
    super.dispose();
  }

  void _filterStaff() {
    setState(() {
      filteredStaffData = staffData.where((staff) {
        String staffcode = staff['staffcode'].toLowerCase();
        String staffname = staff['staffname'].toLowerCase();
        String query = searchController.text.toLowerCase();
        return staffcode.contains(query) || staffname.contains(query);
      }).toList();
    });
  }

  assignStaff(int index, bool value, String staffcode) {
    String? assign;
    value ? assign = 'Enable' : assign = 'Disable';
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: CustomModal(
              isCloseButton: true,
              onClose: () {
                controllers[index].value = !value;
                Navigator.pop(context);
              },
              title: '$assign Staff',
              subtitle: '$assign this staff $staffcode to access?',
              button: 'YES',
              button2: 'NO',
              onNext: () {
                setState(() {
                  controllers[index].value = value;
                });
              },
              onCancel: () {
                controllers[index].value = !value;
                Navigator.pop(context);
              },
            ),
          );
        });
  }

  Widget staffContainer(int index, String staffcode, String staffname) {
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
                staffcode,
                style: const TextStyle(
                    fontFamily: 'Poppins', color: Colors.red, fontSize: 13),
              ),
              Text(staffname,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w300))
            ],
          ),
          Column(
            children: [
              AdvancedSwitch(
                controller: controllers[index],
                width: 40.0,
                height: 20.0,
                activeColor: Colors.red,
                initialValue: controllers[index].value,
                onChanged: (value) {
                  assignStaff(index, value, staffcode);
                },
              ),
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Adaptive.h(2),
              ),
              child: Center(
                child: Text(
                  'AutoReply (-) ${DateTime.now()}',
                  style: const TextStyle(
                      fontFamily: 'Poppins', color: Colors.grey, fontSize: 12),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.only(
                left: Adaptive.w(3),
                right: Adaptive.w(3),
                top: Adaptive.h(0),
              ),
              height: Adaptive.h(6),
              width: Adaptive.w(90),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                  const Icon(
                    Icons.search_sharp,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: TextField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: searchController,
                      enableInteractiveSelection: false,
                      cursorColor: Colors.red,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          focusedBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins', color: Colors.grey),
                          hintText: 'Search'),
                      style:
                          const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: filteredStaffData.length,
                  itemBuilder: (context, index) {
                    String staffcode = filteredStaffData[index]['staffcode'];
                    String staffname = filteredStaffData[index]['staffname'];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: staffContainer(index, staffcode, staffname),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
