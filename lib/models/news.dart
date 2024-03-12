class News {
  int idNews;
  String titre;
  String corps;
  String image;
  int isRead = 0;

  News({
    required this.idNews,
    required this.titre,
    required this.corps,
    required this.image,
    required this.isRead,
  });

  int get id => idNews;
  set id(int idNews) => this.idNews = idNews;

  String get gettitre => titre;
  set settitle(String titre) => this.titre = titre;

  String get gettext => corps;
  set settext(String corps) => this.corps = corps;

  String get getimage => image;
  set setimage(String image) => image = image;

  int get read => isRead;
  set read(int isRead) => this.isRead = isRead;

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      idNews: json['id'],
      titre: json['titre'],
      corps: json['corps'],
      image: json['image'],
      isRead: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idNews,
      'titre': titre,
      'corps': corps,
      'image': image,
      'isRead': isRead,
    };
  }
}
