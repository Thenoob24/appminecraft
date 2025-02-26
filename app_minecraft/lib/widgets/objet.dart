import 'package:flutter/material.dart';
import 'package:app_minecraft/widgets/image.dart';

class Objet extends StatelessWidget {
  const Objet({super.key, required this.objet});

  final String objet;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/img/button.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(children: [
        Padding(
          padding: EdgeInsets.only(left: 50),
          child: Text(
            objet,
            style: TextStyle(
                fontFamily: 'minecraft',
                fontSize: 24), // Couleur du texte pour contraste
          ),
        ),
        const SizedBox(width: 10),
        CustomImage(nom: "acacia_door"),
        Text(
          "c'est une porte",
          style: TextStyle(
              fontFamily: 'minecraft',
              fontSize: 24),
        ),
      ]),
    );
  }
}
