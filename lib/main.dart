import 'dart:io';

import 'package:flutter/material.dart';
import 'package:NRS_Quickchat/global_function/app_debug.dart';
import 'package:NRS_Quickchat/screens/home.dart';
import 'package:NRS_Quickchat/screens/livechat.dart';
import 'package:NRS_Quickchat/screens/login.dart';
import 'package:NRS_Quickchat/screens/listpage.dart';
import 'package:NRS_Quickchat/screens/splash.dart';
import 'package:NRS_Quickchat/services/getsharedpreferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:NRS_Quickchat/services/getit.dart' as getItSetup;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void checkPlatform() {
  if (Platform.isAndroid) {
    AppDebug().printDebug(msg: "Running on Android");
    GetSharedPreferences().setPlatform('android');
  } else if (Platform.isIOS) {
    AppDebug().printDebug(msg: "Running on iOS");
    GetSharedPreferences().setPlatform('ios');
  } else {
    AppDebug().printDebug(msg: "Running on an unsupported platform");
    GetSharedPreferences().setPlatform('');
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const initialRoute = '/splash';
  getItSetup.setup();

  runApp(const MyApp(initialRoute: initialRoute));
  // oneSignal();
}

oneSignal() {
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("66a840a5-04cc-4180-aaca-5b2430f39ae7");
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'NRS QuickChat',
            theme: ThemeData(
              // primarySwatch: Color(0xFFED1C24),
              scaffoldBackgroundColor: Colors.grey[50],
              // scaffoldBackgroundColor: Colors.black,
              primaryColor: Color(0xFFED1C24),
              useMaterial3: true,
              checkboxTheme: CheckboxThemeData(
                fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Color(0xFFED1C24);
                  }
                  return Colors.transparent;
                }),
                checkColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.white;
                  }
                  return Colors.transparent;
                }),
              ),
            ),
            initialRoute: initialRoute,
            routes: {
              '/splash': (context) => const Splash(),
              '/login': (context) => const Login(),
              '/home': (context) => const Home(),
              '/listpage': (context) => ListPage(),
              '/livechat': (context) => LiveChat(),
            });
      },
    );
  }
}
