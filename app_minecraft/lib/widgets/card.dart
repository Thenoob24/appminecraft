import 'package:flutter/material.dart';
import 'package:app_minecraft/widgets/ItemImage.dart';
import 'crafting.dart';


class ObjetCard extends StatelessWidget {
  const ObjetCard({super.key, required this.id});

  final String id;
  static const String nom = "acacia_door";
  static const List<String> harvestable = ["wooden_axe"];
  static const List<String> drop = ["acacia_door"];
  static const List<String> tools = [
    "axe",
    "pickaxe",
    "shovel",
    "hoe",
    "sword",
    "shear"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              nom.toUpperCase(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ItemImage(nom: nom),
            const SizedBox(height: 10),
            Text(
              "ID: $id",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            const Text(
              "Tools to harvest:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 32,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: tools.map((tool) {
                bool isHarvestable =
                    harvestable.contains("wooden_$tool") || harvestable.contains(tool);
                return SizedBox(
                  width: 40,
                  height: 40,
                  child: isHarvestable
                      ? ItemImage(nom: "wooden_$tool")
                      : Image.asset("lib/assets/img/Harvest_Tools/gray_$tool.png"),
                );
              }).toList(),
            ),
            const Text(
              "Drops:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 32,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: drop.map((dropItem) {
                return SizedBox(
                  width: 40,
                  height: 40,
                  child: ItemImage(nom: dropItem),
                );
              }).toList(),
            ),
            const Text(
              "Craft:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CraftingTable(),
          ],
        ),
      );
  }
}
