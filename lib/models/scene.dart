class Scene {
  int idScene;
  String nomScene;
  String imageScene;

  Scene({
    required this.idScene,
    required this.nomScene,
    required this.imageScene,
  });

  int get getIdScene => idScene;
  set setIdScene(int value) {
    idScene = value;
  }

  String get getNomScene => nomScene;
  set setNomScene(String value) {
    nomScene = value;
  }

  String get getImageScene => imageScene;
  set setImageScene(String value) {
    imageScene = value;
  }
}