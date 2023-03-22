import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../routes/app_pages.dart';
import 'subscription_model.dart';

class SubscriptionController extends GetxController {
  //TODO: Implement SubscriptionController

  int count = -1.obs;
  Subscriptions? subscriptions;
  var isLoading = false.obs;
  RxInt quantitySelect = 1.obs;
  RxInt discountPercentage = 1.obs;
  RxInt subscriptionAmount = 499.obs;
  RxInt totalAmount = 499.obs;

  @override
  void onInit() {
    super.onInit();
    getSub();
  }

  createPaymentIntent(amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': (int.parse(amount) * 100).toString(),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // oderIdPlaced();

      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));
        // paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  ///Call this function if payment was successfull
  oderIdPlaced(String partyID) async {
    http.Response response = await http.post(
        Uri.parse('https://manage.partypeople.in/v1/order/create_order'),
        body: {'party_id': partyID, 'amount': '499', 'papular_status': '1'},
        headers: {"x-access-token": GetStorage().read("token")});
    initPaymentSheet('');

    print(jsonDecode(response.body));

    Get.snackbar('Success', '${jsonDecode(response.body)['message']}');
    Get.offAllNamed(Routes.ORGANIZATION_PROFILE_NEW);
  }

  Future<void> initPaymentSheet(String amount) async {
    try {
      // 1. create payment intent on the server
      final paymentSheetData = await createPaymentIntent(amount, 'inr');
      print("Payment intent created");

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        style: ThemeMode.dark,
        merchantDisplayName: 'Prospects',
        customerId: paymentSheetData!['customer'],
        paymentIntentClientSecret: paymentSheetData['client_secret'],
        customerEphemeralKeySecret: paymentSheetData['ephemeralKey'],
      ));
      print("payment sheet created");

      await Stripe.instance.presentPaymentSheet();
      oderIdPlaced('');
      print("after payment sheet presented");
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: $e");
      }
      rethrow;
    }
  }

  Future<void> getSub() async {
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      // 'Cookie': 'ci_session=f72b54d682c45ebf19fcc0fd54cef39508588d0c'
    };
    isLoading = true.obs;
    var response = await Dio().get(
        'https://manage.partypeople.in/v1/party/subscriptions',
        options: Options(headers: headers));

    debugPrint(response.data.toString());

    if (response.statusCode == 200) {
      subscriptions = Subscriptions.fromJson(response.data);
      isLoading = false.obs;
    } else {
      Get.snackbar("Hy", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3));
      isLoading = false.obs;
    }
  }
}
