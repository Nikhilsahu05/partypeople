import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pertypeople/app/modules/addOrganizationsEvent/views/mapscreen.dart';
import 'package:pertypeople/app/modules/addOrganizationsEvent/views/mapscreen2.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Assign publishable key to flutter_stripe
  Stripe.publishableKey =
      "pk_live_51M4TemSDWijp4rP3mtTpPwsdZTwZdfDlqd4qFUtyOQRbHKNdPfy1UdNksgTjkpBazL1dOkIM5d4m09CaHPrmoXSY00i87UkW20";
  Stripe.merchantIdentifier = 'any string works';
  await Stripe.instance.applySettings();
  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");

  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission();
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined permission');
  }
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received message in foreground: ${message.notification?.title}');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Opened app from background: ${message.notification?.title}');
  });

  await GetStorage.init();
  print(GetStorage().read('token'));
  runApp(
    App(),
  );
}

class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ///Implementing notiifations

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return ShowCaseWidget(
          builder: Builder(
        builder: (context) => GetMaterialApp(
          builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: true,
              ),
              child: child!),
          title: "Application",
          routes: {
            'MapScreen': (p0) => MapScreen(),
            'MapScreen2': (p0) => MapScreen2(),
          },
          initialRoute: GetStorage().read('token') == null
              ? AppPages.INITIAL
              //   : Routes.ORGANIZATION_PROFILE_NEW,
              : Routes.ORGANIZATION_PROFILE_NEW,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        ),
      ));
    });
  }
}
