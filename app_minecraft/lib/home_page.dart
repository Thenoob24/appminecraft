import 'package:app_minecraft/store/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_minecraft/widgets/search.dart';
import 'package:app_minecraft/widgets/version.dart';
import 'package:app_minecraft/widgets/ListeLigne.dart';

final searchVisibleProvider = StateProvider<bool>((ref) => false);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final isSearchVisible = ref.watch(searchVisibleProvider);

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
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 10000,
              itemBuilder: (context, i) => ListeLigne(objet: i.toString()),
              separatorBuilder: (context, i) => const SizedBox(height: 16),
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
      ),
    );
  }
}
