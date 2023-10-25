import 'package:festival/models/artiste.dart';
import 'package:festival/models/scene.dart';
import 'package:festival/tests.dart';

class Performance {
  int idPerformance;
  String nomPerformance;
  DateTime datePerformance;
  String heureDebutPerformance;
  String heureFinPerformance;
  List<Artiste> artistes;
  Scene scene;

  Performance({
    required this.idPerformance,
    required this.nomPerformance,
    required this.datePerformance,
    required this.heureDebutPerformance,
    required this.heureFinPerformance,
    required this.artistes,
    required this.scene,
  });

  int get getIdPerformance => idPerformance;
  set setIdPerformance(int value) {
    idPerformance = value;
  }

  String get getNomPerformance => nomPerformance;
  set setNomPerformance(String value) {
    nomPerformance = value;
  }

  DateTime get getDatePerformance => datePerformance;
  set setDatePerformance(DateTime value) {
    datePerformance = value;
  }

  String get getHeureDebutPerformance => heureDebutPerformance;
  set setHeureDebutPerformance(String value) {
    heureDebutPerformance = value;
  }

  String get getHeureFinPerformance => heureFinPerformance;
  set setHeureFinPerformance(String value) {
    heureFinPerformance = value;
  }

  List<Artiste> get getArtistes => artistes;

  Scene get getScene => scene;
}

List<Performance> getPerformancesByScene(Scene scene) {
  List<Performance> performances = getPerformancesTest();
  List<Performance> performancesInscene = [];
  for (Performance performance in performances) {
    if (performance.getScene.getIdScene == scene.getIdScene) {
      performancesInscene.add(performance);
    }
  }
  return performancesInscene;
}

List<Performance> getPerformancesByArtiste(Artiste artiste) {
  List<Performance> performances = getPerformancesTest();
  List<Performance> performancesByArtiste = [];
  for (Performance performance in performances) {
    for (Artiste artistePerformance in performance.getArtistes) {
      if (artistePerformance.getIdArtiste == artiste.getIdArtiste) {
        performancesByArtiste.add(performance);
      }
    }
  }
  return performancesByArtiste;
}
