import 'dart:async';
import 'dart:io';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/modifications.dart';
import 'package:festival/models/partenaire.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/scene.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
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
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'astrolabe.db');
    print(path);
    // Check if the database already exists
    final exists = await File(path).exists();

    // If the database does not exist, create it
    if (!exists) {
      debugPrint('Not exists');
      await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
        CREATE TABLE SCENE (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        image TEXT NOT NULL
        );

        CREATE TABLE NEWS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titre TEXT NOT NULL,
        corps TEXT NOT NULL,
        image TEXT NOT NULL,
        isRead INT NOT NULL DEFAULT FALSE
        );

        CREATE TABLE CONFIGURATION (
        nomFestival TEXT NOT NULL,
        logoFestival TEXT NOT NULL,
        descriptionFestival TEXT NOT NULL,
        siteWebFestival TEXT NOT NULL,
        facebookFestival TEXT NOT NULL,
        youtubeFestival TEXT NOT NULL,
        instagramFestival TEXT NOT NULL,
        mentionsLegales TEXT NOT NULL,
        policeEcriture TEXT NOT NULL,
        couleurPrincipale TEXT NOT NULL,
        couleurSecondaire TEXT NOT NULL,
        couleurBackground TEXT NOT NULL,
        video_promo TEXT NOT NULL
        );

        CREATE TABLE ARTISTE (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        description TEXT NOT NULL,
        site_web TEXT NOT NULL,
        youtube TEXT NOT NULL,
        instagram TEXT NOT NULL,
        facebook TEXT NOT NULL,
        image TEXT NOT NULL
        );

        
        CREATE TABLE PERFORMANCE (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        date TEXT NOT NULL,
        heure_debut TEXT NOT NULL,
        heure_fin TEXT NOT NULL,
        scene INTEGER NOT NULL,
        FOREIGN KEY (scene) REFERENCES SCENE(id)
        );

        CREATE TABLE PERF_ARTISTE (
        performanceId INTEGER NOT NULL,
        artisteId INTEGER NOT NULL,
        FOREIGN KEY (performanceId) REFERENCES PERFORMANCE(id),
        FOREIGN KEY (artisteId) REFERENCES ARTISTE(id)
        );

        CREATE TABLE RECO_ARTISTE(
        artisteId1 INTEGER NOT NULL,
        artisteId2 INTEGER NOT NULL,
        FOREIGN KEY (artisteId1) REFERENCES ARTISTE(id),
        FOREIGN KEY (artisteId2) REFERENCES ARTISTE(id)
        );

        CREATE TABLE PARTENAIRE (
        idPartenaire INTEGER PRIMARY KEY AUTOINCREMENT,
        nomPartenaire TEXT NOT NULL,
        logoPartenaire TEXT NOT NULL,
        lienPartenaire TEXT NOT NULL
        );
        
        CREATE TABLE MODIFICATIONS (
        date_modif_artiste TEXT NOT NULL,
        date_modif_performance TEXT NOT NULL,
        date_modif_scene TEXT NOT NULL,
        date_modif_config TEXT NOT NULL,
        date_modif_news TEXT NOT NULL
        );

        INSERT INTO MODIFICATIONS (date_modif_artiste, date_modif_performance, date_modif_scene, date_modif_config, date_modif_news) VALUES ('zerferzf', 'ezgezg', 'zegrezg', 'zgegzzeg', 'zegrezg');

        ''');
        },
      );
      await Future.delayed(const Duration(milliseconds: 500));
    }
    return await openDatabase(path);
  }

  Future<List<Performance>> getPerformances() async {
    final db = database;
    final List<Map<String, dynamic>> performancesData =
        await db.then((database) => database!.query('PERFORMANCE'));

    // Convertir les données des performances en objets Performance
    final List<Performance> performances =
        performancesData.map((data) => Performance.fromJson(data)).toList();

    // Parcourir chaque performance et obtenir les artistes correspondants
    for (var performance in performances) {
      final artistes = await getArtistesByPerformance(performance.id);
      performance.artistes = artistes;

      final scene = await getSceneByPerformance(performance.id);
      performance.scene = scene;
    }
    return performances;
  }

  Future<List<Performance>> getPerformancesByScene(Scene scene) async {
    final db = database;
    final List<Map<String, dynamic>> performancesData = await db.then(
        (database) => database!
            .query('PERFORMANCE', where: 'scene = ?', whereArgs: [scene.id]));

    // Convertir les données des performances en objets Performance
    final List<Performance> performances =
        performancesData.map((data) => Performance.fromJson(data)).toList();

    // Parcourir chaque performance et obtenir les artistes correspondants
    for (var performance in performances) {
      final artistes = await getArtistesByPerformance(performance.id);
      performance.artistes = artistes;

      final scene = await getSceneByPerformance(performance.id);
      performance.scene = scene;
    }
    return performances;
  }

  Future<Performance> getPerformanceById(int id) async {
    final db = database;
    final List<Map<String, dynamic>> performancesData = await db.then(
        (database) =>
            database!.query('PERFORMANCE', where: 'id = ?', whereArgs: [id]));

    // Convertir les données des performances en objets Performance
    final List<Performance> performances =
        performancesData.map((data) => Performance.fromJson(data)).toList();

    // Parcourir chaque performance et obtenir les artistes correspondants
    for (var performance in performances) {
      final artistes = await getArtistesByPerformance(performance.id);
      performance.artistes = artistes;

      final scene = await getSceneByPerformance(performance.id);
      performance.scene = scene;
    }
    return performances.first;
  }

  Future<List<Performance>> getPerformancesByArtiste(Artiste artiste) async {
    final db = database;
    return db.then((database) async {
      final List<
          Map<String,
              dynamic>> performancesData = await database!.rawQuery(
          'SELECT PERFORMANCE.id, PERFORMANCE.nom, PERFORMANCE.date, PERFORMANCE.heure_debut, PERFORMANCE.heure_fin, PERFORMANCE.scene FROM PERFORMANCE INNER JOIN PERF_ARTISTE ON PERFORMANCE.id = PERF_ARTISTE.performanceId WHERE PERF_ARTISTE.artisteId = ?',
          [artiste.id]);
      // Convertir les données des performances en objets Performance
      final List<Performance> performances =
          performancesData.map((data) => Performance.fromJson(data)).toList();
      // Parcourir chaque performance et obtenir les artistes correspondants
      for (Performance performance in performances) {
        final artistes = await getArtistesByPerformance(performance.id);
        performance.artistes = artistes;

        final scene = await getSceneByPerformance(performance.id);
        performance.scene = scene;
      }
      return performances;
    });
  }

  Future<List<Artiste>> getArtistes() {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> artistes =
          await database!.query('ARTISTE');
      return artistes.map((data) => Artiste.fromJson(data)).toList();
    });
  }

  Future<List<Scene>> getScenes() {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> scenes = await database!.query('SCENE');
      return scenes.map((data) => Scene.fromJson(data)).toList();
    });
  }

  Future<List<News>> getNews() {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> news = await database!.query('NEWS');
      return news.map((data) => News.fromJson(data)).toList();
    });
  }

  Future<List<Artiste>> getArtistesByPerformance(int id) {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> artistes = await database!.rawQuery(
          'SELECT ARTISTE.id, ARTISTE.nom, ARTISTE.description, ARTISTE.site_web, ARTISTE.youtube, ARTISTE.instagram, ARTISTE.facebook, ARTISTE.image FROM ARTISTE INNER JOIN PERF_ARTISTE ON ARTISTE.idArtiste = PERF_ARTISTE.artisteId WHERE PERF_ARTISTE.performanceId = ?',
          [id]);
      return artistes.map((data) => Artiste.fromJson(data)).toList();
    });
  }

  Future<Scene> getSceneByPerformance(int id) {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> scenes = await database!.rawQuery(
          'SELECT SCENE.id, SCENE.nom, SCENE.image FROM SCENE INNER JOIN PERFORMANCE ON SCENE.id = PERFORMANCE.scene WHERE PERFORMANCE.id = ?',
          [id]);
      return Scene.fromJson(scenes.first);
    });
  }

  Future<Configuration> getConfiguration() {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> configurations =
          await database!.query('CONFIGURATION');
      return Configuration.fromJson_database(configurations.first);
    });
  }

  Future<Modifications> getModifications() {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> modifications =
          await database!.query('MODIFICATIONS');
      return Modifications.fromJson(modifications.first);
    });
  }

  void updateDatabase(
      List<Artiste> artistes,
      List<Performance> performances,
      List<Scene> scenes,
      List<News> news,
      List<Partenaire> partenaires,
      Modifications modifications,
      Configuration configuration) async {
    // delete tout et refill les tables
    final db = database;
    db.then((database) async {
      await database!.delete('ARTISTE');
      await database.delete('PERFORMANCE');
      await database.delete('SCENE');
      await database.delete('NEWS');
      await database.delete('PARTENAIRE');
      await database.delete('MODIFICATIONS');
      await database.delete('CONFIGURATION');
      await database.insert('MODIFICATIONS', modifications.toJson());
      print(configuration.toJson());
      await database.insert('CONFIGURATION', configuration.toJson());
      for (Artiste artiste in artistes) {
        await database.insert('ARTISTE', artiste.toJson());
      }
      for (Performance performance in performances) {
        await database.insert('PERFORMANCE', performance.toJson_database());
      }
      for (Scene scene in scenes) {
        await database.insert('SCENE', scene.toJson());
      }
      for (News news in news) {
        await database.insert('NEWS', news.toJson());
      }
      for (Partenaire partenaire in partenaires) {
        await database.insert('PARTENAIRE', partenaire.toJson());
      }
    });
  }
}
