import 'package:NRS_Quickchat/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:NRS_Quickchat/global_function/app_debug.dart';
import 'package:NRS_Quickchat/widget/custom_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StaffAccessTab extends ConsumerStatefulWidget {
  const StaffAccessTab({super.key});

  @override
  ConsumerState<StaffAccessTab> createState() => _StaffAccessTabState();
}

class _StaffAccessTabState extends ConsumerState<StaffAccessTab>
// with AutomaticKeepAliveClientMixin
{
  @override
  // bool get wantKeepAlive => true;
  bool selectedValue = false;
  List staffData = [];
  TextEditingController searchController = TextEditingController();
  List filteredStaffData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    searchController.addListener(_filterStaff);
  }

  fetchData() {
    Future.microtask(() async {
      setState(() {
        isLoading = true;
      });
      await ref.read(staffaccessProvider).fetchStaffData();
      staffData = ref.read(staffaccessProvider).getStaffData;
      filteredStaffData = staffData;
      AppDebug().printDebug(msg: 'staffData in fetchdata:$filteredStaffData');
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    AppDebug().printDebug(msg: 'in dispose staffaccess tab');

    searchController.removeListener(_filterStaff);
    searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    try {
      fetchData();
      AppDebug().printDebug(msg: 'Data Refresh Successful');
    } catch (e) {
      AppDebug().printDebug(msg: 'Error during data refresh: $e');
    }
  }

  Future<void> _filterStaff() async {
    String query = searchController.text.toLowerCase();
    filteredStaffData = staffData
        .where((staff) =>
            staff['staffcode'].toLowerCase().contains(query) ||
            staff['staffname'].toLowerCase().contains(query))
        .toList();
    AppDebug()
        .printDebug(msg: 'filtered list after click yes:$filteredStaffData');
    // await ref.read(staffaccessProvider).setStaffData(filteredStaffData);
  }

  assignStaff(int index, bool value, String staffcode) {
    String assign = value ? 'Enable' : 'Disable';

    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: CustomModal(
              isCloseButton: true,
              onClose: () {},
              title: '$assign Staff',
              subtitle: '$assign this staff $staffcode to access?',
              button: 'YES',
              button2: 'NO',
              onNext: () async {
                await toggleStaffSelection(index);
              },
              onCancel: () {},
            ),
          );
        });
  }

  Future<void> toggleStaffSelection(int index) async {
    setState(() {
      isLoading = true;
    });
    staffData[index]['selected'] = !staffData[index]['selected'];
    staffData.sort((a, b) => (b['selected'] ? 1 : 0) - (a['selected'] ? 1 : 0));
    await _filterStaff();
    setState(() {
      isLoading = false;
    });
  }

  Widget staffContainer(
      int index, String staffcode, String staffname, bool isSelected) {
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
              Switch(
                value: isSelected,
                // controller: ValueNotifier<bool>(isSelected),
                // width: 40.0,
                // height: 20.0,
                activeTrackColor: Colors.red,
                inactiveTrackColor: Colors.white,
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
    // super.build(context);
    final staffAccessProvider = ref.watch(staffaccessProvider);

    AppDebug().printDebug(msg: 'build 123');
    return isLoading || staffAccessProvider.isFetching
        ? const CircularProgressIndicator.adaptive(
            strokeWidth: 5,
            strokeAlign: CircularProgressIndicator.strokeAlignCenter,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFED1C24)),
          )
        : SafeArea(
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
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontSize: 12),
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
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 5),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintStyle: TextStyle(
                                    fontFamily: 'Poppins', color: Colors.grey),
                                hintText: 'Search'),
                            style: const TextStyle(
                                fontFamily: 'Poppins', fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      color: Color(0xFFED1C24),
                      backgroundColor: Colors.white,
                      onRefresh: _refreshData,
                      child: ListView.builder(
                          itemCount: filteredStaffData.length,
                          itemBuilder: (context, index) {
                            String staffcode =
                                filteredStaffData[index]['staffcode'];
                            String staffname =
                                filteredStaffData[index]['staffname'];
                            bool isSelected =
                                filteredStaffData[index]['selected'];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: staffContainer(
                                  index, staffcode, staffname, isSelected),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
