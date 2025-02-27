import 'package:app_minecraft/store/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_const.dart';

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
        value: filterStore.versions.contains(filterStore.version) ? filterStore.version : null,

        hint: Text(
          "Version...",
          style: const TextStyle(fontFamily: 'minecraft'),
        ),
        items: filterStore.versions.map((String version) {
          return DropdownMenuItem(
            value: version,
            child: Text(version, style: const TextStyle(fontFamily: 'minecraft')),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            ref.read(filterStoreProvider.notifier).setVersion(value);
          }
        },
        underline: const SizedBox(),
      ),
    );
  }
}
