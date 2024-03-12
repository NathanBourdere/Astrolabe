class Partenaire {
  String nom;
  String image;
  String site;

  Partenaire({
    required this.nom,
    required this.image,
    required this.site,
  });

  String get getNom => nom;
  set setNom(String value) {
    nom = value;
  }

  String get getImage => image;
  set setImage(String value) {
    image = value;
  }

  String get getSite => site;
  set setSite(String value) {
    site = value;
  }

  factory Partenaire.fromJson(Map<String, dynamic> json) {
    return Partenaire(
      nom: json['nom'],
      image: json['image'],
      site: json['site'],
    );
  }

  Map<String, dynamic> toJson() => {
        'nom': nom,
        'image': image,
        'site': site,
      };
}
