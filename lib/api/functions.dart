import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

String getBase64(File image) {
  List<int> imageBytes = image.readAsBytesSync();
  return base64Encode(imageBytes);
}

String? getBase64WithImg(File image) {
  Uint8List imageBytes = image.readAsBytesSync();
  img.Image? photo = img.decodeImage(imageBytes);
  if (photo != null) {
    final width = photo.width;
    final height = photo.height;
    final magnif = width > height ? 768 / height : 1024 / width;
    final resizedPhoto = img.copyResize(photo, width: (width * magnif).round(), height: (height * magnif).round());

    return base64Encode(resizedPhoto.toUint8List());
  } else {
    return null;
  }
}

Future<String> annotateImage(File image) async {
  final base64Image = getBase64(image);

  if (base64Image != null) {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('annotateImage');
    final params = '''{
          "image": {"content": "$base64Image"},
          "features": [{"type": "TEXT_DETECTION"}],
          "imageContext": {
            "languageHints": ["ja"]
          }
        }''';

    try {
      final text = await callable(params);
      return text.data[0]["fullTextAnnotation"]["text"];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      return Future.error(e);
    }
  } else {
    return Future.error("photo is null");
  }
}
