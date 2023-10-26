import 'dart:async';
import 'dart:io';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/scene.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/configuration.dart';
import 'models/news.dart';

class DatabaseAstrolabe {
  DatabaseAstrolabe._privateConstructor();
  static final DatabaseAstrolabe instance =
      DatabaseAstrolabe._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'astrolabe.db');
    print(path);

    // Check if the database already exists
    final exists = await File(path).exists();

    // If the database does not exist, create it
    if (!exists) {
      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
        CREATE TABLE SCENE (
        idScene INTEGER PRIMARY KEY AUTOINCREMENT,
        nomScene TEXT NOT NULL,
        imageScene TEXT NOT NULL
        );

        CREATE TABLE NEWS (
        idNews INTEGER PRIMARY KEY AUTOINCREMENT,
        titre TEXT NOT NULL,
        texte TEXT NOT NULL,
        imageNews TEXT NOT NULL,
        isRead INT NOT NULL DEFAULT FALSE
        );

        CREATE TABLE CONFIGURATION (
        nomfestival TEXT NOT NULL,
        logofestival TEXT NOT NULL,
        descriptionfestival TEXT NOT NULL,
        sitewebfestival TEXT NOT NULL,
        facebookfestival TEXT NOT NULL,
        youtubefestival TEXT NOT NULL,
        instagramfestival TEXT NOT NULL,
        mentionlegale TEXT NOT NULL,
        policeEcriture TEXT NOT NULL,
        couleurPrincipale TEXT NOT NULL,
        couleurSecondaire TEXT NOT NULL,
        couleurBackground TEXT NOT NULL,
        videoPromotionnelle TEXT NOT NULL,
        lienBilletterie TEXT NOT NULL
        );

        CREATE TABLE ARTISTE (
        idArtiste INTEGER PRIMARY KEY AUTOINCREMENT,
        nomArtiste TEXT NOT NULL,
        descriptionArtiste TEXT NOT NULL,
        siteWebArtiste TEXT NOT NULL,
        youtubeArtiste TEXT NOT NULL,
        instagramArtiste TEXT NOT NULL,
        facebookArtiste TEXT NOT NULL,
        imageArtiste TEXT NOT NULL
        );

        
        CREATE TABLE PERFORMANCE (
        idPerformance INTEGER PRIMARY KEY AUTOINCREMENT,
        nomPerformance TEXT NOT NULL,
        datePerformance TEXT NOT NULL,
        heureDebutPerformance TEXT NOT NULL,
        heureFinPerformance TEXT NOT NULL,
        scene INTEGER NOT NULL,
        FOREIGN KEY (scene) REFERENCES SCENE(idScene)
        );

        CREATE TABLE PERF_ARTISTE (
        performanceId INTEGER NOT NULL,
        artisteId INTEGER NOT NULL,
        FOREIGN KEY (performanceId) REFERENCES PERFORMANCE(id),
        FOREIGN KEY (artisteId) REFERENCES ARTISTE(id)
        );
        ''');
        },
      );
    }
    return await openDatabase(path);
  }

  // CRUD pour la configuration du festival
  void createConfiguration(Configuration configuration) {
    final db = database;
    db.then((database) async {
      await database!.insert('CONFIGURATION', configuration.toJson());
    });
  }

  Configuration readConfiguration() {
    final db = database;
    db.then((database) async {
      List<Map<String, dynamic>> configurations =
          await database!.query('CONFIGURATION');
      return Configuration.fromJson(configurations.first);
    });
    return Configuration(
        nomfestival: '',
        logofestival: '',
        descriptionfestival: '',
        sitewebfestival: '',
        facebookfestival: '',
        youtubefestival: '',
        instagramfestival: '',
        mentionlegale: '',
        policeEcriture: '',
        couleurPrincipale: '',
        couleurSecondaire: '',
        couleurBackground: '',
        videoPromotionnelle: '',
        lienBilletterie: '');
  }

  void updateConfiguration(Configuration configuration) {
    final db = database;
    db.then((database) async {
      await database!.update('CONFIGURATION', configuration.toJson());
    });
  }

  void deleteConfiguration(Configuration configuration) {
    final db = database;
    db.then((database) async {
      await database!.delete('CONFIGURATION');
    });
  }

  // CRUD pour les artistes
  void createArtiste(Artiste artiste) {
    final db = database;
    db.then((database) async {
      await database!.insert('ARTISTE', artiste.toJson());
    });
  }

  Artiste readArtiste(int idArtiste) {
    final db = database;
    db.then((database) async {
      List<Map<String, dynamic>> artistes = await database!
          .query('ARTISTE', where: 'id = ?', whereArgs: [idArtiste]);
      return Artiste.fromJson(artistes.first);
    });
    return Artiste(
        idArtiste: -1,
        nomArtiste: '',
        descriptionArtiste: '',
        siteWebArtiste: '',
        youtubeArtiste: '',
        instagramArtiste: '',
        facebookArtiste: '',
        imageArtiste: '');
  }

  void updateArtiste(Artiste artiste) {
    final db = database;
    db.then((database) async {
      await database!.update('ARTISTE', artiste.toJson(),
          where: 'id = ?', whereArgs: [artiste.idArtiste]);
    });
  }

  void deleteArtiste(Artiste artiste) {
    final db = database;
    db.then((database) async {
      await database!
          .delete('ARTISTE', where: 'id = ?', whereArgs: [artiste.idArtiste]);
    });
  }
  // Creation du CRUD pour les scenes

  void createScene(Scene scene) {
    final db = database;
    db.then((database) async {
      await database!.insert('SCENE', scene.toJson());
    });
  }

  Scene readScene(int idScene) {
    final db = database;
    db.then((database) async {
      List<Map<String, dynamic>> scenes =
          await database!.query('SCENE', where: 'id = ?', whereArgs: [idScene]);
      return Scene.fromJson(scenes.first);
    });
    return Scene(idScene: -1, nomScene: '', imageScene: '');
  }

  void updateScene(Scene scene) {
    final db = database;
    db.then((database) async {
      await database!.update('SCENE', scene.toJson(),
          where: 'id = ?', whereArgs: [scene.idScene]);
    });
  }

  void deleteScene(Scene scene) {
    final db = database;
    db.then((database) async {
      await database!
          .delete('SCENE', where: 'id = ?', whereArgs: [scene.idScene]);
    });
  }

  // Creation du CRUD pour les news

  void createNews(News news) {
    final db = database;
    db.then((database) async {
      await database!.insert('NEWS', news.toJson());
    });
  }

  News readNews(int idNews) {
    final db = database;
    db.then((database) async {
      List<Map<String, dynamic>> news =
          await database!.query('NEWS', where: 'id = ?', whereArgs: [idNews]);
      return News.fromJson(news.first);
    });
    return News(
      idNews: -1,
      titre: '',
      texte: '',
      imageNews: '',
      isRead: 0,
    );
  }

  void updateNews(News news) {
    final db = database;
    db.then((database) async {
      await database!.update('NEWS', news.toJson(),
          where: 'id = ?', whereArgs: [news.idNews]);
    });
  }

  void deleteNews(News news) {
    final db = database;
    db.then((database) async {
      await database!.delete('NEWS', where: 'id = ?', whereArgs: [news.idNews]);
    });
  }

  // Creation du CRUD pour les performances

  void createPerformance(Performance performance) {
    final db = database;
    // Il faut faire attention, les id des artistes dans performance sont les mêmes qye les id des artistes déjà créés.
    // Il faut donc lier les artistes à la performance en fonction de leur id avec la table PERF_ARTISTE
    db.then((database) async {
      await database!.insert('PERFORMANCE', performance.toJson_database());
      for (Artiste artiste in performance.artistes) {
        await database.insert('PERF_ARTISTE', {
          'performanceId': performance.idPerformance,
          'artisteId': artiste.idArtiste
        });
      }
    });
  }

  Performance readPerformance(int idPerformance) {
    final db = database;
    db.then((database) async {
      List<Map<String, dynamic>> performances = await database!
          .query('PERFORMANCE', where: 'id = ?', whereArgs: [idPerformance]);
      return Performance.fromJson(performances.first);
    });
    return Performance(
        idPerformance: -1,
        nomPerformance: '',
        datePerformance: '',
        heureDebutPerformance: '',
        heureFinPerformance: '',
        artistes: [],
        scene: Scene(idScene: -1, nomScene: '', imageScene: ''));
  }

  void updatePerformance(Performance performance) {
    final db = database;
    db.then((database) async {
      await database!.update('PERFORMANCE', performance.toJson(),
          where: 'id = ?', whereArgs: [performance.idPerformance]);
    });
  }

  void deletePerformance(Performance performance) {
    final db = database;
    db.then((database) async {
      await database!.delete('PERFORMANCE',
          where: 'id = ?', whereArgs: [performance.idPerformance]);
    });
  }

  List<Performance> getPerformancesByArtiste(Artiste artiste) {
    final db = database;
    db.then((database) async {
      List<Map<String, dynamic>> performances = await database!.query(
          'PERF_ARTISTE',
          where: 'artisteId = ?',
          whereArgs: [artiste.idArtiste]);
      return Performance.fromJson(performances.first);
    });
    return [];
  }

  List<Performance> getPerformancesByScene(Scene scene) {
    final db = database;
    db.then((database) async {
      List<Map<String, dynamic>> performances = await database!.query(
          'PERFORMANCE',
          where: 'sceneId = ?',
          whereArgs: [scene.idScene]);
      return Performance.fromJson(performances.first);
    });
    return [];
  }

  List<Performance> getPerformances() {
    final db = database;
    db.then((database) async {
      List<Map<String, dynamic>> performances =
          await database!.query('PERFORMANCE');
      return Performance.fromJson(performances.first);
    });
    return [];
  }

  List<Artiste> getArtistes() {
    final db = database;
    db.then((database) async {
      List<Map<String, dynamic>> artistes = await database!.query('ARTISTE');
      return Artiste.fromJson(artistes.first);
    });
    return [];
  }

  List<Scene> getScenes() {
    final db = database;
    db.then((database) async {
      List<Map<String, dynamic>> scenes = await database!.query('SCENE');
      return Scene.fromJson(scenes.first);
    });
    return [];
  }

  List<News> getNews() {
    final db = database;
    db.then((database) async {
      List<Map<String, dynamic>> news = await database!.query('NEWS');
      return News.fromJson(news.first);
    });
    return [];
  }
}
