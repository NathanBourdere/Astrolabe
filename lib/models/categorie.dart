class Categorie {
  int idCategorie;
  String intituleCategorie;

  Categorie(this.idCategorie, this.intituleCategorie);

  int get getIdCategorie => idCategorie;
  set setIdCategorie(int value) {
    idCategorie = value;
  }

  String get getIntituleCategorie => intituleCategorie;
  set setIntituleCategorie(String value) {
    intituleCategorie = value;
  }

}