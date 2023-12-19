// ignore_for_file: non_constant_identifier_names

import 'package:festival/api.dart';
import 'package:festival/database.dart';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/news.dart';
import 'package:festival/models/partenaire.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/scene.dart';
import 'package:festival/models/tag.dart';

class Modifications {
  String date_modif_artiste;
  String date_modif_performance;
  String date_modif_scene;
  String date_modif_config;
  String date_modif_news;
  String date_modif_tags;

  Modifications({
    required this.date_modif_artiste,
    required this.date_modif_performance,
    required this.date_modif_scene,
    required this.date_modif_config,
    required this.date_modif_news,
    required this.date_modif_tags,
  });

  String get getdate_modif_artiste => date_modif_artiste;
  String get getdate_modif_performance => date_modif_performance;
  String get getdate_modif_scene => date_modif_scene;
  String get getdate_modif_config => date_modif_config;
  String get getdate_modif_news => date_modif_news;
  String get getdate_modif_tags => date_modif_tags;

  factory Modifications.fromJson(Map<String, dynamic> json) {
    return Modifications(
      date_modif_artiste: json['date_modif_artiste'],
      date_modif_performance: json['date_modif_performance'],
      date_modif_scene: json['date_modif_scene'],
      date_modif_config: json['date_modif_config'],
      date_modif_news: json['date_modif_news'],
      date_modif_tags: json['date_modif_tags'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date_modif_artiste': date_modif_artiste,
      'date_modif_performance': date_modif_performance,
      'date_modif_scene': date_modif_scene,
      'date_modif_config': date_modif_config,
      'date_modif_news': date_modif_news,
      'date_modif_tags': date_modif_tags,
    };
  }

  static Future<Configuration> updateModifications() async {
    FestivalApi festivalApi = FestivalApi();
    DatabaseAstrolabe database = DatabaseAstrolabe.instance;
    Modifications newModifs = await festivalApi.getModifications();
    Modifications modifications = await database.getModifications();

    List<Artiste> artistes = [];
    List<Performance> performances = [];
    List<Scene> scenes = [];
    List<Tag> tags = [];
    Configuration configuration;

    if (newModifs.date_modif_artiste != modifications.date_modif_artiste) {
      modifications.date_modif_artiste = newModifs.date_modif_artiste;
      artistes = await festivalApi.getArtistes();
    }

    if (newModifs.date_modif_performance !=
        modifications.date_modif_performance) {
      modifications.date_modif_performance = newModifs.date_modif_performance;
      performances = await festivalApi.getPerformances();
    }

    if (newModifs.date_modif_scene != modifications.date_modif_scene) {
      modifications.date_modif_scene = newModifs.date_modif_scene;
      scenes = await festivalApi.getScenes();
    }

    if (newModifs.date_modif_config != modifications.date_modif_config) {
      modifications.date_modif_config = newModifs.date_modif_config;
      configuration = await festivalApi.getConfiguration();
    } else {
      configuration = await database.getConfiguration();
    }
    if (newModifs.date_modif_tags != modifications.date_modif_tags) {
      modifications.date_modif_tags = newModifs.date_modif_tags;
      tags = await festivalApi.getTags();
    }

    List<News> news = [];
    if (newModifs.date_modif_news != modifications.date_modif_news) {
      modifications.date_modif_news = newModifs.date_modif_news;
      news = await festivalApi.getNews();
    }
    List<Partenaire> partenaires = await festivalApi.getPartenaires();

    Map<int, List<int>> artistesPerformances =
        await festivalApi.getArtistesPerformances();
    Map<int, List<int>> artistesRecommandations =
        await festivalApi.getArtistesRecommandations();
    Map<int, List<int>> tagsPerformances =
        await festivalApi.getTagsPerformances();

    await database.updateDatabase(
      artistes,
      performances,
      scenes,
      news,
      partenaires,
      newModifs,
      configuration,
      tags,
      artistesPerformances,
      artistesRecommandations,
      tagsPerformances,
    );

    return Configuration.fromJson_database(configuration.toJson());
  }
}
