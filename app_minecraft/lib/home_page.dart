import 'package:app_minecraft/store/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_minecraft/widgets/search.dart';
import 'package:app_minecraft/widgets/version.dart';
import 'package:app_minecraft/widgets/objet.dart';

final searchVisibleProvider = StateProvider<bool>((ref) => false);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final isSearchVisible = ref.watch(searchVisibleProvider);
    final filterStore = ref.watch(filterStoreProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Minecraft's Guide",
          style: TextStyle(
              fontFamily: 'minecraft',color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          // Image de fond
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/img/background.png"),
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),

          Positioned.fill(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, i) => Objet(objet: i.toString()),
              separatorBuilder: (context, i) => const SizedBox(height: 16),
            ),
          ),

          // Bouton de recherche
          Positioned(
            top: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: () {
                ref.read(searchVisibleProvider.notifier).state = !isSearchVisible;
              },
              backgroundColor: Colors.green,
              child: Icon(
                isSearchVisible ? Icons.close : Icons.search,
                color: Colors.white,
              ),
            ),
          ),

          if (isSearchVisible)
            Positioned(
              top: 21,
              left: 70,
              child: const Search(),
            ),

          if (isSearchVisible)
            Positioned(
              top: 70,
              left: 16,
              child: const Version(),
            ),
        ],
      ),
    );
  }
}
