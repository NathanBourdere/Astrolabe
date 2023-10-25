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

  factory Performance.fromJson(Map<String, dynamic> json) {
    return Performance(
      idPerformance: json['idPerformance'],
      nomPerformance: json['nomPerformance'],
      datePerformance: json['datePerformance'],
      heureDebutPerformance: json['heureDebutPerformance'],
      heureFinPerformance: json['heureFinPerformance'],
      artistes: json['artistes'],
      scene: json['scene'],
    );
  }

  Map<String, dynamic> toJson() => {
        'idPerformance': idPerformance,
        'nomPerformance': nomPerformance,
        'datePerformance': datePerformance,
        'heureDebutPerformance': heureDebutPerformance,
        'heureFinPerformance': heureFinPerformance,
        'artistes': artistes,
        'scene': scene,
      };
}
