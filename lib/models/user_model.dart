class UserModel {
  final String uid;
  final String nom;
  final String email;
  final String telephone;
  final String statut;

  UserModel({
    required this.uid,
    required this.nom,
    required this.email,
    required this.telephone,
    required this.statut,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      nom: data['nom'] ?? '',
      email: data['email'] ?? '',
      telephone: data['telephone'] ?? '',
      statut: data['statut'] ?? 'Standard',
    );
  }
}