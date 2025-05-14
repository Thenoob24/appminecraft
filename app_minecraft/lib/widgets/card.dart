import 'package:flutter/material.dart';
import 'package:app_minecraft/widgets/ItemImage.dart';
import 'crafting.dart';


class ObjetCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ObjetCard({super.key, required this.item, });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              item['displayName'].toUpperCase(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ItemImage(nom: item['name']),
            const SizedBox(height: 10),
            Text(
              "ID: ${item['id']}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 8),
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
