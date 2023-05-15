import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

Future<String> annotateImage(File image) async {
  List<int> imageBytes = image.readAsBytesSync();
  String base64Image = base64Encode(imageBytes);
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
}
