import 'package:app_minecraft/store/filter_store.dart';
import 'package:app_minecraft/widgets/rectangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterStore = ref.watch(filterStoreProvider);

    return Rectangle(
      width: MediaQuery.of(context).size.width * 0.8,
      border: 10,
      hintText: "Recherche...",
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) {
            ref.read(filterStoreProvider.notifier).setSearchQuery(value);
          },
          decoration: InputDecoration(
            hintText: filterStore.searchQuery.isEmpty ? "Recherche..." : filterStore.searchQuery,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
