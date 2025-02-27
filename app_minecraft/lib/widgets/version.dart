import 'package:flutter/material.dart';

class Version extends StatelessWidget {
  const Version({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: null,
        hint: const Text("Version..."),
        items: const [
          DropdownMenuItem(value: "1.20", child: Text("1.20")),
          DropdownMenuItem(value: "1.19", child: Text("1.19")),
          DropdownMenuItem(value: "1.18", child: Text("1.18")),
        ],
        onChanged: (value) {},
        underline: const SizedBox(),
      ),
    );
  }
}
