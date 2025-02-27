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

  FilterStore({required this.api})
      : super(FilterStoreState.init(versions: api.version)) {
    loadFilters();
  }

  /// Charge les filtres sauvegardés (dernière recherche et version)
  Future<void> loadFilters() async {
    final prefs = await SharedPreferences.getInstance();
    final searchQuery = prefs.getString('searchQuery') ?? "";
    final version = prefs.getString('version') ?? AppConst.lastestVersion;

    state = state.copyWith(searchQuery: searchQuery, version: version);
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
  final List<String> versions;

  FilterStoreState({this.searchQuery = "", this.version = "latest", required this.versions});

  factory FilterStoreState.init({required List<String> versions}) {
    return FilterStoreState(versions: versions);
  }

  FilterStoreState copyWith({String? searchQuery, String? version, List<String>? versions}) {
    return FilterStoreState(
      searchQuery: searchQuery ?? this.searchQuery,
      version: version ?? this.version,
      versions: versions ?? this.versions,
    );
  }
}
