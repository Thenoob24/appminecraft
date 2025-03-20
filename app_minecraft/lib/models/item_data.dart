class ItemData {
  final String name;
  final String type;
  final String version;

  ItemData({required this.name, required this.type, required this.version});

  // Méthode pour convertir ItemData en Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'version': version,
    };
  }
}
