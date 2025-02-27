import 'package:app_minecraft/store/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_minecraft/widgets/search.dart';
import 'package:app_minecraft/widgets/version.dart';
import 'package:app_minecraft/widgets/ListeLigne.dart';
import 'Package:app_minecraft/widgets/ListeGrille.dart';


final searchVisibleProvider = StateProvider<bool>((ref) => false);
<<<<<<< HEAD
final displayModeProvider = StateProvider<bool>((ref) => true); // true = Liste, false = Grille
=======
>>>>>>> 787030baddab919f6b7d0f03a62a29fd595ea93d

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final isSearchVisible = ref.watch(searchVisibleProvider);
    final isListMode = ref.watch(displayModeProvider); // Lire l'état du mode

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/img/bannier.png"),
              repeat: ImageRepeat.repeat,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isListMode ? Icons.grid_view : Icons.list, // Change l'icône selon le mode
              color: Colors.white,
            ),
            onPressed: () {
              ref.read(displayModeProvider.notifier).state = !isListMode; // Basculer le mode
            },
          ),
        ],
        title: const Text(
          "Minecraft's Guide",
          style: TextStyle(
            fontFamily: 'minecraft',
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            child: isListMode
                ? ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 100,
              itemBuilder: (context, i) => ListeLigne(objet: i.toString(),isListMode:isListMode),
              separatorBuilder: (context, i) => const SizedBox(height: 16),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10000,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Nombre de colonnes
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, i) => ListeGrille(objet: i.toString(),isListMode:isListMode ),
            ),
          ),

          // Bouton de recherche (reste fixe)
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

          // Animation de la barre de recherche
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            top: 21,
            left: isSearchVisible ? 70 : -500,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isSearchVisible ? 1 : 0,
              child: const Search(),
            ),
          ),

          // Animation du dropdown version
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            top: isSearchVisible ? 70 : -500,
            left: 16,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isSearchVisible ? 1 : 0,
              child: const Version(),
            ),
          ),
        ],
      ),
    );
  }
}
