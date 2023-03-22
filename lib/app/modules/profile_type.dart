import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../routes/app_pages.dart';

class ProfileType extends StatelessWidget {
  const ProfileType({Key? key}) : super(key: key);

  _onBasicWaitingAlertPressed(context) async {
    await Alert(
      context: context,
      title: "Coming Soon!",
      desc:
          "We are excited to announce that a new feature is coming soon to your profile! Our team has been hard at work developing this feature to enhance your experience and provide you with even more tools to connect with others and share your passions.",
    ).show();

    // Code will continue after alert is closed.
    debugPrint("Alert closed now.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/red_background.png',
                ),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            SizedBox(
              height: 160,
            ),
            Expanded(
                flex: 5,
                child: GestureDetector(
                  onTap: () {
                    _onBasicWaitingAlertPressed(context);
                  },
                  child: Container(
                    height: 100,
                    width: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      elevation: 18,
                      child:
                          Lottie.asset('assets/57946-profile-user-card.json'),
                    ),
                  ),
                )),
            Text(
              "Individual",
              style: GoogleFonts.oswald(
                  fontSize: 35,
                  fontWeight: FontWeight.w200,
                  letterSpacing: 1.5,
                  color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 5,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.ADD_ORGANIZATIONS_EVENT);
                  },
                  child: Container(
                    height: 100,
                    width: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      elevation: 18,
                      child: Lottie.asset('assets/dlf10_Sw60y11Cpf.json'),
                    ),
                  ),
                )),
            Text(
              "Organizations",
              style: GoogleFonts.oswald(
                  fontSize: 35,
                  fontWeight: FontWeight.w200,
                  letterSpacing: 1.5,
                  color: Colors.white),
            ),
            SizedBox(
              height: 160,
            ),
          ],
        ),
      ),
    );
  }
}
