import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dio/dio_provider.dart';
import '../db/database_helper.dart';

final apiHelperProvider = Provider<ApiHelper>((ref) {
  var dio = ref.watch(dioProvider);
  return ApiHelper(dio: dio);
});

class ApiHelper {
  ApiHelper({required this.dio});
  final Dio dio;
  final List<String> version = [
    "1.21.4",
    "1.21.3",
    "1.21.1",
    "1.20.6",
    "1.20.5",
    "1.20.4",
    "1.20.3",
    "1.20.2",
    "1.20.1",
    "1.20",
    "1.19.4",
    "1.19.3",
    "1.19.2",
    "1.19",
    "1.18.2",
    "1.18.1",
    "1.18",
    "1.17.1",
    "1.17",
    "1.16.4",
    "1.16.3",
    "1.16.2",
    "1.16.1",
    "1.16",
    "1.15.2",
    "1.15.1",
    "1.15",
    "1.14.4",
    "1.14.3",
    "1.14.1",
    "1.14",
    "1.13.2",
    "1.13.1",
    "1.13",
    "1.12.2",
    "1.12.1",
    "1.12",
    "1.11.2",
    "1.11",
    "1.10.2",
    "1.10.1",
    "1.10",
    "1.9.4",
    "1.9.2",
    "1.9",
    "1.8",
    "1.7"
  ];
  Map<String, dynamic>? data;

  Future<Response> get() async {
    final url = 'http://62.72.18.63:5713/items';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final items = response.data as List<dynamic>;
      final dbHelper = DatabaseHelper();

      for (var item in items) {
        await dbHelper.insertItem({
          'name': item['name'],
          'type': item['type'],
          'version': item['version'],
        });
      }
    }

    return response;
  }
}
