import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:showcaseview/showcaseview.dart';

import 'app/routes/app_pages.dart';

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
  await GetStorage.init();
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
        builder: Builder(
      builder: (context) => GetMaterialApp(
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
            ),
            child: child!),
        title: "Application",

        // home: SplashScreenMain(),
        initialRoute: Routes.ADD_ORGANIZATIONS_EVENT,
        // GetStorage().read('token') == null
        //     ?
        // initialRoute: Routes.PROFILE,
        // home: ProfileType(),
        // : Routes.ORGANIZATION_PROFILE_NEW,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    ));
  }
}
