import 'package:app_minecraft/store/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterStore = ref.watch(filterStoreProvider);

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFBFBFBF),
          border: Border.all(color: Colors.black, width: 4),
        ),
        child: SizedBox(
          height: 40,
          child: TextField(
            onChanged: (value) {
              ref.read(filterStoreProvider.notifier).setSearchQuery(value);
            },
            controller: TextEditingController(text: filterStore.searchQuery)
              ..selection = TextSelection.collapsed(offset: filterStore.searchQuery.length),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'minecraft',
            ),
            decoration: const InputDecoration(
              hintText: "Recherche...",
              hintStyle: TextStyle(fontFamily: 'minecraft', color: Colors.black54),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
          ),
        ),
      ),
    );
  }
}
