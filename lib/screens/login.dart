import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:NRS_Quickchat/global_function/app_back_button.dart';
import 'package:NRS_Quickchat/global_function/app_debug.dart';
import 'package:NRS_Quickchat/services/package_info.dart';
import 'package:NRS_Quickchat/widget/custom_button.dart';
import 'package:NRS_Quickchat/widget/custom_modal.dart';
import 'package:NRS_Quickchat/widget/custom_textfield.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final AppDeviceBackBtn backBtnHandler = AppDeviceBackBtn();
  TextEditingController staffcodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode staffcodeFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  String? errorMessagestaffcode;
  String? errorMessagePassword;
  String version = '';
  String errorMessage = '';
  String appVersion = '';
  String buildNumber = '';
  // final errorMessageService = GetIt.instance<ErrorMessageService>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    AppDebug().printDebug(msg: 'init login;');
    _initPackageInfo();
    // staffcodeFocusNode.addListener(() {
    //   setState(() {});
    // });
    // passwordFocusNode.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    AppDebug().printDebug(msg: 'dispose login;');
    staffcodeController.dispose();
    passwordController.dispose();
    staffcodeFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  clearForm() {
    staffcodeController.clear();
    passwordController.clear();
  }

  // signIn() async {
  //   setState(() {
  //     errorMessagestaffcode = null;
  //     errorMessagePassword = null;
  //     isLoading = true;
  //   });

  //   final staffcode = staffcodeController.text;
  //   final password = passwordController.text;

  //   var response;
  //   try {
  //     response = await LoginProvider()
  //         .fetchLogin(staffcode: staffcode, password: password);
  //     AppDebug().printDebug(msg: 'response sign in:$response');
  //     if (response['status'] == '1') {
  //       AppDebug().printDebug(msg: 'success login:$response');
  //       AppDebug().printDebug(msg: 'position:${response['LIST']['POSITION']}');
  //       await GetSharedPreferences().setLastLoginStatus(true);
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (context) => BottomNavBarWrapper(child: Home())));
  //       ref.read(bottomNavNotifierProvider.notifier).setIndex(0);
  //       clearForm();
  //     } else {
  //       //response['status'] == '0'
  //       AppDebug().printDebug(msg: 'fail login:${response['status_message']}');
  //       GlobalUtils.showFloatingMessage(context, response['status_message']);
  //     }
  //   } catch (e) {
  //     AppDebug().printDebug(msg: 'Error Sign In: ${e.toString()}');
  //     final errorMessage = errorMessageService.getErrorMessage();
  //     if (errorMessage != null && errorMessage.isNotEmpty) {
  //       showCustomDialog(context, '', errorMessage, 'OK', () {
  //         errorMessageService.clearErrorMessage();
  //       });
  //     }
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   }
  // }

  Future<void> _initPackageInfo() async {
    try {
      appVersion = await AppInfo.getAppVersion();
      buildNumber = await AppInfo.getBuildNumber();
      setState(() {
        appVersion = appVersion;
        buildNumber = buildNumber;
      });
    } catch (e) {
      print('Error initializing package info: $e');
    }
  }

  openModal() {
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CustomModal(
            isCloseButton: true,
            isImagePresent: true,
            title: 'Welcome back,',
            staffCode: staffcodeController.text,
            button2: '',
            onNext: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            onCancel: () {},
            onClose: () {},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, dynamic) async {
        await backBtnHandler.popped(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/quick_response.png',
                      height: Adaptive.h(25),
                      width: Adaptive.w(80),
                    ),
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: Adaptive.w(6), top: Adaptive.h(0)),
                      child: const Text(
                        'Welcome back.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                          letterSpacing: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: Adaptive.w(7), top: Adaptive.h(0)),
                      child: const Text(
                        'Log in to your account',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          letterSpacing: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(4),
                ),
                Row(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextfield(
                            width: Adaptive.w(88),
                            padding: EdgeInsets.only(
                              left: Adaptive.w(6),
                              top: Adaptive.h(0),
                              bottom: Adaptive.h(0),
                            ),
                            labelText: 'Staff Code',
                            controller: staffcodeController,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value == '') {
                                return '*Please enter your staff code';
                              }
                              return null;
                            },
                            focusNode: staffcodeFocusNode,
                            floatingLabelBehavior: staffcodeFocusNode.hasFocus
                                ? FloatingLabelBehavior.auto
                                : FloatingLabelBehavior.never,
                            obscureText: false,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(0.5),
                ),
                Row(
                  children: [
                    Form(
                      key: _formKey2,
                      child: CustomTextfield(
                        height: Adaptive.h(10),
                        width: Adaptive.w(88),
                        padding: EdgeInsets.only(left: Adaptive.w(6)),
                        // hintText: passwordFocusNode.hasFocus ? '' : 'Password',
                        labelText: 'Password',
                        controller: passwordController,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value == '') {
                            return '*Please enter your password';
                          }
                          return null;
                        },
                        focusNode: passwordFocusNode,
                        floatingLabelBehavior: passwordFocusNode.hasFocus
                            ? FloatingLabelBehavior.auto
                            : FloatingLabelBehavior.never,
                        obscureText: true,
                        suffixIcon: const Icon(
                          Icons.visibility,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(5),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Adaptive.w(6)),
                      child: CustomButton(
                          backgroundColor: const Color(0xFFEA1C24),
                          color: Colors.white,
                          // height: Adaptive.h(0),
                          width: Adaptive.w(88),
                          onPressed: () {
                            openModal();

                            // if (_formKey.currentState!.validate() &&
                            //     _formKey2.currentState!.validate()) {
                            //   signIn();
                            // }
                          },
                          title: 'LOGIN'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: Adaptive.h(2)),
              child: Text(
                'Version : $appVersion.$buildNumber',
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFFEA1C24),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
