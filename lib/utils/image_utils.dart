import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';

Future<File> compressImageFile(File file) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.path,
    file.path,
    minWidth: 612,
    minHeight: 816,
    quality: 40,
  );
  return result;
}

Future<String> base64FromFile(pickedFile) async {
  var file = await compressImageFile(pickedFile);
  if (file == null) return null;
  List<int> imageBytes = file.readAsBytesSync();
  var codec = Base64Codec();
  String encoded = codec.encode(imageBytes);
  return encoded;
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      .buffer
      .asUint8List();
}

Future<File> getImageFileFromByteData(ByteData byteData, String name) async {
  final file = File(
      '${(await getTemporaryDirectory()).path}/${name}_${DateTime.now().millisecondsSinceEpoch}.png');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

Future<File> getImageFileFromUint8List(Uint8List list, String name) async {
  final file = File(
      '${(await getTemporaryDirectory()).path}/${name}_${DateTime.now().millisecondsSinceEpoch}.png');
  await file.writeAsBytes(list);
  return file;
}
