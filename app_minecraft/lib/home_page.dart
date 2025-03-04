import 'package:app_minecraft/store/data_store.dart';
import 'package:app_minecraft/store/filter_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_minecraft/widgets/search.dart';
import 'package:app_minecraft/widgets/version.dart';
import 'package:app_minecraft/widgets/ListeLigne.dart';
import 'Package:app_minecraft/widgets/ListeGrille.dart';


final searchVisibleProvider = StateProvider<bool>((ref) => false);
final displayModeProvider = StateProvider<bool>((ref) => true); // true = Liste, false = Grille


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final DataStore dataStore = ref.read(dataStoreProvider.notifier);
    final isListMode = ref.watch(displayModeProvider);

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
      body: FutureBuilder(
        future: dataStore.setData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final DataStoreState state = ref.watch(dataStoreProvider);
            final isSearchVisible = ref.watch(searchVisibleProvider);

            return Stack(
              clipBehavior: Clip.none,
              children: [
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
                          itemCount: state.majs.length,
                          itemBuilder: (context, i) => ListeLigne(objet: state.majs[i].version),
                          separatorBuilder: (context, i) => const SizedBox(height: 16),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.majs.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, i) => ListeGrille(objet: state.majs[i].version),
                        ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  top: 18,
                  left: isSearchVisible ? 69 : -500,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isSearchVisible ? 1 : 0,
                    child: const Search(),
                  ),
                ),
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
                Positioned(
                  top: 16,
                  left: 16,
                  child: FloatingActionButton(
                    onPressed: () {
                      ref.read(searchVisibleProvider.notifier).state = !isSearchVisible;
                    },
                    backgroundColor: Colors.green,
                    elevation: 5,
                    child: Icon(
                      isSearchVisible ? Icons.close : Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
