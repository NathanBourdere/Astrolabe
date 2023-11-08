import 'dart:convert';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/partenaire.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/scene.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/news.dart';
import 'package:festival/models/modifications.dart';
import 'package:http/http.dart' as http;

class FestivalApi {
  static const baseUrl = 'http://lseas.pythonanywhere.com/festivals/v0';

  Future<List<Artiste>> getArtistes() async {
    final response = await http.get(Uri.parse('$baseUrl/artistes/'));
    if (response.statusCode == 200) {
      final artistes = jsonDecode(response.body) as List;
      return artistes.map((json) => Artiste.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load artistes');
    }
  }

  Future<List<Performance>> getPerformances() async {
    final response = await http.get(Uri.parse('$baseUrl/performances/'));
    if (response.statusCode == 200) {
      final performances = jsonDecode(response.body) as List;
      return performances
          .map((json) => Performance.fromJson_api(json))
          .toList();
    } else {
      throw Exception('Failed to load performances');
    }
  }

  Future<List<Scene>> getScenes() async {
    final response = await http.get(Uri.parse('$baseUrl/scenes/'));
    if (response.statusCode == 200) {
      final scenes = jsonDecode(response.body) as List;
      return scenes.map((json) => Scene.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load scenes');
    }
  }

  Future<List<News>> getNews() async {
    final response = await http.get(Uri.parse('$baseUrl/news/'));
    if (response.statusCode == 200) {
      final news = jsonDecode(response.body) as List;
      return news.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<Configuration> getConfiguration() async {
    final response = await http.get(Uri.parse('$baseUrl/festivals/'));
    if (response.statusCode == 200) {
      final configuration = jsonDecode(response.body);
      return Configuration.fromJson_api(configuration[0]);
    } else {
      throw Exception('Failed to load configuration');
    }
  }

  Future<Modifications> getModifications() async {
    final response = await http.get(Uri.parse('$baseUrl/modifications/'));
    if (response.statusCode == 200) {
      final modifications = jsonDecode(response.body);
      return Modifications.fromJson(modifications[0]);
    } else {
      throw Exception('Failed to load modifications');
    }
  }

  Future<List<Partenaire>> getPartenaires() async {
    final response = await http.get(Uri.parse('$baseUrl/partenaires/'));
    if (response.statusCode == 200) {
      final partenaires = jsonDecode(response.body) as List;
      return partenaires.map((json) => Partenaire.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load partenaires');
    }
  }

  Future<Map<int, List<int>>> getArtistesPerformances() async {
    final response = await http.get(Uri.parse('$baseUrl/performances/'));
    if (response.statusCode == 200) {
      final performances = jsonDecode(response.body) as List;
      Map<int, List<int>> artistesPerformances = {};
      for (var performance in performances) {
        List<dynamic> artistes = performance['artistes'];
        List<int> artistesIds = [];
        for (var artiste in artistes) {
          artistesIds.add(artiste['id']);
        }
        artistesPerformances[performance['id']] = artistesIds;
      }
      return artistesPerformances;
    } else {
      throw Exception('Failed to load artistes');
    }
  }

  Future<Map<int, List<int>>> getArtistesRecommandations() async {
    final response = await http.get(Uri.parse('$baseUrl/artistes/'));
    if (response.statusCode == 200) {
      final artistes = jsonDecode(response.body) as List;
      Map<int, List<int>> artistesRecommandations = {};
      for (var artiste in artistes) {
        List<dynamic> recommandations = artiste['recommendations'];
        List<int> recommandationsIds = [];
        for (var recommandation in recommandations) {
          recommandationsIds.add(recommandation);
        }
        artistesRecommandations[artiste['id']] = recommandationsIds;
      }
      return artistesRecommandations;
    } else {
      throw Exception('Failed to load artistes');
    }
  }
}
