import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:app_minecraft/widgets/rectangle.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Rectangle(
      width: MediaQuery.of(context).size.width * 0.8,
      border: 10,
      text: "",
      color: Colors.white,
    );
  }
}
