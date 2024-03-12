class Scene {
  int id;
  String nom;
  String image;

  Scene({
    required this.id,
    required this.nom,
    required this.image,
  });

  int get getid => id;
  set setid(int value) {
    id = value;
  }

  String getnom() {
    return nom;
  }

  set setnom(String value) {
    nom = value;
  }

  String get getimage => image;
  set setimage(String value) {
    image = value;
  }

  factory Scene.fromJson(Map<String, dynamic> json) {
    return Scene(
      id: json['id'],
      nom: json['nom'],
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'image': image,
    };
  }
}
