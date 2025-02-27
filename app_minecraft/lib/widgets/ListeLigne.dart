import 'package:flutter/material.dart';
import 'package:app_minecraft/widgets/image.dart';
import 'package:app_minecraft/widgets/card.dart';

class ListeLigne extends StatelessWidget {
  const ListeLigne({super.key, required this.objet});

  final String objet;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
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
      height: 115,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/img/button.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(children: [
        Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            objet,
            style: TextStyle(
                fontFamily: 'minecraft',
                fontSize: 16), // Couleur du texte pour contraste
          ),
        ),
        CustomImage(nom: "acacia_door"),

        Text(
          "c'est une porte",
          style: TextStyle(
              fontFamily: 'minecraft',
              fontSize: 16),
        ),
      ]),
    ),
    );
  }
}
