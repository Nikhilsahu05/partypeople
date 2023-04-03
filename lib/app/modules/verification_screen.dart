import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final Uri _url = Uri.parse(
      "https://drive.google.com/drive/folders/1XotL5lrIm7v-mNHAoALjiNQjiZ9ft69G?usp=share_link");

  getDownloadablePDF() async {
    http.Response response = await http.post(
        Uri.parse('http://manage.partypeople.in/v1/party/organization_pdf'),
        headers: {
          'x-access-token': GetStorage().read("token").toString(),
        });

    print(response.body);
  }

  @override
  void initState() {
    getDownloadablePDF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Verification",
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: Get.height * 0.20,
                  child: Lottie.asset("assets/120628-verification.json"),
                ),
              ),
              Text(
                "Thank you for choosing our app for your needs. To ensure the safety and security of our users, we require all users to complete a verification process.",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "As a part of this process, we need you to sign and seal the attached agreement and upload a scanned copy of the same.",
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "This agreement outlines the terms and conditions of using our app, and we highly recommend that you read it thoroughly before signing. By signing this agreement, you agree to comply with all the terms and conditions mentioned herein.",
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: Container(
                  width: 60.w,
                  child: ElevatedButton(
                    onPressed: () {
                      launchUrl(_url);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      textStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.download,
                          size: 14,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Download PDF",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: Container(
                  width: 60.w,
                  child: ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);

                      if (result != null) {
                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "PDF Uploaded",
                          desc:
                              "Thank You for Uploading, Your Document is Under Verification.",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      } else {
                        // User canceled the picker
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      textStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.upload,
                          size: 14,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Upload PDF",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
