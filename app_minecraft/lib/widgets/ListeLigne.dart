import 'package:flutter/material.dart';
import 'package:app_minecraft/widgets/ItemImage.dart';
import 'package:app_minecraft/widgets/card.dart';

class ListeLigne extends StatelessWidget {
  final Map<String, dynamic> item;

  const ListeLigne({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ObjetCard(item: item),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ItemImage(nom: item['name']),
            ),
            const SizedBox(width: 16),
            Text(
              item['displayName'],
              style: const TextStyle(fontFamily: 'minecraft', fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
