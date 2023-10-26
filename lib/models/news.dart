class News {
  int idNews;
  String titre;
  String texte;
  String imageNews;
  int isRead = 0;

  News({
    required this.idNews,
    required this.titre,
    required this.texte,
    required this.imageNews,
    required this.isRead,
  });

  int get id => idNews;
  set id(int idNews) => this.idNews = idNews;

  String get title => titre;
  set title(String titre) => this.titre = titre;

  String get text => texte;
  set text(String texte) => this.texte = texte;

  String get image => imageNews;
  set image(String imageNews) => this.imageNews = imageNews;

  int get read => isRead;
  set read(int isRead) => this.isRead = isRead;

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      idNews: json['idNews'],
      titre: json['titre'],
      texte: json['texte'],
      imageNews: json['imageNews'],
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idNews': idNews,
      'titre': titre,
      'texte': texte,
      'imageNews': imageNews,
      'isRead': isRead,
    };
  }
}
