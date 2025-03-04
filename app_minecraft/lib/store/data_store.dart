import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import '../api/api_helper.dart';

final dataStoreProvider =
StateNotifierProvider<DataStore, DataStoreState>((ref) {
  var apiHelper = ref.watch(apiHelperProvider);
  return DataStore(api: apiHelper);
});

class DataStore extends StateNotifier<DataStoreState> {
  final ApiHelper api;

  DataStore({required this.api}) : super(DataStoreState.init()) {
    loadData();
  }

  Future<void> setData() async {
    final response = await api.get();
    List<Maj> majs = [];

    if (response.data is List) {
      for (var data in response.data) {
        if (data is Map<String, dynamic>) {
          majs.add(Maj.fromJson(data));
        } else {
          print('Unexpected data format: $data');
        }
      }
    } else {
      print('Unexpected response format: ${response.data}');
    }

    state = state.copyWith(majs: majs);
    await saveData(majs);
  }

  List<Maj> getData() {
    return state.majs;
  }

  Future<void> saveData(List<Maj> majs) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data.json');
    final jsonData = jsonEncode(majs.map((maj) => maj.toJson()).toList());
    await file.writeAsString(jsonData);
  }

  Future<void> loadData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.json');
      if (await file.exists()) {
        final jsonData = await file.readAsString();
        final List<dynamic> data = jsonDecode(jsonData);
        final majs = data.map((item) => Maj.fromJson(item)).toList();
        if (state.majs.isEmpty) {
          state = state.copyWith(majs: majs);
        }
      }
    } catch (e) {
      print('Error loading data: $e');
    }
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
      (json['items'] as List<dynamic>)
          .map((e) => ItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class ItemData {
  final int id;
  final String displayName;
  final String name;
  final int stackSize;
  final Block? block;
  final int metadata;

  ItemData(
      this.id, this.displayName, this.stackSize, this.block, this.name, this.metadata);

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      json['id'] as int,
      json['displayName'] as String,
      json['stackSize'] as int,
      json['block'] != null && json['block'] is Map<String, dynamic>
          ? Block.fromJson(json['block'])
          : null,
      json['name'] as String,
      json['metadata'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'name': name,
      'stackSize': stackSize,
      'block': block?.toJson(),
      'metadata': metadata,
    };
  }
}

class Block {
  final BlockInfo? blockInfo;
  final Drops drops;

  Block(this.blockInfo, this.drops);

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      json['block'] != null && json['block'] is Map<String, dynamic>
          ? BlockInfo.fromJson(json['block'])
          : null,
      Drops.fromJson(json['drops']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blockInfo': blockInfo?.toJson(),
      'drops': drops.toJson(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'name': name,
      'hardness': hardness,
      'resistance': resistance,
      'minStateId': minStateId,
      'maxStateId': maxStateId,
      'states': states,
      'drops': drops,
      'diggable': diggable,
      'transparent': transparent,
      'filterLight': filterLight,
      'emitLight': emitLight,
      'boundingBox': boundingBox,
      'stackSize': stackSize,
      'material': material,
      'harvestTools': harvestTools.toJson(),
      'defaultState': defaultState,
    };
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

  Map<String, dynamic> toJson() {
    return {
      '701': e701,
      '706': e706,
      '711': e711,
      '716': e716,
      '721': e721,
      '726': e726,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'block': block,
      'dropsInfo': dropsInfo.map((drop) => drop.toJson()).toList(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'dropChance': dropChance,
      'stackSizeRange': stackSizeRange,
      'silkTouch': silkTouch,
    };
  }
}
