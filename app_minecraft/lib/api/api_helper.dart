// Le but : centraliser les appels a l'api

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dio/dio_provider.dart';

final apiHelperProvider = Provider<ApiHelper>((ref){
  var dio = ref.watch(dioProvider);
  return ApiHelper(dio:dio);
});

class ApiHelper{
  ApiHelper({required this.dio});
  final Dio dio;
  final List<String> version = [
    "0.30c",
    "1.7",
    "1.8",
    "15w40b",
    "1.9",
    "1.9.1-pre2",
    "1.9.2",
    "1.9.4",
    "16w20a",
    "1.10-pre1",
    "1.10",
    "1.10.1",
    "1.10.2",
    "16w35a",
    "1.11",
    "1.11.2",
    "17w15a",
    "17w18b",
    "1.12-pre4",
    "1.12",
    "1.12.1",
    "1.12.2",
    "17w50a",
    "1.13",
    "1.13.1",
    "1.13.2-pre1",
    "1.13.2-pre2",
    "1.13.2",
    "1.14",
    "1.14.1",
    "1.14.3",
    "1.14.4",
    "1.15",
    "1.15.1",
    "1.15.2",
    "20w13b",
    "20w14a",
    "1.16-rc1",
    "1.16",
    "1.16.1",
    "1.16.2",
    "1.16.3",
    "1.16.4",
    "21w07a",
    "1.17",
    "1.17.1",
    "1.18",
    "1.18.1",
    "1.18.2",
    "1.19",
    "1.19.2",
    "1.19.3",
    "1.19.4",
    "1.20",
    "1.20.1",
    "1.20.2",
    "1.20.3",
    "1.20.4",
    "1.20.5",
    "1.20.6",
    "1.21.1",
    "1.21.3",
    "1.21.4"
  ];

  void get() async {
    final url = 'http:// /';

    try {
      final response = await dio.get(url);
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}

