import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({super.key, required this.nom, required this.isListMode});

  final String nom;
  final bool isListMode; // Récupère l'état du mode

  @override
  Widget build(BuildContext context) {
    // Ajuste la taille de l'image en fonction du mode
    return Image.asset(
      "lib/images/items/$nom.png",
      width:  65, // Taille plus petite en mode grille
      height:  65 ,
      fit: isListMode ? BoxFit.fill : BoxFit.scaleDown,
    );
  }
}
