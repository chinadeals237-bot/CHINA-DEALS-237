class TaskModel {
  final String id;
  final String produit;
  final String description;
  final int prix;

  TaskModel({
    required this.id,
    required this.produit,
    required this.description,
    required this.prix,
  });

  factory TaskModel.fromMap(String id, Map<String, dynamic> data) {
    return TaskModel(
      id: id,
      produit: data['produit'] ?? '',
      description: data['description'] ?? '',
      prix: data['prix'] ?? 0,
    );
  }
}