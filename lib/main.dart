import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   // name: 'partyPeople',
    //options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp(
  //   name: 'partyPeople',
  //   options: DefaultFirebaseOptions.currentPlatform,
  // // options: DefaultFirebaseOptions.currentPlatform,
  // );
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
    return GetMaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!),
      title: "Application",
      initialRoute: GetStorage().read('token') != null
          ? Routes.DASHBORD
          : AppPages.INITIAL,
      //initialRoute: Routes.CUST_PROFILE,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
