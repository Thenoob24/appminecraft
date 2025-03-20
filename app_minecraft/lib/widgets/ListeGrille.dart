import 'package:flutter/material.dart';
import 'package:app_minecraft/widgets/ItemImage.dart';

class ListeGrille extends StatelessWidget {
  final Map<String, dynamic> objet;

  const ListeGrille({super.key, required this.objet});

  @override
  Widget build(BuildContext context) {
    final name = objet['name'] ?? 'Unknown';

    return Container(
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
            child: ItemImage(nom: name),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontFamily: 'minecraft', fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
