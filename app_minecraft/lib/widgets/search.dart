import 'package:app_minecraft/store/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterStore = ref.watch(filterStoreProvider);

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: TextField(
        onChanged: (value) {
          ref.read(filterStoreProvider.notifier).setSearchQuery(value);
        },
        controller: TextEditingController(text: filterStore.searchQuery)
          ..selection = TextSelection.collapsed(offset: filterStore.searchQuery.length), // Placer le curseur a la fin du texte
        style: const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'minecraft'),
        decoration: const InputDecoration(
          hintText: "Recherche...",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
