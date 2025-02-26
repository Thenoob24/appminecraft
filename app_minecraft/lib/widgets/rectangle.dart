import 'package:flutter/material.dart';

class Rectangle extends StatelessWidget {
  const Rectangle({
    super.key,
    required this.color,
    this.width,
    this.height,
    this.border,
    this.hintText,
    this.child,
  });

  final Color color;
  final double? height;
  final double? width;
  final double? border;
  final String? hintText;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(border ?? 10),
        border: Border.all(color: Colors.black, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: child ??
          TextField(
            style: const TextStyle(fontSize: 16, color: Colors.black),
            decoration: InputDecoration(
              hintText: hintText ?? "",
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: InputBorder.none,
            ),
          ),
    );
  }
}
