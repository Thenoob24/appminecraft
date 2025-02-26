import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.nom});

  final String nom;

  @override
  Widget build(BuildContext context) {
    return Image.asset("lib/images/items/$nom.png",width: 75,
      height: 75,fit:BoxFit.fill );
  }
}
