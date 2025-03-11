import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({super.key, required this.nom});

  final String nom;

  @override
  Widget build(BuildContext context) {
    return Image.asset("lib/images/items/$nom.png");
  }
}