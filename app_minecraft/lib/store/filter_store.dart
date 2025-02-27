import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_minecraft/app_const.dart';

import '../api/api_helper.dart';

final filterStoreProvider =
StateNotifierProvider<FilterStore, FilterStoreState>((ref) {
  var apiHelper = ref.watch(apiHelperProvider);
  return FilterStore(api: apiHelper);
});

class FilterStore extends StateNotifier<FilterStoreState> {
  final ApiHelper api;

  FilterStore({required this.api}) : super(FilterStoreState.init()) {
    SharedPreferences.getInstance().then((prefs) {
      var searchQuery = prefs.getString('searchQuery') ?? "";
      var version = prefs.getString('version') ?? AppConst.lastestVersion;

      setSearchQuery(searchQuery);
      setVersion(version);
    });
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setVersion(String version) {
    state = state.copyWith(version: version);
  }

  void resetFilters() {
    setSearchQuery("");
    setVersion("latest");
  }
}

class FilterStoreState {
  final String searchQuery;
  final String version;

  FilterStoreState({this.searchQuery = "", this.version = "latest"});

  factory FilterStoreState.init() {
    return FilterStoreState();
  }

  FilterStoreState copyWith({String? searchQuery, String? version}) {
    return FilterStoreState(
      searchQuery: searchQuery ?? this.searchQuery,
      version: version ?? this.version,
    );
  }
}
