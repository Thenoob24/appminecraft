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
    api.get().then((response){


      state = state.copyWith(data: map);
    });
  }
}

class DataStoreState {
  final Map<String,List<ItemData>>? data ;

  DataStoreState({this.data});

  factory DataStoreState.init() {
    return DataStoreState();
  }

  DataStoreState copyWith({Map<String, List<ItemData>>? data}) {
    return DataStoreState(
      data: data ?? this.data,
    );
  }
}

class ItemData{
  final int id;
  final String displayName;
  final String name;
  final int stackSize;
  final Block block;


  ItemData(this.id, this.displayName, this.stackSize, this.block, {required this.name});

}

class Block{
  final BlockInfo blockInfo;
  final Drops drops;

  Block(this.blockInfo, this.drops);
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

  BlockInfo(this.id, this.displayName, this.name, this.hardness, this.resistance, this.minStateId, this.maxStateId, this.states, this.drops, this.diggable, this.transparent, this.filterLight, this.emitLight, this.boundingBox, this.stackSize, this.material, this.harvestTools, this.defaultState);
}

class HarvestTools {
  final bool _701;
  final bool _706;
  final bool _711;
  final bool _716;
  final bool _721;
  final bool _726;

  HarvestTools(this._701, this._706, this._711, this._716, this._721, this._726);
}

class Drops {
  final String block;
  final List<DropsInfo> dropsInfo;

  Drops(this.block, this.dropsInfo);
}

class DropsInfo {
  final String item;
  final double dropChance;
  final List<int> stackSizeRange;
  final bool silkTouch;

  DropsInfo(this.item, this.dropChance, this.stackSizeRange, this.silkTouch);
}