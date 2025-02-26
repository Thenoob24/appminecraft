import 'package:flutter/material.dart';

class Rectangle extends StatelessWidget {
  const Rectangle({
    super.key,
    required this.color,
    this.width,
    this.height,
    this.text,
    this.border,
    this.hintText
  });

  final Color color;
  final String? text;
  final double? height;
  final double? width;
  final double? border;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(border!)
      ),
      child: Center(
        child: TextField(
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hintText ?? "",
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }
}
