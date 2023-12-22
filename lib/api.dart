import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/partenaire.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/scene.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/news.dart';
import 'package:festival/models/modifications.dart';
import 'package:festival/models/tag.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FestivalApi {
  static const baseUrl = 'http://lseas.pythonanywhere.com/festivals/v0';

  Future<List<Artiste>> getArtistes() async {
    final response = await http.get(Uri.parse('$baseUrl/artistes/'));
    if (response.statusCode == 200) {
      final artistes = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      for (var artiste in artistes) {
        if (artiste['image'] != null) {
          final imageResponse = await http.get(Uri.parse(artiste['image']));
          if (imageResponse.statusCode == 200) {
            final imageBytes = imageResponse.bodyBytes;
            final imageUint8List = Uint8List.fromList(imageBytes);
            final directory = await getApplicationDocumentsDirectory();
            final imagePath =
                await File('${directory.path}/artiste_${artiste['id']}.png')
                    .create();
            await imagePath.writeAsBytes(imageUint8List);
            artiste['image'] = imagePath.path;
          }
        }
      }
      return artistes.map((json) => Artiste.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load artistes');
    }
  }

  Future<List<Performance>> getPerformances() async {
    final response = await http.get(Uri.parse('$baseUrl/performances/'));
    if (response.statusCode == 200) {
      final performances = jsonDecode(utf8.decode(response.bodyBytes)) as List;
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
      final scenes = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      for (var scene in scenes) {
        if (scene['image'] != null) {
          final imageResponse = await http.get(Uri.parse(scene['image']));
          if (imageResponse.statusCode == 200) {
            final imageBytes = imageResponse.bodyBytes;
            final imageUint8List = Uint8List.fromList(imageBytes);
            final directory = await getApplicationDocumentsDirectory();
            final imagePath =
                await File('${directory.path}/scene_${scene['id']}.png')
                    .create();
            await imagePath.writeAsBytes(imageUint8List);
            scene['image'] = imagePath.path;
          }
        }
      }
      return scenes.map((json) => Scene.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load scenes');
    }
  }

  Future<List<News>> getNews() async {
    final response = await http.get(Uri.parse('$baseUrl/news/'));
    if (response.statusCode == 200) {
      final news = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      for (var newe in news) {
        if (newe['image'] != null) {
          final imageResponse = await http.get(Uri.parse(newe['image']));
          if (imageResponse.statusCode == 200) {
            final imageBytes = imageResponse.bodyBytes;
            final imageUint8List = Uint8List.fromList(imageBytes);
            final directory = await getApplicationDocumentsDirectory();
            final imagePath =
                await File('${directory.path}/new_${newe['id']}.png').create();
            await imagePath.writeAsBytes(imageUint8List);
            newe['image'] = imagePath.path;
          }
        }
      }
      return news.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<Configuration> getConfiguration() async {
    final response = await http.get(Uri.parse('$baseUrl/configuration/'));
    if (response.statusCode == 200) {
      final configuration = jsonDecode(response.body);
      if (configuration[0]['logoFestival'] != null) {
        final imageResponse =
            await http.get(Uri.parse(configuration[0]['logoFestival']));

        if (imageResponse.statusCode == 200) {
          final imageBytes = imageResponse.bodyBytes;
          final imageUint8List = Uint8List.fromList(imageBytes);
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/logo.png').create();
          await imagePath.writeAsBytes(imageUint8List);
          configuration[0]['logo'] = imagePath.path;
        }

        // download videoFestival
        final videoResponse =
            await http.get(Uri.parse(configuration[0]['video_promo']));
        if (videoResponse.statusCode == 200) {
          final videoBytes = videoResponse.bodyBytes;
          final videoUint8List = Uint8List.fromList(videoBytes);
          final directory = await getApplicationDocumentsDirectory();
          final videoPath = await File('${directory.path}/video.mp4').create();
          await videoPath.writeAsBytes(videoUint8List);
          configuration[0]['video_promo'] = videoPath.path;
        }
      }
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
      final partenaires = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      for (var partenaire in partenaires) {
        if (partenaire['banniere'] != null) {
          final imageResponse =
              await http.get(Uri.parse(partenaire['banniere']));
          if (imageResponse.statusCode == 200) {
            final imageBytes = imageResponse.bodyBytes;
            final imageUint8List = Uint8List.fromList(imageBytes);
            final directory = await getApplicationDocumentsDirectory();
            final imagePath = await File(
                    '${directory.path}/partenaire_${partenaire['id']}.png')
                .create();
            await imagePath.writeAsBytes(imageUint8List);
            partenaire['banniere'] = imagePath.path;
          }
        }
      }
      return partenaires.map((json) => Partenaire.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load partenaires');
    }
  }

  Future<List<Tag>> getTags() async {
    final response = await http.get(Uri.parse('$baseUrl/tags/'));
    if (response.statusCode == 200) {
      final tags = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      return tags.map((json) => Tag.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tags');
    }
  }

  Future<Map<int, List<int>>> getArtistesPerformances() async {
    final response = await http.get(Uri.parse('$baseUrl/performances/'));
    if (response.statusCode == 200) {
      final performances = jsonDecode(utf8.decode(response.bodyBytes)) as List;
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

  Future<Map<int, List<int>>> getTagsPerformances() async {
    final response = await http.get(Uri.parse('$baseUrl/tags/'));
    if (response.statusCode == 200) {
      final tags = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      Map<int, List<int>> tagsPerformances = {};
      for (var tag in tags) {
        List<dynamic> perfs = tag['performances'];
        List<int> perfsIds = [];
        for (var performance in perfs) {
          perfsIds.add(performance['id']);
        }
        tagsPerformances[tag['id']] = perfsIds;
      }
      return tagsPerformances;
    } else {
      throw Exception('Failed to load tags');
    }
  }
}