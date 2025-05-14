import 'package:app_minecraft/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:app_minecraft/widgets/ItemImage.dart';

class ListeGrille extends StatelessWidget {
  final Map<String, dynamic> item;

  const ListeGrille({super.key, required this.item});

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
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ItemImage(nom: item['name']),
            ),
            const SizedBox(height: 8),
            Text(
              item['displayName'],
              style: const TextStyle(fontFamily: 'minecraft', fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
    );
  }
}
