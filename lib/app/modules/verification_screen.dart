import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
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
        title: Text("Verification"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Text(
                "Thank you for choosing our app for your needs. To ensure the safety and security of our users, we require all users to complete a verification process. As a part of this process, we need you to sign and seal the attached agreement and upload a scanned copy of the same.\n\n"
                "This agreement outlines the terms and conditions of using our app, and we highly recommend that you read it thoroughly before signing. By signing this agreement, you agree to comply with all the terms and conditions mentioned herein.\n\n"
                "Once we receive the signed agreement, our team will review and verify your account. If the verification process is successful, you will receive a verification status that will build trust with the customers.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                launchUrl(_url);
              },
              child: Text("Download PDF")),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              FilePickerResult? result =
                  await FilePicker.platform.pickFiles(allowMultiple: true);

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
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
            child: Text("Upload PDF"),
          ),
        ],
      ),
    );
  }
}
