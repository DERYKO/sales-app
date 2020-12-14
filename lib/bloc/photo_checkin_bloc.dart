import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;
import 'package:path_provider/path_provider.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

/*
class PhotoCheckinBloc extends Bloc {
  TextEditingController shopNameCtrl;
  File image;
  CameraController controller;
  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  Future<String> takePicture() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath =
        '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    debugPrint("${e.code}, ${e.description}");
  }

  void capturePhoto() async {
    String imagePath = await takePicture();

    if (imagePath != null) {
      image = File(imagePath);
      pop(image);
      notifyChanges();
    }
  }

  void cancelImage() {
    image = null;
    notifyChanges();
  }

  void confirmImage() async {
    bool start = await confirm(
      "Are you sure you want to checkin?",
      "",
    );
    if (start) {
      pop(image);
    } else {
      pop();
    }
  }

  double get areaHeight => context.size.height * controller.value.aspectRatio;

  @override
  void initState() {
    super.initState();
    print("Cameras $cameras");
    controller = CameraController(cameras.last, ResolutionPreset.medium,
        enableAudio: false);
    controller.initialize().then((_) {
      notifyChanges();
    });
  }
}
*/
