import 'package:flutter/material.dart';
import 'package:app_minecraft/widgets/ItemImage.dart';

class ObjetCard extends StatelessWidget {
  const ObjetCard({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(id),
        );
  }
}
