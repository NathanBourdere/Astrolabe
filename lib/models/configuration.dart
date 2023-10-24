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
}