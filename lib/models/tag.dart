class Tag {
  int idTag;
  String nom;
  int visible;

  Tag({
    required this.idTag,
    required this.nom,
    required this.visible,
  });

  int get id => idTag;
  set id(int idTag) => this.idTag = idTag;

  String get getNom => nom;
  set setNom(String nom) => this.nom = nom;

  int get getVisible => visible;
  set setVisible(int visible) => this.visible = visible;

  factory Tag.fromJson(Map<String, dynamic> json) {
    var visible = 1;
    if (json['visible'] == false || json['visible'] == 0) {
      visible = 0;
    }
    return Tag(idTag: json['id'], nom: json['nom'], visible: visible);
  }

  Map<String, dynamic> toJson() => {
        'id': idTag,
        'nom': nom,
        'visible': visible,
      };
}
