import 'dart:convert';
import 'package:flutter/foundation.dart';

class Data {
  Map<String, dynamic>? objectData;

  Data(String stringData) {
    try {
      objectData = jsonDecode(stringData);
    } catch (e) {
      if (kDebugMode) {
        print("Error with the JSON: $e");
      }
      objectData = {};
    }
  }
}
