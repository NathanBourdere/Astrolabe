class Performance {
  int idPerformance;
  String nomPerformance;
  DateTime datePerformance;
  String heureDebutPerformance;
  String heureFinPerformance;

  Performance({
    required this.idPerformance,
    required this.nomPerformance,
    required this.datePerformance,
    required this.heureDebutPerformance,
    required this.heureFinPerformance,
  });

  int get getIdPerformance => idPerformance;
  set setIdPerformance(int value) {
    idPerformance = value;
  }

  String get getNomPerformance => nomPerformance;
  set setNomPerformance(String value) {
    nomPerformance = value;
  }

  DateTime get getDatePerformance => datePerformance;
  set setDatePerformance(DateTime value) {
    datePerformance = value;
  }

  String get getHeureDebutPerformance => heureDebutPerformance;
  set setHeureDebutPerformance(String value) {
    heureDebutPerformance = value;
  }

  String get getHeureFinPerformance => heureFinPerformance;
  set setHeureFinPerformance(String value) {
    heureFinPerformance = value;
  }
}