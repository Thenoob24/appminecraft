import 'package:app_minecraft/store/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_const.dart';

class Version extends ConsumerWidget {
  const Version({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterStore = ref.watch(filterStoreProvider);

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFBFBFBF),
          border: Border.all(color: Colors.black, width: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            dropdownColor: const Color(0xFFBFBFBF),
            value: filterStore.versions.contains(filterStore.version) ? filterStore.version : null,
            hint: const Text(
              "Version...",
              style: TextStyle(fontFamily: 'minecraft', color: Colors.black),
            ),
            items: filterStore.versions.map((String version) {
              return DropdownMenuItem(
                value: version,
                child: Text(version, style: const TextStyle(fontFamily: 'minecraft', color: Colors.black)),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                ref.read(filterStoreProvider.notifier).setVersion(value);
              }
            },
          ),
        ),
      ),
    );
  }
}
