import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

import '../api/api_helper.dart';

final dataStoreProvider =
StateNotifierProvider<DataStore, DataStoreState>((ref) {
  var apiHelper = ref.watch(apiHelperProvider);
  return DataStore(api: apiHelper);
});

class DataStore extends StateNotifier<DataStoreState> {
  final ApiHelper api;

  DataStore({required this.api}) : super(DataStoreState.init());

  void setData() {
    api.get();
    List<dynamic> jsonData = jsonDecode(api.data);
    state = state.copyWith(jsonData);
  }
}

class DataStoreState {
  final List<dynamic>? data ;

  DataStoreState({this.data});

  factory DataStoreState.init() {
    return DataStoreState();
  }

  DataStoreState copyWith(List<dynamic>? data) {
    return DataStoreState(
      data: data ?? this.data,
    );
  }
}