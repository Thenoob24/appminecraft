import 'package:flutter/material.dart';
import 'package:app_minecraft/widgets/ItemImage.dart';
import 'package:app_minecraft/widgets/item_details.dart';

class ListeLigne extends StatelessWidget {
  final Map<String, dynamic> objet; // Assurez-vous que le type est correct

  const ListeLigne({super.key, required this.objet});

  @override
  Widget build(BuildContext context) {
    final name = objet['name'] ?? 'Unknown'; // Vérifiez que 'name' existe

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetails(item: objet),
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
              child: ItemImage(nom: name),
            ),
            const SizedBox(width: 16),
            Text(
              name,
              style: const TextStyle(fontFamily: 'minecraft', fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
