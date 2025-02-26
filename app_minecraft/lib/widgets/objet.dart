import 'package:flutter/material.dart';
import 'package:app_minecraft/widgets/image.dart';

class Objet extends StatelessWidget {
  const Objet({super.key,required this.objet});

  //final Map<String, dynamic>? objet;
  final String objet;


  //valeurs a changer
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            objet,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          const SizedBox(width: 10),
          CustomImage(nom: "acacia_door"),
          Text("c'est une porte",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white))
        ],
      ),
    );
  }
}
