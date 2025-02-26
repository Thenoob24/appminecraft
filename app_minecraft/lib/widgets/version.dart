import 'dart:math';

import 'package:app_minecraft/widgets/rectangle.dart';
import 'package:flutter/material.dart';

class Version extends StatelessWidget {
  const Version({super.key});

  @override
  Widget build(BuildContext context) {
    return Rectangle(
      width: MediaQuery.of(context).size.width * 0.4,
      border: 10,
      hintText: "Version...",
      color: Colors.white,
    );
  }
}
