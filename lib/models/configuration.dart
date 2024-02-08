// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

class Configuration {
  String nomFestival;
  String logoFestival;
  String descriptionFestival;
  String siteWebFestival;
  String facebookFestival;
  String youtubeFestival;
  String instagramFestival;
  String mentionsLegales;
  String policeEcriture;
  String couleurPrincipale;
  String couleurSecondaire;
  String couleurBackground;
  String video_promo;
  String mode_festival;

  Configuration({
    required this.nomFestival,
    required this.logoFestival,
    required this.descriptionFestival,
    required this.siteWebFestival,
    required this.facebookFestival,
    required this.youtubeFestival,
    required this.instagramFestival,
    required this.mentionsLegales,
    required this.policeEcriture,
    required this.couleurPrincipale,
    required this.couleurSecondaire,
    required this.couleurBackground,
    required this.video_promo,
    required this.mode_festival,
  });

  String get nomfestival => nomFestival;
  set nomfestival(String value) {
    nomFestival = value;
  }

  String get logofestival => logoFestival;
  set logofestival(String value) {
    logoFestival = value;
  }

  String get descriptionfestival => descriptionFestival;
  set descriptionfestival(String value) {
    descriptionFestival = value;
  }

  String get sitewebfestival => siteWebFestival;
  set sitewebfestival(String value) {
    siteWebFestival = value;
  }

  String get facebookfestival => facebookFestival;
  set facebookfestival(String value) {
    facebookFestival = value;
  }

  String get youtubefestival => youtubeFestival;
  set youtubefestival(String value) {
    youtubeFestival = value;
  }

  String get instagramfestival => instagramFestival;
  set instagramfestival(String value) {
    instagramFestival = value;
  }

  String get mentionlegale => mentionsLegales;
  set mentionlegale(String value) {
    mentionsLegales = value;
  }

  String get getpoliceEcriture => policeEcriture;
  set setpoliceEcriture(String value) {
    policeEcriture = value;
  }

  String get getcouleurPrincipale => couleurPrincipale;
  set setcouleurPrincipale(String value) {
    couleurPrincipale = value;
  }

  String get getcouleurSecondaire => couleurSecondaire;
  set setcouleurSecondaire(String value) {
    couleurSecondaire = value;
  }

  String get getcouleurBackground => couleurBackground;
  set setcouleurBackground(String value) {
    couleurBackground = value;
  }

  String get videoPromotionnelle => video_promo;
  set videoPromotionnelle(String value) {
    video_promo = value;
  }

  String get modeFestival => mode_festival;
  set modeFestival(String value) {
    mode_festival = value;
  }

  factory Configuration.fromJson_database(Map<String, dynamic> json) {
    print(json);
    return Configuration(
      nomFestival: json['nomFestival'],
      logoFestival: json['logoFestival'],
      descriptionFestival: json['descriptionFestival'],
      siteWebFestival: json['siteWebFestival'],
      facebookFestival: json['facebookFestival'],
      youtubeFestival: json['youtubeFestival'],
      instagramFestival: json['instagramFestival'],
      mentionsLegales: json['mentionsLegales'],
      policeEcriture: json['policeEcriture'],
      couleurPrincipale: json['couleurPrincipale'],
      couleurSecondaire: json['couleurSecondaire'],
      couleurBackground: json['couleurBackground'],
      video_promo: json['video_promo'] ?? '',
      mode_festival: 'festival',
    );
  }

  factory Configuration.fromJson_api(Map<String, dynamic> json) {
    return Configuration(
      nomFestival: json['nomFestival'],
      logoFestival: json['logoFestival'],
      descriptionFestival: json['descriptionFestival'],
      siteWebFestival: json['siteWebFestival'],
      facebookFestival: json['facebookFestival'],
      youtubeFestival: json['youtubeFestival'],
      instagramFestival: json['instagramFestival'],
      mentionsLegales: json['mentionsLegales'],
      policeEcriture: json['policeEcriture']['nom'],
      couleurPrincipale: json['couleurPrincipale'],
      couleurSecondaire: json['couleurSecondaire'],
      couleurBackground: json['couleurBackground'],
      video_promo: json['video_promo'] ?? '',
      mode_festival: 'festival',
    );
  }

  Map<String, dynamic> toJson() => {
        'nomFestival': nomFestival,
        'logoFestival': logoFestival,
        'descriptionFestival': descriptionFestival,
        'siteWebFestival': siteWebFestival,
        'facebookFestival': facebookFestival,
        'youtubeFestival': youtubeFestival,
        'instagramFestival': instagramFestival,
        'mentionsLegales': mentionsLegales,
        'policeEcriture': policeEcriture,
        'couleurPrincipale': couleurPrincipale,
        'couleurSecondaire': couleurSecondaire,
        'couleurBackground': couleurBackground,
        'video_promo': video_promo,
      };

  Color get getMainColor {
    final bgr = int.parse(couleurPrincipale.substring(1, 3), radix: 16);
    final bgg = int.parse(couleurPrincipale.substring(3, 5), radix: 16);
    final bgb = int.parse(couleurPrincipale.substring(5, 7), radix: 16);
    final bgopacity = 1.0;
    final backgroundColor = Color.fromRGBO(bgr, bgg, bgb, bgopacity);
    return backgroundColor;
  }

  Color get getFontColor {
    final r = int.parse(couleurSecondaire.substring(1, 3), radix: 16);
    final g = int.parse(couleurSecondaire.substring(3, 5), radix: 16);
    final b = int.parse(couleurSecondaire.substring(5, 7), radix: 16);
    final opacity = 1.0;
    final fontColor = Color.fromRGBO(r, g, b, opacity);
    return fontColor;
  }

  Color get getBackgroundColor {
    final r = int.parse(couleurBackground.substring(1, 3), radix: 16);
    final g = int.parse(couleurBackground.substring(3, 5), radix: 16);
    final b = int.parse(couleurBackground.substring(5, 7), radix: 16);
    final opacity = 1.0;
    final backgroundColor = Color.fromRGBO(r, g, b, opacity);
    return backgroundColor;
  }
}
