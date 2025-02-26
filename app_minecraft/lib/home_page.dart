import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_minecraft/widgets/search.dart';

final searchVisibleProvider = StateProvider<bool>((ref) => false);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final isSearchVisible = ref.watch(searchVisibleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Minecraft's Guide",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
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
              top: 65,
              left: 16,
              child: const Search(),
            ),
        ],
      ),
    );
  }
}
