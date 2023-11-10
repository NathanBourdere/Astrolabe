// ignore_for_file: non_constant_identifier_names

import 'package:festival/api.dart';
import 'package:festival/database.dart';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/news.dart';
import 'package:festival/models/partenaire.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/scene.dart';

class Modifications {
  String date_modif_artiste;
  String date_modif_performance;
  String date_modif_scene;
  String date_modif_config;
  String date_modif_news;

  Modifications({
    required this.date_modif_artiste,
    required this.date_modif_performance,
    required this.date_modif_scene,
    required this.date_modif_config,
    required this.date_modif_news,
  });

  String get getdate_modif_artiste => date_modif_artiste;
  String get getdate_modif_performance => date_modif_performance;
  String get getdate_modif_scene => date_modif_scene;
  String get getdate_modif_config => date_modif_config;
  String get getdate_modif_news => date_modif_news;

  factory Modifications.fromJson(Map<String, dynamic> json) {
    return Modifications(
      date_modif_artiste: json['date_modif_artiste'],
      date_modif_performance: json['date_modif_performance'],
      date_modif_scene: json['date_modif_scene'],
      date_modif_config: json['date_modif_config'],
      date_modif_news: json['date_modif_news'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date_modif_artiste': date_modif_artiste,
      'date_modif_performance': date_modif_performance,
      'date_modif_scene': date_modif_scene,
      'date_modif_config': date_modif_config,
      'date_modif_news': date_modif_news,
    };
  }

  static Future<Configuration> updateModifications() async {
    // Requete API pour modifier les données

    FestivalApi festivalApi = FestivalApi();
    DatabaseAstrolabe database = DatabaseAstrolabe.instance;
    Modifications newModifs = await festivalApi.getModifications();
    Modifications modifications = await database.getModifications();
    // Si les modifications ne sont pas les mêmes que celles enregistrées en local alors on met à jour la base de données
    // On récupère les données de l'API
    List<Artiste> artistes = await festivalApi.getArtistes();
    List<Scene> scenes = await festivalApi.getScenes();
    List<News> news = await festivalApi.getNews();
    List<Performance> performances = await festivalApi.getPerformances();
    List<Partenaire> partenaires = []; //await festivalApi.getPartenaires();
    Configuration configuration = await festivalApi.getConfiguration();
    print('getconfig');
    print(configuration.couleurBackground);
    // Il faudrait la liste des artistes participants à chaque performance ainsi que les recommandations d'artistes
    Map<int, List<int>> artistesPerformances =
        await festivalApi.getArtistesPerformances();
    Map<int, List<int>> artistesRecommandations =
        await festivalApi.getArtistesRecommandations();
    await database.updateDatabase(
        artistes,
        performances,
        scenes,
        news,
        partenaires,
        newModifs,
        configuration,
        artistesPerformances,
        artistesRecommandations);
    return Configuration.fromJson_database(configuration.toJson());
  }
}
