import 'package:get/get.dart';

class IndividualDashboardController extends GetxController {
  var buttonState = true;

  void switchButtonState() {
    if (buttonState == true) {
      buttonState = false;
    } else {
      buttonState = true;
    }
  }
}
