import 'package:flutter/material.dart';
import 'package:app_minecraft/widgets/ItemImage.dart';
import 'package:app_minecraft/widgets/card.dart';

class ListeGrille extends StatelessWidget {
  const ListeGrille({super.key, required this.objet, required this.isListMode});

  final String objet;
  final bool isListMode; // Ajoute cette propriété pour savoir quel mode est activé

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: ObjetCard(id: objet),
            );
          },
        );
      },
      child: Container(
        height: isListMode ? 150 : 120, // Différentes tailles selon le mode
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/img/button2.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: ItemImage(nom: "acacia_door", isListMode: isListMode), // Passer l'état à ItemImage
      ),
    );
  }
}
