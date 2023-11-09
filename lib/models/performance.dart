import 'package:festival/models/artiste.dart';
import 'package:festival/models/scene.dart';

class Performance {
  int id;
  String nom;
  String date;
  String heure_debut;
  String heure_fin;
  List<Artiste> artistes;
  Scene scene;

  Performance({
    required this.id,
    required this.nom,
    required this.date,
    required this.heure_debut,
    required this.heure_fin,
    required this.artistes,
    required this.scene,
  });

  int get getid => id;
  set setid(int value) {
    id = value;
  }

  String get getnom => nom;
  set setnom(String value) {
    nom = value;
  }

  String get getdate => date;
  set setdate(String value) {
    date = value;
  }

  String get getheure_debut => heure_debut;
  set setheure_debut(String value) {
    heure_debut = value;
  }

  String get getheure_fin => heure_fin;
  set setheure_fin(String value) {
    heure_fin = value;
  }

  List<Artiste> get getartistes => artistes;
  set setartistes(List<Artiste> value) {
    artistes = value;
  }

  Scene get getscene => scene;
  set setscene(Scene value) {
    scene = value;
  }

  factory Performance.fromJson_api(Map<String, dynamic> json) {
    return Performance(
        id: json['id'],
        nom: json['nom'],
        date: json['date'],
        heure_debut: json['heure_debut'],
        heure_fin: json['heure_fin'],
        artistes: [],
        scene: Scene(
            id: json['scene']['id'],
            nom: json['scene']['nom'],
            image: json['scene']['image']));
  }

  factory Performance.fromJson_database(Map<String, dynamic> json) {
    return Performance(
        id: json['id'],
        nom: json['nom'],
        date: json['date'],
        heure_debut: json['heure_debut'],
        heure_fin: json['heure_fin'],
        artistes: [],
        scene: Scene(id: json['scene'], nom: '', image: ''));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'date': date,
        'heure_debut': heure_debut,
        'heure_fin': heure_fin,
        'artistes': artistes,
        'scene': scene,
      };

  Map<String, dynamic> toJson_database() {
    return {
      'id': id,
      'nom': nom,
      'date': date,
      'heure_debut': heure_debut,
      'heure_fin': heure_fin,
      'scene': scene.id,
    };
  }
}
