import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({super.key, required this.nom});

  final String nom;

  String _formatImageName(String name) {
    // Debug log
    print('Formatting image name: $name');
    
    // Si le nom est null ou vide, retourner une valeur par défaut
    if (name == null || name.isEmpty) {
      print('Warning: Empty or null item name');
      return 'unknown';
    }

    // Convertir le nom en minuscules
    name = name.toLowerCase();
    
    // Gérer les cas spéciaux
    switch (name) {
      // Blocs de base
      case 'wooden_pressure_plate':
        return 'pressure_plate_wood';
      case 'snow_layer':
        return 'snow';
      case 'planks':
      case 'wooden_planks':
      case 'wooden_plank':
        return 'planks_oak';
      case 'wood':
      case 'log':
      case 'oak_log':
        return 'log_oak';
      
      // Items spécifiques mentionnés dans les erreurs
      case 'wool':
        return 'wool_white';
      case 'deadbush':
        return 'dead_bush';
      case 'web':
        return 'cobweb';
      case 'tallgrass':
        return 'tall_grass';
      case 'golden_rail':
        return 'rail_golden';
      case 'noteblock':
        return 'note_block';
      
      // Autres cas courants
      case 'stone':
        return 'stone';
      case 'stick':
        return 'stick';
      case 'redstone':
        return 'redstone_dust';
      
      default:
        // Si le nom contient 'wooden_', essayer de remplacer par la version en bois
        if (name.startsWith('wooden_')) {
          String baseName = name.replaceFirst('wooden_', '');
          return '${baseName}_wood';
        }
        return name;
    }
  }

  String _formatDisplayName(String name) {
    // Remplacer les underscores par des espaces
    name = name.replaceAll('_', ' ');
    // Mettre en majuscule la première lettre de chaque mot
    return name.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return word;
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    String formattedName = _formatImageName(nom);
    String imagePath = "lib/images/items/$formattedName.png";
    
    return Image.asset(
      imagePath,
      errorBuilder: (context, error, stackTrace) {
        // Si l'image n'est pas trouvée dans items, essayer dans blocks
        String blockPath = "lib/images/blocks/$formattedName.png";
        
        return Image.asset(
          blockPath,
          errorBuilder: (context, error, stackTrace) {
            // Si l'image n'est toujours pas trouvée, afficher un placeholder avec le nom formaté
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.grey[600]!, width: 1),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    _formatDisplayName(nom),
                    style: const TextStyle(
                      fontSize: 8,
                      fontFamily: 'minecraft',
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}