class Partenaire {
  String nom;
  String banniere;
  String site;

  Partenaire({
    required this.nom,
    required this.banniere,
    required this.site,
  });

  String get getNom => nom;
  set setNom(String value) {
    nom = value;
  }

  String get getbanniere => banniere;
  set setbanniere(String value) {
    banniere = value;
  }

  String get getSite => site;
  set setSite(String value) {
    site = value;
  }

  factory Partenaire.fromJson(Map<String, dynamic> json) {
    return Partenaire(
      nom: json['nom'],
      banniere: json['banniere'],
      site: json['site'],
    );
  }

  Map<String, dynamic> toJson() => {
        'nom': nom,
        'banniere': banniere,
        'site': site,
      };
}
