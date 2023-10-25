import 'package:festival/database.dart';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/news.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/scene.dart';

class TestsDatabaseInsert {
  // Etablir la connection a la base de données
  DatabaseAstrolabe database = DatabaseAstrolabe.instance;
  // Créer des jeux de données
  Configuration configuration = Configuration(
    nomfestival: "Astrolabe",
    logofestival: "assets/images/logo.png",
    descriptionfestival:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquam ultricies, nunc nisl u",
    sitewebfestival: "https://www.astrolabe-grand-figeac.fr/",
    facebookfestival: "https://www.facebook.com/astrolabefigeac/",
    youtubefestival: "https://www.youtube.com/channel/UC4QX6Z6ZQX6Z6ZQX6Z6Z6ZQ",
    instagramfestival: "https://www.instagram.com/astrolabefigeac/",
    mentionlegale: "Mention légale",
    policeEcriture: "Roboto",
    couleurPrincipale: "#000000",
    couleurSecondaire: "#FFFFFF",
    couleurBackground: "#FFFFFF",
    videoPromotionnelle: "assets/videos/video.mp4",
    lienBilletterie: "https://www.astrolabe-grand-figeac.fr/billetterie/",
  );

  List<Scene> scenes = [
    Scene(
      idScene: 1,
      nomScene: "Scene 1",
      imageScene: "assets/images/scene1.jpg",
    ),
    Scene(
      idScene: 2,
      nomScene: "Scene 2",
      imageScene: "assets/images/scene2.jpg",
    ),
    Scene(
      idScene: 3,
      nomScene: "Scene 3",
      imageScene: "assets/images/scene3.jpg",
    ),
    Scene(
      idScene: 4,
      nomScene: "Scene 4",
      imageScene: "assets/images/scene4.jpg",
    ),
    Scene(
      idScene: 5,
      nomScene: "Scene 5",
      imageScene: "assets/images/scene5.jpg",
    ),
    Scene(
      idScene: 6,
      nomScene: "Scene 6",
      imageScene: "assets/images/scene6.jpg",
    ),
    Scene(
      idScene: 7,
      nomScene: "Scene 7",
      imageScene: "assets/images/scene7.jpg",
    ),
    Scene(
      idScene: 8,
      nomScene: "Scene 8",
      imageScene: "assets/images/scene8.jpg",
    ),
    Scene(
      idScene: 9,
      nomScene: "Scene 9",
      imageScene: "assets/images/scene9.jpg",
    ),
  ];

  List<News> news = [
    News(
      idNews: 1,
      titre: "News 1",
      texte: "Texte de la news 1",
      imageNews: "assets/images/news1.jpg",
      isRead: false,
    ),
    News(
      idNews: 2,
      titre: "News 2",
      texte: "Texte de la news 2",
      imageNews: "assets/images/news2.jpg",
      isRead: false,
    ),
    News(
      idNews: 3,
      titre: "News 3",
      texte: "Texte de la news 3",
      imageNews: "assets/images/news3.jpg",
      isRead: false,
    ),
    News(
      idNews: 4,
      titre: "News 4",
      texte: "Texte de la news 4",
      imageNews: "assets/images/news4.jpg",
      isRead: false,
    ),
    News(
      idNews: 5,
      titre: "News 5",
      texte: "Texte de la news 5",
      imageNews: "assets/images/news5.jpg",
      isRead: false,
    ),
    News(
      idNews: 6,
      titre: "News 6",
      texte: "Texte de la news 6",
      imageNews: "assets/images/news6.jpg",
      isRead: false,
    ),
    News(
      idNews: 7,
      titre: "News 7",
      texte: "Texte de la news 7",
      imageNews: "assets/images/news7.jpg",
      isRead: false,
    ),
    News(
      idNews: 8,
      titre: "News 8",
      texte: "Texte de la news 8",
      imageNews: "assets/images/news8.jpg",
      isRead: false,
    ),
  ];

  List<Artiste> artistes = [
    Artiste(
      idArtiste: 1,
      nomArtiste: "Artiste 1",
      descriptionArtiste: "Description de l'artiste 1",
      siteWebArtiste: "https://www.astrolabe-grand-figeac.fr/",
      youtubeArtiste:
          "https://www.youtube.com/channel/UC4QX6Z6ZQX6Z6ZQX6Z6Z6ZQ",
      instagramArtiste: "https://www.instagram.com/astrolabefigeac/",
      facebookArtiste: "https://www.facebook.com/astrolabefigeac/",
      imageArtiste: "assets/images/artiste1.jpg",
    ),
    Artiste(
      idArtiste: 2,
      nomArtiste: "Artiste 2",
      descriptionArtiste: "Description de l'artiste 2",
      siteWebArtiste: "https://www.astrolabe-grand-figeac.fr/",
      youtubeArtiste:
          "https://www.youtube.com/channel/UC4QX6Z6ZQX6Z6ZQX6Z6Z6ZQ",
      instagramArtiste: "https://www.instagram.com/astrolabefigeac/",
      facebookArtiste: "https://www.facebook.com/astrolabefigeac/",
      imageArtiste: "assets/images/artiste2.jpg",
    ),
    Artiste(
      idArtiste: 3,
      nomArtiste: "Artiste 3",
      descriptionArtiste: "Description de l'artiste 3",
      siteWebArtiste: "https://www.astrolabe-grand-figeac.fr",
      youtubeArtiste:
          "https://www.youtube.com/channel/UC4QX6Z6ZQX6Z6ZQX6Z6Z6ZQ",
      instagramArtiste: "https://www.instagram.com/astrolabefigeac/",
      facebookArtiste: "https://www.facebook.com/astrolabefigeac/",
      imageArtiste: "assets/images/artiste3.jpg",
    ),
    Artiste(
      idArtiste: 4,
      nomArtiste: "Artiste 4",
      descriptionArtiste: "Description de l'artiste 4",
      siteWebArtiste: "https://www.astrolabe-grand-figeac.fr",
      youtubeArtiste:
          "https://www.youtube.com/channel/UC4QX6Z6ZQX6Z6ZQX6Z6Z6ZQ",
      instagramArtiste: "https://www.instagram.com/astrolabefigeac/",
      facebookArtiste: "https://www.facebook.com/astrolabefigeac/",
      imageArtiste: "assets/images/artiste4.jpg",
    ),
    Artiste(
      idArtiste: 5,
      nomArtiste: "Artiste 5",
      descriptionArtiste: "Description de l'artiste 5",
      siteWebArtiste: "https://www.astrolabe-grand-figeac.fr",
      youtubeArtiste:
          "https://www.youtube.com/channel/UC4QX6Z6ZQX6Z6ZQX6Z6Z6ZQ",
      instagramArtiste: "https://www.instagram.com/astrolabefigeac/",
      facebookArtiste: "https://www.facebook.com/astrolabefigeac/",
      imageArtiste: "assets/images/artiste5.jpg",
    ),
  ];

  List<Performance> performances = [
    Performance(
      idPerformance: 1,
      nomPerformance: "Performance 1",
      datePerformance: DateTime.now(),
      heureDebutPerformance: "20:00",
      heureFinPerformance: "21:00",
      artistes: [
        Artiste(
          idArtiste: 1,
          nomArtiste: "Artiste 1",
          descriptionArtiste: "Description de l'artiste 1",
          siteWebArtiste: "https://www.astrolabe-grand-figeac.fr/",
          youtubeArtiste:
              "https://www.youtube.com/channel/UC4QX6Z6ZQX6Z6ZQX6Z6Z6ZQ",
          instagramArtiste: "https://www.instagram.com/astrolabefigeac/",
          facebookArtiste: "https://www.facebook.com/astrolabefigeac/",
          imageArtiste: "assets/images/artiste1.jpg",
        ),
        Artiste(
          idArtiste: 2,
          nomArtiste: "Artiste 2",
          descriptionArtiste: "Description de l'artiste 2",
          siteWebArtiste: "https://www.astrolabe-grand-figeac.fr/",
          youtubeArtiste:
              "https://www.youtube.com/channel/UC4QX6Z6ZQX6Z6ZQX6Z6Z6ZQ",
          instagramArtiste: "https://www.instagram.com/astrolabefigeac/",
          facebookArtiste: "https://www.facebook.com/astrolabefigeac/",
          imageArtiste: "assets/images/artiste2.jpg",
        ),
      ],
      scene: Scene(
        idScene: 1,
        nomScene: "Scene 1",
        imageScene: "assets/images/scene1.jpg",
      ),
    ),
    Performance(
      idPerformance: 2,
      nomPerformance: "Performance 2",
      datePerformance: DateTime.now(),
      heureDebutPerformance: "20:00",
      heureFinPerformance: "21:00",
      artistes: [
        Artiste(
          idArtiste: 3,
          nomArtiste: "Artiste 3",
          descriptionArtiste: "Description de l'artiste 3",
          siteWebArtiste: "https://www.astrolabe-grand-figeac.fr",
          youtubeArtiste:
              "https://www.youtube.com/channel/UC4QX6Z6ZQX6Z6ZQX6Z6Z6ZQ",
          instagramArtiste: "https://www.instagram.com/astrolabefigeac/",
          facebookArtiste: "https://www.facebook.com/astrolabefigeac/",
          imageArtiste: "assets/images/artiste3.jpg",
        ),
        Artiste(
          idArtiste: 4,
          nomArtiste: "Artiste 4",
          descriptionArtiste: "Description de l'artiste 4",
          siteWebArtiste: "https://www.astrolabe-grand-figeac.fr",
          youtubeArtiste:
              "https://www.youtube.com/channel/UC4QX6Z6ZQX6Z6ZQX6Z6Z6ZQ",
          instagramArtiste: "https://www.instagram.com/astrolabefigeac/",
          facebookArtiste: "https://www.facebook.com/astrolabefigeac/",
          imageArtiste: "assets/images/artiste4.jpg",
        ),
      ],
      scene: Scene(
        idScene: 2,
        nomScene: "Scene 2",
        imageScene: "assets/images/scene2.jpg",
      ),
    ),
    Performance(
      idPerformance: 3,
      nomPerformance: "Performance 3",
      datePerformance: DateTime.now(),
      heureDebutPerformance: "20:00",
      heureFinPerformance: "21:00",
      artistes: [
        Artiste(
          idArtiste: 5,
          nomArtiste: "Artiste 5",
          descriptionArtiste: "Description de l'artiste 5",
          siteWebArtiste: "https://www.astrolabe-grand-figeac.fr",
          youtubeArtiste:
              "https://www.youtube.com/channel/UC4QX6Z6ZQX6Z6ZQX6Z6Z6ZQ",
          instagramArtiste: "https://www.instagram.com/astrolabefigeac/",
          facebookArtiste: "https://www.facebook.com/astrolabefigeac/",
          imageArtiste: "assets/images/artiste5.jpg",
        ),
      ],
      scene: Scene(
        idScene: 3,
        nomScene: "Scene 3",
        imageScene: "assets/images/scene3.jpg",
      ),
    ),
  ];

  // Insertions dans la base de données

  Future<void> insertConfiguration() async {
    database.createConfiguration(configuration);
  }

  Future<void> insertScenes() async {
    for (Scene scene in scenes) {
      database.createScene(scene);
    }
  }

  Future<void> insertNews() async {
    for (News news in news) {
      database.createNews(news);
    }
  }

  Future<void> insertArtistes() async {
    for (Artiste artiste in artistes) {
      database.createArtiste(artiste);
    }
  }

  Future<void> insertPerformances() async {
    for (Performance performance in performances) {
      database.createPerformance(performance);
    }
  }

  Future<void> insertAll() async {
    await insertConfiguration();
    await insertScenes();
    await insertNews();
    await insertArtistes();
    await insertPerformances();
  }
}
