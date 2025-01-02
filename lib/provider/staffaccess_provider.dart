import 'package:NRS_Quickchat/global_function/app_debug.dart';
import 'package:flutter/material.dart';

class StaffaccessProvider extends ChangeNotifier {
  bool isError = false;
  bool get getIsError => isError;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  String? _failure;
  String? get failure => _failure;

  String userPosition = '';
  String get getUserPosition => userPosition;

  Map responseData = {};
  Map get getResponseData => responseData;

  List staffData = [
    {
      'staffcode': 'SH10334 (83)',
      'staffname': 'SOH SEH YEE',
      'selected': false
    },
    {
      'staffcode': 'SH10567 (29)',
      'staffname': 'LEE CHONG WEI',
      'selected': false
    },
    {
      'staffcode': 'SH10789 (56)',
      'staffname': 'TAN BOON HEONG',
      'selected': false
    },
    {
      'staffcode': 'SH10921 (12)',
      'staffname': 'WONG MEW CHOO',
      'selected': false
    },
    {
      'staffcode': 'SH11034 (47)',
      'staffname': 'CHONG WEI LING',
      'selected': false
    },
    {
      'staffcode': 'SH11245 (38)',
      'staffname': 'LIM CHONG YEW',
      'selected': false
    },
    {
      'staffcode': 'SH11367 (44)',
      'staffname': 'GOH LIU YING',
      'selected': false
    },
    {
      'staffcode': 'SH11589 (23)',
      'staffname': 'TAN KAH YING',
      'selected': false
    },
    {'staffcode': 'SH11801 (52)', 'staffname': 'NG HUI LIN', 'selected': false},
    {
      'staffcode': 'SH12023 (19)',
      'staffname': 'CHAN PENG SOON',
      'selected': false
    },
    {
      'staffcode': 'SH12234 (61)',
      'staffname': 'LEE SIN YEE',
      'selected': false
    },
    {
      'staffcode': 'SH12456 (33)',
      'staffname': 'HOH KOK HOI',
      'selected': false
    },
  ];
  List get getStaffData => staffData;

  List filteredStaffData = [];
  List get getfilteredStaffData => filteredStaffData;

  void _setFailure(failure) {
    _failure = failure;
    AppDebug().printDebug(msg: 'staff access provider failure: $failure');
    notifyListeners();
  }

  Future<void> clearData() async {
    isError = false;
    _isFetching = false;
    _failure = null;
    responseData.clear();
    userPosition = '';
    // notifyListeners();
  }

  Future<void> setStaffData(List staffData) async {
    filteredStaffData = staffData;

    notifyListeners();
  }

  Future fetchStaffData({String? username, String? password}) async {
    _setFailure(null);
    _isFetching = true;
    notifyListeners();
    var res;
    try {
      res = staffData;
    } catch (e) {
      AppDebug().printDebug(msg: 'error in catch :$e');
    } finally {
      _isFetching = false;
      notifyListeners();
    }

    _setFailure(null);

    return res;
  }
}
