import 'package:app_minecraft/store/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Version extends ConsumerWidget {
  const Version({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterStore = ref.watch(filterStoreProvider); // Récupère les données du store

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
        items: filterStore.versions.map((String version) {
          return DropdownMenuItem(
            value: version,
            child: Text(version),
          );
        }).toList(),
        onChanged: (value) {
          ref.read(filterStoreProvider.notifier).setVersion(value ?? "latest");
          print("Version sélectionnée : $value");
        },
        underline: const SizedBox(),
      ),
    );
  }
}
