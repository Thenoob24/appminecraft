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
    if (state.majs.isEmpty) {
      api.get().then((response) {

        Map<String, List<ItemData>> majs = {};

        response.data.forEach((data) {
          majs[data['version']] = (data['data'] as List<dynamic>).map((e) => ItemData.fromJson(e as Map<String, dynamic>)).toList();
        });

        state = state.copyWith(majs: majs);
      });
    }
  }

  Map<String, List<ItemData>> getData() {
    return state.majs;
  }
}

class DataStoreState {
  final Map<String, List<ItemData>> majs;

  DataStoreState({this.majs = const {}});

  factory DataStoreState.init() {
    return DataStoreState();
  }

  DataStoreState copyWith({required Map<String, List<ItemData>>? majs}) {
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
  // TODO recipe and drop

  ItemData(this.id, this.displayName, this.stackSize, this.block, this.name);

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      json['id'] as int,
      json['displayName'] as String,
      json['stackSize'] as int,
      Block.fromJson(json['block']),
      json['name'] as String,
    );
  }

  // Ajoutez cette méthode pour convertir ItemData en Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'name': name,
      'stackSize': stackSize,
      'block': block.toMap(),
    };
  }
}

class Block {
  final BlockInfo blockInfo;

  Block(this.blockInfo);

  factory Block.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      // Vérification si json['block'] n'est pas null avant de tenter le cast
      final blockData = json['block'] as Map<String, dynamic>?;
      return Block(
        BlockInfo.fromJson(blockData ?? {}), // Si `blockData` est null, utiliser un objet vide par défaut
      );
    } else {
      return Block.empty();
    }
  }

  factory Block.empty() {
    return Block(
      BlockInfo.defaultBlockInfo()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'blockInfo': blockInfo.toMap(),
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
  final List<dynamic> states;
  final List<dynamic> drops;
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
      this.defaultState);

  factory BlockInfo.fromJson(Map<String, dynamic> json) {
    return BlockInfo(
      json['id'] as int? ?? 0,  // Si 'id' est null, on met une valeur par défaut 0
      json['displayName'] as String? ?? "Unknown",  // Si 'displayName' est null, on met une valeur par défaut
      json['name'] as String? ?? "unknown",  // Si 'name' est null, on met une valeur par défaut
      (json['hardness'] as num?)?.toDouble() ?? 0.0,  // Si 'hardness' est null, on met une valeur par défaut 0.0
      (json['resistance'] as num?)?.toDouble() ?? 0.0,  // Si 'resistance' est null, on met une valeur par défaut 0.0
      json['minStateId'] as int? ?? 0,  // Si 'minStateId' est null, on met une valeur par défaut 0
      json['maxStateId'] as int? ?? 0,  // Si 'maxStateId' est null, on met une valeur par défaut 0
      json['states'] as List<dynamic>? ?? [],
      json['drops'] as List<dynamic>? ?? [],  // Si 'drops' est null, on retourne une liste vide
      json['diggable'] as bool? ?? false,  // Si 'diggable' est null, on met 'false' par défaut
      json['transparent'] as bool? ?? false,  // Si 'transparent' est null, on met 'false' par défaut
      json['filterLight'] as int? ?? 0,  // Si 'filterLight' est null, on met une valeur par défaut 0
      json['emitLight'] as int? ?? 0,  // Si 'emitLight' est null, on met une valeur par défaut 0
      json['boundingBox'] as String? ?? "solid",  // Si 'boundingBox' est null, on met une valeur par défaut "solid"
      json['stackSize'] as int? ?? 64,  // Si 'stackSize' est null, on met une valeur par défaut 64
      json['material'] as String? ?? "unknown",  // Si 'material' est null, on met une valeur par défaut "unknown"
      HarvestTools.fromJson(json['harvestTools'] as Map<String, dynamic>?),  // Si 'harvestTools' est null, on utilise la méthode de gestion des nulls de HarvestTools
      json['defaultState'] as int? ?? 0,  // Si 'defaultState' est null, on met une valeur par défaut 0
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

  Map<String, dynamic> toMap() {
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
      'harvestTools': harvestTools.toMap(),
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

  factory HarvestTools.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return HarvestTools.defaultHarvestTools();
    }

    return HarvestTools(
      (json['701'] as bool?) ?? false,
      (json['706'] as bool?) ?? false,
      (json['711'] as bool?) ?? false,
      (json['716'] as bool?) ?? false,
      (json['721'] as bool?) ?? false,
      (json['726'] as bool?) ?? false,
    );
  }

  factory HarvestTools.defaultHarvestTools() {
    return HarvestTools(false, false, false, false, false, false);
  }

  Map<String, dynamic> toMap() {
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
  final List<DropsInfo> dropsInfo;

  Drops(this.dropsInfo);

  factory Drops.fromJson(List<dynamic> json) {
    return Drops(
      json
          .map((e) => DropsInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory Drops.defaultDrops() {
    return Drops([]);
  }

  Map<String, dynamic> toMap() {
    return {
      'dropsInfo': dropsInfo.map((e) => e.toMap()).toList(),
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

  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'dropChance': dropChance,
      'stackSizeRange': stackSizeRange,
      'silkTouch': silkTouch,
    };
  }
}
