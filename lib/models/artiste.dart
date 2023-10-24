class Artiste {
  int idArtiste;
  String nomArtiste;
  String descriptionArtiste;
  String siteWebArtiste;
  String youtubeArtiste;
  String instagramArtiste;
  String facebookArtiste;
  String imageArtiste;

  Artiste({
    required this.idArtiste,
    required this.nomArtiste,
    required this.descriptionArtiste,
    required this.siteWebArtiste,
    required this.youtubeArtiste,
    required this.instagramArtiste,
    required this.facebookArtiste,
    required this.imageArtiste,
  });

  int get getIdArtiste => idArtiste;
  set setIdArtiste(int value) {
    idArtiste = value;
  }

  String get getNomArtiste => nomArtiste;
  set setNomArtiste(String value) {
    nomArtiste = value;
  }

  String get getDescriptionArtiste => descriptionArtiste;
  set setDescriptionArtiste(String value) {
    descriptionArtiste = value;
  }

  String get getSiteWebArtiste => siteWebArtiste;
  set setSiteWebArtiste(String value) {
    siteWebArtiste = value;
  }

  String get getYoutubeArtiste => youtubeArtiste;
  set setYoutubeArtiste(String value) {
    youtubeArtiste = value;
  }

  String get getInstagramArtiste => instagramArtiste;
  set setInstagramArtiste(String value) {
    instagramArtiste = value;
  }

  String get getFacebookArtiste => facebookArtiste;
  set setFacebookArtiste(String value) {
    facebookArtiste = value;
  }

  String get getImageArtiste => imageArtiste;
  set setImageArtiste(String value) {
    imageArtiste = value;
  }

  factory Artiste.fromJson(Map<String, dynamic> json) {
    return Artiste(
      idArtiste: json['idArtiste'],
      nomArtiste: json['nomArtiste'],
      descriptionArtiste: json['descriptionArtiste'],
      siteWebArtiste: json['siteWebArtiste'],
      youtubeArtiste: json['youtubeArtiste'],
      instagramArtiste: json['instagramArtiste'],
      facebookArtiste: json['facebookArtiste'],
      imageArtiste: json['imageArtiste'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idArtiste': idArtiste,
      'nomArtiste': nomArtiste,
      'descriptionArtiste': descriptionArtiste,
      'siteWebArtiste': siteWebArtiste,
      'youtubeArtiste': youtubeArtiste,
      'instagramArtiste': instagramArtiste,
      'facebookArtiste': facebookArtiste,
      'imageArtiste': imageArtiste,
    };
  }


}