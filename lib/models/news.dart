class News {
  int idNews;
  String titre;
  String texte;
  String imageNews;
  bool isRead = false;

  News(this.idNews, this.titre, this.texte, this.imageNews);

  int get id => idNews;
  set id(int idNews) => this.idNews = idNews;

  String get title => titre;
  set title(String titre) => this.titre = titre;

  String get text => texte;
  set text(String texte) => this.texte = texte;

  String get image => imageNews;
  set image(String imageNews) => this.imageNews = imageNews;

  bool get read => isRead;
  set read(bool isRead) => this.isRead = isRead;
}