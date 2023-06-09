// ignore_for_file: unnecessary_null_comparison, deprecated_member_use, file_names, library_private_types_in_public_api, unnecessary_new, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

import '../addIndividualEvent/controllers/add_individual_event_controller.dart';

class GetCropedImg extends StatefulWidget {
  @override
  _GetCropedImgState createState() => new _GetCropedImgState();
}

class _GetCropedImgState extends State<GetCropedImg> {
  final cropKey = GlobalKey<CropState>();
  File? _file;
  File? _sample;
  File? _lastCropped;

  @override
  void dispose() {
    super.dispose();
    // _file?.delete();
    //_sample?.delete();
    //_lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
        ),
      ),
    );
  }

  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_sample!, key: cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                child: Text(
                  'Crop Image',
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white),
                ),
                onPressed: () => _cropImage(),
              ),
              _buildOpenImage(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    return Column(
      children: [
        TextButton(
          child: Text(
            'Open Camera',
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.white),
          ),
          onPressed: () => _openImage(),
        ),
        TextButton(
          child: Text(
            'Open Gallery',
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.white),
          ),
          onPressed: () => _openGallery(),
        ),
      ],
    );
  }

  Future<void> _openImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    final file = File(pickedFile!.path);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size!.longestSide.ceil(),
    );

    //_sample?.delete();
    //_file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  Future<void> _openGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final file = File(pickedFile!.path);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size!.longestSide.ceil(),
    );

    //_sample?.delete();
    // _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState!.scale;
    final area = cropKey.currentState!.area;
    if (area == null) {
      // cannot crop, widget is not setup

      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file!,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    //sample.delete();

    //_lastCropped?.delete();
    // _lastCropped = file;

    debugPrint('$file');
    AddIndividualEventController.count.value = 1;
    AddIndividualEventController.picture = file;

    Get.back();
  }
}
