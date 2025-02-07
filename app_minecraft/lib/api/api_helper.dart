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

  void get() async {
    final url = 'https://google.com';

    try {
      final response = await dio.get(url);
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}

