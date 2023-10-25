import 'package:festival/models/artiste.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/scene.dart';

List<Scene> getTestScenes() {
  // Créer les scènes
  final scenes = [
    Scene(
      idScene: 1,
      nomScene: 'Scène 1',
      imageScene: 'https://www.scene1.fr/image.jpg',
    ),
    Scene(
      idScene: 2,
      nomScene: 'Scène 2',
      imageScene: 'https://www.scene2.fr/image.jpg',
    ),
  ];
  return scenes;
}

List<Artiste> getTestArtistes() {
  // Créer les artistes
  final artistes = [
    Artiste(
      idArtiste: 1,
      nomArtiste: 'Jean Dupont',
      descriptionArtiste: 'Peintre français',
      siteWebArtiste: 'https://www.jeandupont.fr',
      youtubeArtiste: 'https://www.youtube.com/user/jeandupont',
      instagramArtiste: 'https://www.instagram.com/jeandupont',
      facebookArtiste: 'https://www.facebook.com/jeandupont',
      imageArtiste: 'https://www.jeandupont.fr/image.jpg',
    ),
    Artiste(
      idArtiste: 2,
      nomArtiste: 'Marie Martin',
      descriptionArtiste: 'Sculptrice française',
      siteWebArtiste: 'https://www.mariemartin.fr',
      youtubeArtiste: 'https://www.youtube.com/user/mariemartin',
      instagramArtiste: 'https://www.instagram.com/mariemartin',
      facebookArtiste: 'https://www.facebook.com/mariemartin',
      imageArtiste: 'https://www.mariemartin.fr/image.jpg',
    ),
  ];
  return artistes;
}

List<Performance> getPerformancesTest() {
  List<Artiste> artistes = getTestArtistes();
  List<Scene> scenes = getTestScenes();
  List<Performance> performances = [
    Performance(
      idPerformance: 1,
      nomPerformance: 'Concert de piano',
      datePerformance: DateTime.now(),
      heureDebutPerformance: '20h00',
      heureFinPerformance: '22h00',
      artistes: artistes,
      scene: scenes[0],
    ),
    Performance(
      idPerformance: 2,
      nomPerformance: 'Exposition de peinture',
      datePerformance: DateTime.now().add(const Duration(days: 1)),
      heureDebutPerformance: '10h00',
      heureFinPerformance: '18h00',
      artistes: artistes,
      scene: scenes[1],
    ),
  ];

  return performances;
}
