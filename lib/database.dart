// ignore_for_file: unused_import, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/modifications.dart';
import 'package:festival/models/partenaire.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/scene.dart';
import 'package:festival/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'models/news.dart';
import 'dart:collection';
import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/timezone.dart' as tz;

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
    // Check if the database already exists
    final exists = await File(path).exists();

    // If the database does not exist, create it
    if (!exists) {
      print('exist');
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
        image TEXT NOT NULL,
        like INT NOT NULL
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

        CREATE TABLE TAG_PERFORMANCE(
        tagId INTEGER NOT NULL,
        performanceId INTEGER NOT NULL,
        FOREIGN KEY (tagId) REFERENCES TAG(id),
        FOREIGN KEY (performanceId) REFERENCES PERFORMANCE(id)
        );
        

        CREATE TABLE PARTENAIRE (
        idPartenaire INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        banniere TEXT NOT NULL,
        site TEXT NOT NULL
        );

        CREATE TABLE TAG (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        visible INT NOT NULL
        );
        
        CREATE TABLE MODIFICATIONS (  
        date_modif_artiste TEXT NOT NULL,
        date_modif_performance TEXT NOT NULL,
        date_modif_scene TEXT NOT NULL,
        date_modif_config TEXT NOT NULL,
        date_modif_partenaire TEXT NOT NULL,
        date_modif_news TEXT NOT NULL,
        date_modif_tags TEXT NOT NULL
        );

        INSERT INTO MODIFICATIONS (date_modif_artiste, date_modif_performance, date_modif_scene, date_modif_config, date_modif_partenaire, date_modif_news, date_modif_tags) VALUES ('zerferzf', 'ezgezg', 'zegrezg', 'zgegzzeg', 'zegrezg', 'azead', 'indf');

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
    final List<Performance> performances = performancesData
        .map((data) => Performance.fromJson_database(data))
        .toList();

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
    final List<Performance> performances = performancesData
        .map((data) => Performance.fromJson_database(data))
        .toList();

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
    final List<Performance> performances = performancesData
        .map((data) => Performance.fromJson_database(data))
        .toList();

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
          'SELECT DISTINCT PERFORMANCE.id, PERFORMANCE.nom, PERFORMANCE.date, PERFORMANCE.heure_debut, PERFORMANCE.heure_fin, PERFORMANCE.scene FROM PERFORMANCE INNER JOIN PERF_ARTISTE ON PERFORMANCE.id = PERF_ARTISTE.performanceId WHERE PERF_ARTISTE.artisteId = ?',
          [artiste.id]);
      // Convertir les données des performances en objets Performance
      final List<Performance> performances = performancesData
          .map((data) => Performance.fromJson_database(data))
          .toList();
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
          'SELECT DISTINCT ARTISTE.id, ARTISTE.nom, ARTISTE.description, ARTISTE.site_web, ARTISTE.youtube, ARTISTE.instagram, ARTISTE.facebook, ARTISTE.image FROM ARTISTE INNER JOIN PERF_ARTISTE ON ARTISTE.id = PERF_ARTISTE.artisteId WHERE PERF_ARTISTE.performanceId = ?',
          [id]);
      return artistes.map((data) => Artiste.fromJson(data)).toList();
    });
  }

  Future<Scene> getSceneByPerformance(int id) {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> scenes = await database!.rawQuery(
          'SELECT DISTINCT SCENE.id, SCENE.nom, SCENE.image FROM SCENE INNER JOIN PERFORMANCE ON SCENE.id = PERFORMANCE.scene WHERE PERFORMANCE.id = ?',
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

  Future<void> setConfiguration(Configuration configuration) async {
    final db = database;
    return db.then((database) async {
      await database!.update('CONFIGURATION', configuration.toJson());
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

  Future<void> setModifications(Modifications modifications) async {
    final db = database;
    return db.then((database) async {
      await database!.update('MODIFICATIONS', modifications.toJson());
    });
  }

  Future<Artiste> getArtisteById(int idArtiste) {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> artistes = await database!
          .query('ARTISTE', where: 'id = ?', whereArgs: [idArtiste]);
      return Artiste.fromJson(artistes.first);
    });
  }

  Future<List<Artiste>> getArtistesRecos(Artiste artiste) {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> artistes = await database!.rawQuery(
          'SELECT DISTINCT ARTISTE.id, ARTISTE.nom, ARTISTE.description, ARTISTE.site_web, ARTISTE.youtube, ARTISTE.instagram, ARTISTE.facebook, ARTISTE.image FROM ARTISTE INNER JOIN RECO_ARTISTE ON ARTISTE.id = RECO_ARTISTE.artisteId2 WHERE RECO_ARTISTE.artisteId1 = ?',
          [artiste.id]);
      return artistes.map((data) => Artiste.fromJson(data)).toList();
    });
  }

  Future<List<Partenaire>> getPartenaires() {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> partenaires =
      await database!.rawQuery('SELECT DISTINCT * FROM PARTENAIRE');
      return partenaires.map((data) => Partenaire.fromJson(data)).toList();
    });
  }

  Future<List<Tag>> getTagsVisible() {
    final db = database;
    return db.then((database) async {
      List<Map<String, dynamic>> tags = await database!.query('TAG');
      List<Tag> tagsObject = tags.map((data) => Tag.fromJson(data)).toList();
      List<Tag> tagsReturn = [];
      print(tagsObject);
      for (Tag tag in tagsObject) {
        print('tag.visible = ${tag.visible}');
        if (tag.visible == 1) {
          tagsReturn.add(tag);
          print('tag.visible = ${tag.visible}');
        }
      }
      return tagsReturn;
    });
  }

  // put the like of an artiste to 1 or 0
  Future<void> setLike(Artiste artiste, int like) async {
    final db = database;

    if (like == 1) {
      addToCalendar(await getPerformancesByArtiste(artiste));
    }
    return db.then((database) async {
      await database!.update('ARTISTE', {'like': like},
          where: 'id = ?', whereArgs: [artiste.id]);
    });
  }

  Future<void> addToCalendar(List<Performance> performances) async {
    DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
    await _deviceCalendarPlugin.requestPermissions();

    // Check if permission was granted
    if (await _deviceCalendarPlugin.hasPermissions() == false) {
      // Permission was not granted
      print("Calendar permissions not granted");
      return;
    }
    // Initialiser le calendrier

    // Obtenir la liste des calendriers disponibles
    Result<UnmodifiableListView<Calendar>> calendars =
    await _deviceCalendarPlugin.retrieveCalendars();
    // Choisissez le premier calendrier par défaut (vous pouvez ajuster cela selon vos besoins)
    Calendar defaultCalendar = calendars.data![0];
    print('pass');

    for (Performance performance in performances) {
      // Create TZDateTime for start time
      DateTime performanceDate =
      DateTime.parse('${performance.date} ${performance.heure_debut}');
      final startDateTime = tz.TZDateTime.from(
          performanceDate, tz.getLocation('Europe/Paris'));
      Configuration config = await getConfiguration();
      int reminderMinutes = 1440;
      if (config.mode_festival == 'festival') {
        reminderMinutes = 60;
      }

      // Repeat the process for the end time
      DateTime performanceDateEnd =
      DateTime.parse('${performance.date} ${performance.heure_fin}');
      final endDateTime = tz.TZDateTime.from(
          performanceDateEnd, tz.getLocation('Europe/Paris'));

      Event event = Event(
        defaultCalendar.id,
        title: performance.nom,
        description: 'Performance de ${performance.artistes[0].nom}',
        start: startDateTime,
        end: endDateTime,
        location: performance.scene.nom,
        reminders: [
          Reminder(minutes: reminderMinutes),
        ],
      );
      // Ajoutez l'événement au calendrier
      try {
        await _deviceCalendarPlugin.createOrUpdateEvent(event);
        print('Événement ajouté à l\'agenda avec succès.');
      } catch (e) {
        print('Erreur lors de l\'ajout de l\'événement à l\'agenda: $e');
      }
    }
  }

  Future<void> getLike(Artiste artiste) async {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> artistes = await database!
          .query('ARTISTE', where: 'id = ?', whereArgs: [artiste.id]);
      return artistes.first['like'];
    });
  }

  // get liked artists
  Future<List<Artiste>> getLikedArtistes() {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> artistes = await database!.rawQuery(
          'SELECT DISTINCT ARTISTE.id, ARTISTE.nom, ARTISTE.description, ARTISTE.site_web, ARTISTE.youtube, ARTISTE.instagram, ARTISTE.facebook, ARTISTE.image, ARTISTE.like FROM ARTISTE WHERE ARTISTE.like = 1');
      List<Artiste> artistees =
      artistes.map((data) => Artiste.fromJson(data)).toList();
      print(artistees);
      return artistees;
    });
  }

  Future<List<int>> getLikedArtistIds() async {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> artistes = await database!.rawQuery(
          'SELECT DISTINCT ARTISTE.id FROM ARTISTE WHERE ARTISTE.like = 1');
      List<int> artistIds = artistes.map((data) => data['id'] as int).toList();
      return artistIds;
    });
  }


  Future<List<Tag>> getTags() {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> tags = await database!.query('TAG');
      List<Tag> tagsList = tags.map((data) => Tag.fromJson(data)).toList();
      tagsList.add(Tag(idTag: -1, nom: 'Tous', visible: 1));
      return tagsList;
    });
  }

  Future<List<Tag>> getTagsByPerformance(int id) {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> tags = await database!.rawQuery(
          'SELECT DISTINCT TAG.idTag, TAG.nom, TAG.visible FROM TAG INNER JOIN TAG_PERFORMANCE ON TAG.idTag = TAG_PERFORMANCE.tagId WHERE TAG_PERFORMANCE.performanceId = ?',
          [id]);
      return tags.map((data) => Tag.fromJson(data)).toList();
    });
  }

  Future<List<Performance>> getPerformancesByTag(int tag) {
    final db = database;
    if (tag == -1) {
      return getPerformances();
    }
    return db.then((database) async {
      final List<Map<String, dynamic>> performances = await database!.rawQuery(
          'SELECT DISTINCT PERFORMANCE.id, PERFORMANCE.nom, PERFORMANCE.date, PERFORMANCE.heure_debut, PERFORMANCE.heure_fin, PERFORMANCE.scene FROM PERFORMANCE INNER JOIN TAG_PERFORMANCE ON PERFORMANCE.id = TAG_PERFORMANCE.performanceId WHERE TAG_PERFORMANCE.tagId = ?',
          [tag]);
      // Convertir les données des performances en objets Performance
      final List<Performance> performancesList = performances
          .map((data) => Performance.fromJson_database(data))
          .toList();
      // Parcourir chaque performance et obtenir les artistes correspondants
      for (Performance performance in performancesList) {
        final artistes = await getArtistesByPerformance(performance.id);
        performance.artistes = artistes;

        final scene = await getSceneByPerformance(performance.id);
        performance.scene = scene;
      }
      return performancesList;
    });
  }

  Future<String> getArtistImageByTag(Tag tag) {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> artistes = await database!.rawQuery(
          'SELECT DISTINCT ARTISTE.image FROM ARTISTE INNER JOIN PERF_ARTISTE ON ARTISTE.id = PERF_ARTISTE.artisteId INNER JOIN TAG_PERFORMANCE ON PERF_ARTISTE.performanceId = TAG_PERFORMANCE.performanceId WHERE TAG_PERFORMANCE.tagId = ?',
          [tag.idTag]);
      return artistes.first['image'];
    });
  }

  Future<String> getArtistImageByPerformance(Performance performance) {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> artistes = await database!.rawQuery(
          'SELECT DISTINCT ARTISTE.image FROM ARTISTE INNER JOIN PERF_ARTISTE ON ARTISTE.id = PERF_ARTISTE.artisteId WHERE PERF_ARTISTE.performanceId = ?',
          [performance.id]);
      return artistes.first['image'];
    });
  }

  Future<void> deleteAndRecreateDatabase() async {
    // Get the path to the database file
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'your_database_name.db');

    // Delete the existing database file
    await deleteDatabase(path);

    // Recreate the database by calling the init function
    await initDB();
  }

  Future<int> updateDatabase(
      List<Artiste> artistes,
      List<Performance> performances,
      List<Scene> scenes,
      List<News> news,
      List<Partenaire> partenaires,
      Modifications modifications,
      Configuration configuration,
      List<Tag> tags,
      Map<int, List<int>> artistesPerformances,
      Map<int, List<int>> artistesRecommandations,
      Map<int, List<int>> tagsPerformance) async {
    final db = await database;

    // Update or insert MODIFICATIONS
    await db?.insert(
      'MODIFICATIONS',
      modifications.toJson(),
      conflictAlgorithm:
      ConflictAlgorithm.replace, // Use replace to update on conflict
    );

    // Update or insert PARTENAIRE
    for (Partenaire partenaire in partenaires) {
      print(partenaire.nom);
      await db?.insert(
        'PARTENAIRE',
        partenaire.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // Delete configuration and insert new one
    await db?.delete('CONFIGURATION');
    await db?.insert(
      'CONFIGURATION',
      configuration.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Update or insert ARTISTE
    if (artistes != []) {
      for (Artiste artiste in artistes) {
        await db?.insert(
          'ARTISTE',
          artiste.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
    // Update or insert SCENE
    if (scenes != []) {
      for (Scene scene in scenes) {
        await db?.insert(
          'SCENE',
          scene.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    // Update or insert PERFORMANCE
    if (performances != []) {
      for (Performance performance in performances) {
        await db?.insert(
          'PERFORMANCE',
          performance.toJson_database(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    // Update or insert NEWS
    if (news != []) {
      for (News newsItem in news) {
        await db?.insert(
          'NEWS',
          newsItem.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    if (tags != []) {
      for (Tag tag in tags) {
        await db?.insert(
          'TAG',
          tag.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    // Update or insert PERF_ARTISTE
    for (int idArtiste in artistesPerformances.keys) {
      for (int idPerformance in artistesPerformances[idArtiste]!) {
        await db?.insert(
          'PERF_ARTISTE',
          {
            'performanceId': idPerformance,
            'artisteId': idArtiste,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    // Update or insert RECO_ARTISTE
    for (int idArtiste1 in artistesRecommandations.keys) {
      for (int idArtiste2 in artistesRecommandations[idArtiste1]!) {
        await db?.insert(
          'RECO_ARTISTE',
          {
            'artisteId1': idArtiste1,
            'artisteId2': idArtiste2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    // Update or insert TAG_PERFORMANCE
    for (int idTag in tagsPerformance.keys) {
      for (int idPerformance in tagsPerformance[idTag]!) {
        await db?.insert(
          'TAG_PERFORMANCE',
          {
            'tagId': idTag,
            'performanceId': idPerformance,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    return await Future.value(1);
  }

  Future<List<Artiste>> searchArtistes(String value) {
    final db = database;
    return db.then((database) async {
      final List<Map<String, dynamic>> artistes = await database!.rawQuery(
          'SELECT * FROM ARTISTE WHERE nom LIKE ?',
          ['%$value%']);
      return artistes.map((data) => Artiste.fromJson(data)).toList();
    });
  }
}
