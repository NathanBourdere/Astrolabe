import 'dart:ui';

class Configuration {
  String nomfestival;
  String logofestival;
  String descriptionfestival;
  String sitewebfestival;
  String facebookfestival;
  String youtubefestival;
  String instagramfestival;
  String mentionlegale;
  String policeEcriture;
  String couleurPrincipale;
  String couleurSecondaire;
  String couleurBackground;
  String videoPromotionnelle;
  String lienBilletterie;

  Configuration({
    required this.nomfestival,
    required this.logofestival,
    required this.descriptionfestival,
    required this.sitewebfestival,
    required this.facebookfestival,
    required this.youtubefestival,
    required this.instagramfestival,
    required this.mentionlegale,
    required this.policeEcriture,
    required this.couleurPrincipale,
    required this.couleurSecondaire,
    required this.couleurBackground,
    required this.videoPromotionnelle,
    required this.lienBilletterie,
  });

  String get getNomfestival => nomfestival;
  set setNomfestival(String value) {
    nomfestival = value;
  }

  String get getLogofestival => logofestival;
  set setLogofestival(String value) {
    logofestival = value;
  }

  String get getDescriptionfestival => descriptionfestival;
  set setDescriptionfestival(String value) {
    descriptionfestival = value;
  }

  String get getSitewebfestival => sitewebfestival;
  set setSitewebfestival(String value) {
    sitewebfestival = value;
  }

  String get getFacebookfestival => facebookfestival;
  set setFacebookfestival(String value) {
    facebookfestival = value;
  }

  String get getYoutubefestival => youtubefestival;
  set setYoutubefestival(String value) {
    youtubefestival = value;
  }

  String get getInstagramfestival => instagramfestival;
  set setInstagramfestival(String value) {
    instagramfestival = value;
  }

  String get getMentionlegale => mentionlegale;
  set setMentionlegale(String value) {
    mentionlegale = value;
  }

  String get getPoliceEcriture => policeEcriture;
  set setPoliceEcriture(String value) {
    policeEcriture = value;
  }

  String get getCouleurPrincipale => couleurPrincipale;
  set setCouleurPrincipale(String value) {
    couleurPrincipale = value;
  }

  String get getCouleurSecondaire => couleurSecondaire;
  set setCouleurSecondaire(String value) {
    couleurSecondaire = value;
  }

  String get getCouleurBackground => couleurBackground;
  set setCouleurBackground(String value) {
    couleurBackground = value;
  }

  String get getVideoPromotionnelle => videoPromotionnelle;
  set setVideoPromotionnelle(String value) {
    videoPromotionnelle = value;
  }

  String get getLienBilletterie => lienBilletterie;
  set setLienBilletterie(String value) {
    lienBilletterie = value;
  }

  factory Configuration.fromJson(Map<String, dynamic> json) {
    return Configuration(
      nomfestival: json['nomfestival'],
      logofestival: json['logofestival'],
      descriptionfestival: json['descriptionfestival'],
      sitewebfestival: json['sitewebfestival'],
      facebookfestival: json['facebookfestival'],
      youtubefestival: json['youtubefestival'],
      instagramfestival: json['instagramfestival'],
      mentionlegale: json['mentionlegale'],
      policeEcriture: json['policeEcriture'],
      couleurPrincipale: json['couleurPrincipale'],
      couleurSecondaire: json['couleurSecondaire'],
      couleurBackground: json['couleurBackground'],
      videoPromotionnelle: json['videoPromotionnelle'],
      lienBilletterie: json['lienBilletterie'],
    );
  }

  Map<String, dynamic> toJson() => {
        'nomfestival': nomfestival,
        'logofestival': logofestival,
        'descriptionfestival': descriptionfestival,
        'sitewebfestival': sitewebfestival,
        'facebookfestival': facebookfestival,
        'youtubefestival': youtubefestival,
        'instagramfestival': instagramfestival,
        'mentionlegale': mentionlegale,
        'policeEcriture': policeEcriture,
        'couleurPrincipale': couleurPrincipale,
        'couleurSecondaire': couleurSecondaire,
        'couleurBackground': couleurBackground,
        'videoPromotionnelle': videoPromotionnelle,
        'lienBilletterie': lienBilletterie,
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
    print(r);
    print(g);
    print(b);
    return backgroundColor;
  }
}
