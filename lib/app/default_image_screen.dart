import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pertypeople/app/modules/addOrganizationsEvent/controllers/add_organizations_event_controller.dart';
import 'package:pertypeople/cached_image_placeholder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'modules/addOrganizationsEvent2/controllers/add_organizations_event2_controller.dart';

class ImageScreen extends StatefulWidget {
  ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  List<String> defaultImages = [
    'https://firebasestorage.googleapis.com/v0/b/party-people-52b16.appspot.com/o/default_images%2F11557.jpg?alt=media&token=1b16ffd5-8cca-44d0-958c-8408d84f93c1',
    'https://firebasestorage.googleapis.com/v0/b/party-people-52b16.appspot.com/o/default_images%2Fexcited-audience-watching-confetti-fireworks-having-fun-music-festival-night-copy-space.jpg?alt=media&token=503abb47-5ab1-4b2a-b7ed-6d8d37ff311d',
    'https://firebasestorage.googleapis.com/v0/b/party-people-52b16.appspot.com/o/default_images%2Fpexels-cottonbro-studio-3171837.jpg?alt=media&token=178b84ad-9638-4c94-82d2-c4ab41b9e65e',
    'https://firebasestorage.googleapis.com/v0/b/party-people-52b16.appspot.com/o/default_images%2Fpexels-harrison-haines-3172566.jpg?alt=media&token=fd51a9f2-60f1-441e-b917-eacc2cba6c74',
    'https://firebasestorage.googleapis.com/v0/b/party-people-52b16.appspot.com/o/default_images%2Fpexels-maur%C3%ADcio-mascaro-1154189.jpg?alt=media&token=6d44a95b-bd1f-4526-a0f1-c087223847e5',
    'https://firebasestorage.googleapis.com/v0/b/party-people-52b16.appspot.com/o/default_images%2Fpexels-wendy-wei-1805895.jpg?alt=media&token=54cada80-90a2-4a9c-aefd-995916b6b755'
  ];

  AddOrganizationsEventController addOrganizationsEventController =
      Get.put(AddOrganizationsEventController());

  AddOrganizationsEvent2Controller addOrganizationsEvent2Controller =
      Get.put(AddOrganizationsEvent2Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Default Images"),
        ),
        body: ResponsiveGridList(
            horizontalGridMargin: 0,
            minItemWidth: Get.width,
            children: List.generate(
              defaultImages.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    print("Selected Default Image : ${defaultImages[index]}");
                    addOrganizationsEventController.timeline.value =
                        defaultImages[index];

                    addOrganizationsEvent2Controller.timeline.value =
                        defaultImages[index];
                    Navigator.pop(context);
                  });
                },
                child: CachedNetworkImageWidget(
                  imageUrl: defaultImages[index],
                  width: Get.width,
                  height: 300,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline),
                  placeholder: (context, url) => Center(
                      child: CupertinoActivityIndicator(
                          color: Colors.black, radius: 15)),
                ),
              ),
            )));
  }
}
