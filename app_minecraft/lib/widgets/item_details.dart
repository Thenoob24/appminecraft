import 'package:flutter/material.dart';
import 'package:app_minecraft/widgets/ItemImage.dart';
import 'package:app_minecraft/store/data_store.dart';

class ItemDetails extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final name = item['name'] ?? 'Unknown';
    final displayName = item['displayName'] ?? name;
    final block = item['block']?['block'] as Map<String, dynamic>?;
    final harvestTools = block?['harvestTools'] as Map<String, dynamic>?;
    final recipes = item['recipes'] as List<dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          displayName,
          style: const TextStyle(fontFamily: 'minecraft'),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image et nom de l'item
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: ItemImage(nom: name),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontFamily: 'minecraft',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Outils nécessaires
            if (harvestTools != null) ...[
              const Text(
                'Outils nécessaires :',
                style: TextStyle(
                  fontFamily: 'minecraft',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  if (harvestTools['701'] == true) _buildToolItem('wooden_pickaxe'),
                  if (harvestTools['706'] == true) _buildToolItem('stone_pickaxe'),
                  if (harvestTools['711'] == true) _buildToolItem('iron_pickaxe'),
                  if (harvestTools['716'] == true) _buildToolItem('diamond_pickaxe'),
                  if (harvestTools['721'] == true) _buildToolItem('netherite_pickaxe'),
                  if (harvestTools['726'] == true) _buildToolItem('golden_pickaxe'),
                ],
              ),
            ],
            const SizedBox(height: 32),

            // Table de craft
            if (recipes != null && recipes.isNotEmpty) ...[
              const Text(
                'Table de craft :',
                style: TextStyle(
                  fontFamily: 'minecraft',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...recipes.map((recipe) => _buildCraftingTable(recipe)).toList(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildToolItem(String toolName) {
    return Column(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: ItemImage(nom: toolName),
        ),
        const SizedBox(height: 8),
        Text(
          toolName.replaceAll('_', ' '),
          style: const TextStyle(
            fontFamily: 'minecraft',
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCraftingTable(Map<String, dynamic> recipe) {
    final ingredients = recipe['ingredients'] as List<dynamic>?;
    final result = recipe['result'] as Map<String, dynamic>?;
    final resultCount = result?['count'] as int? ?? 1;
    final resultName = result?['name'] as String? ?? 'unknown';

    // Debug logs
    print('Recipe data:');
    print('Result: $result');
    print('Ingredients: $ingredients');

    // Créer une grille 3x3 pour les ingrédients
    List<List<String?>> grid = List.generate(3, (_) => List.filled(3, null));
    
    if (ingredients != null) {
      for (var i = 0; i < ingredients.length; i++) {
        if (i < 9) {
          final ingredient = ingredients[i];
          if (ingredient != null) {
            final row = i ~/ 3;
            final col = i % 3;
            String? ingredientName;
            
            if (ingredient is Map<String, dynamic>) {
              ingredientName = ingredient['name'] as String?;
            } else if (ingredient is int) {
              // Si l'ingrédient est un ID, on peut le convertir en nom si nécessaire
              ingredientName = 'Item_$ingredient';
            }
            
            if (ingredientName != null) {
              grid[row][col] = ingredientName;
              print('Position ($row,$col): $ingredientName'); // Debug log
            }
          }
        }
      }
    }

    return Column(
      children: [
        Container(
          width: 300,
          height: 300,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.brown[200],
            border: Border.all(color: Colors.brown[900]!, width: 4),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              final row = index ~/ 3;
              final col = index % 3;
              final ingredientName = grid[row][col];

              return Container(
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  border: Border.all(color: Colors.brown[900]!, width: 2),
                ),
                child: ingredientName != null
                    ? Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: ItemImage(nom: ingredientName),
                        ),
                      )
                    : const SizedBox(),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Résultat: ${resultCount}x ${resultName.replaceAll('_', ' ')}',
          style: const TextStyle(
            fontFamily: 'minecraft',
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
} 