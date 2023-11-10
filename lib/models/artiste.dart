import 'package:festival/models/performance.dart';

class Artiste {
  int id;
  String nom;
  List<Artiste> recommendations;
  String description;
  String site_web;
  String youtube;
  String instagram;
  String facebook;
  String image;

  Artiste({
    required this.id,
    required this.nom,
    required this.recommendations,
    required this.description,
    required this.site_web,
    required this.youtube,
    required this.instagram,
    required this.facebook,
    required this.image,
  });

  int get getId => id;
  String get getNom => nom;
  List<Artiste> get getRecommandations => recommendations;
  String get getDescription => description;
  String get getSiteWeb => site_web;
  String get getYoutube => youtube;
  String get getInstagram => instagram;
  String get getFacebook => facebook;
  String get getImage => image;

  factory Artiste.fromJson(Map<String, dynamic> json) {
    return Artiste(
      id: json['id'],
      nom: json['nom'],
      recommendations: [],
      description: json['description'],
      site_web: json['site_web'] ?? '',
      youtube: json['youtube'] ?? '',
      instagram: json['instagram'] ?? '',
      facebook: json['facebook'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'description': description,
      'site_web': site_web,
      'youtube': youtube,
      'instagram': instagram,
      'facebook': facebook,
      'image': image,
    };
  }

  String getTimeLeftBeforePerformance(List<Performance> performances) {
    DateTime now = DateTime.now();
    DateTime nextPerformance = DateTime(9999, 12, 31, 23, 59, 59);
    for (var performance in performances) {
      DateTime performanceDate = DateTime.parse(performance.date);
      DateTime performanceHeureDebut = DateTime(
        performanceDate.year,
        performanceDate.month,
        performanceDate.day,
        int.parse(performance.heure_debut.split(':')[0]),
      );
      if (performanceHeureDebut.isAfter(now) &&
          performanceHeureDebut.isBefore(nextPerformance)) {
        nextPerformance = performanceHeureDebut;
      }
    }
    if (nextPerformance == DateTime(9999, 12, 31, 23, 59, 59)) {
      return 'Pas de performances annoncés';
    } else if (now.isAfter(nextPerformance)) {
      return 'En cours !';
    } else {
      Duration difference = nextPerformance.difference(now);
      if (difference.inHours > 24) {
        return 'Dans ${difference.inDays} jours';
      } else if (difference.inHours > 1) {
        return 'Dans ${difference.inHours} heures';
      } else {
        return 'Dans ${difference.inMinutes} minutes';
      }
    }
  }
}
