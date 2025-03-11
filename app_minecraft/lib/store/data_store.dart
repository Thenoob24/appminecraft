import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    api.get().then((response) {

      List<Maj> majs = [];

      response.data.forEach((data) {
        print(data);
        majs.add(Maj.fromJson(data as Map<String, dynamic>));
      });

      state = state.copyWith(majs: majs);
    });
  }

  List<Maj> getData() {
    return state.majs;
  }
}

class DataStoreState {
  final List<Maj> majs;

  DataStoreState({this.majs = const []});

  factory DataStoreState.init() {
    return DataStoreState();
  }

  DataStoreState copyWith({required List<Maj> majs}) {
    return DataStoreState(
      majs: majs ?? this.majs,
    );
  }
}

class Maj {
  final String version;
  final List<ItemData> items;

  Maj(this.version, this.items);

  factory Maj.fromJson(Map<String, dynamic> json) {
    return Maj(
      json['version'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => ItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ItemData {
  final int id;
  final String displayName;
  final String name;
  final int stackSize;
  final Block block;

  ItemData(
      this.id, this.displayName, this.stackSize, this.block, this.name);

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      json['id'] as int,
      json['displayName'] as String,
      json['stackSize'] as int,
      Block.fromJson(json['block']),
      json['name'] as String,
    );
  }
}

class Block {
  final BlockInfo blockInfo;
  final Drops drops;

  Block(this.blockInfo, this.drops);

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      BlockInfo.fromJson(json['block']["block"]),
      Drops.fromJson(json['drops']),
    );
  }
}

class BlockInfo {
  final int id;
  final String displayName;
  final String name;
  final double hardness;
  final double resistance;
  final int minStateId;
  final int maxStateId;
  final List<String> states;
  final List<int> drops;
  final bool diggable;
  final bool transparent;
  final int filterLight;
  final int emitLight;
  final String boundingBox;
  final int stackSize;
  final String material;
  final HarvestTools harvestTools;
  final int defaultState;

  BlockInfo(
      this.id,
      this.displayName,
      this.name,
      this.hardness,
      this.resistance,
      this.minStateId,
      this.maxStateId,
      this.states,
      this.drops,
      this.diggable,
      this.transparent,
      this.filterLight,
      this.emitLight,
      this.boundingBox,
      this.stackSize,
      this.material,
      this.harvestTools,
      this.defaultState,
      );

  factory BlockInfo.fromJson(Map<String, dynamic> json) {
    return BlockInfo(
      json['id'] as int,
      json['displayName'] as String,
      json['name'] as String,
      (json['hardness'] as num).toDouble(),
      (json['resistance'] as num).toDouble(),
      json['minStateId'] as int,
      json['maxStateId'] as int,
      (json['states'] as List<dynamic>).map((e) => e as String).toList(),
      (json['drops'] as List<dynamic>).map((e) => e as int).toList(),
      json['diggable'] as bool,
      json['transparent'] as bool,
      json['filterLight'] as int,
      json['emitLight'] as int,
      json['boundingBox'] as String,
      json['stackSize'] as int,
      json['material'] as String,
      HarvestTools.fromJson(json['harvestTools']),
      json['defaultState'] as int,
    );
  }

  factory BlockInfo.defaultBlockInfo() {
    return BlockInfo(
      0,
      "Unknown",
      "unknown",
      0.0,
      0.0,
      0,
      0,
      [],
      [],
      false,
      false,
      0,
      0,
      "solid",
      64,
      "unknown",
      HarvestTools.defaultHarvestTools(),
      0,
    );
  }
}

class HarvestTools {
  final bool e701;
  final bool e706;
  final bool e711;
  final bool e716;
  final bool e721;
  final bool e726;

  HarvestTools(this.e701, this.e706, this.e711, this.e716, this.e721, this.e726);

  factory HarvestTools.fromJson(Map<String, dynamic> json) {
    return HarvestTools(
      json['701'] as bool,
      json['706'] as bool,
      json['711'] as bool,
      json['716'] as bool,
      json['721'] as bool,
      json['726'] as bool,
    );
  }

  factory HarvestTools.defaultHarvestTools() {
    return HarvestTools(false, false, false, false, false, false);
  }
}

class Drops {
  final String block;
  final List<DropsInfo> dropsInfo;

  Drops(this.block, this.dropsInfo);

  factory Drops.fromJson(Map<String, dynamic> json) {
    return Drops(
      json['block'] as String,
      (json['drops'] as List<dynamic>)
          .map((e) => DropsInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory Drops.defaultDrops() {
    return Drops("unknown", []);
  }
}

class DropsInfo {
  final String item;
  final double dropChance;
  final List<int> stackSizeRange;
  final bool silkTouch;

  DropsInfo(this.item, this.dropChance, this.stackSizeRange, this.silkTouch);

  factory DropsInfo.fromJson(Map<String, dynamic> json) {
    return DropsInfo(
      json['item'] as String,
      (json['dropChance'] as num).toDouble(),
      (json['stackSizeRange'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      json['silkTouch'] as bool,
    );
  }

  factory DropsInfo.defaultDropsInfo() {
    return DropsInfo("unknown", 1.0, [], false);
  }
}
