class Pays {
  static final France = Pays('France');
  static final Espagne = Pays('Espagne');
  static final Chine = Pays('Chine');
  static final Italie = Pays('Italie');
  static final Turquie = Pays('Turquie');
  static final USA = Pays('Etats-Unis');
  static final Suisse = Pays('Suisse');
  static final Allemagne = Pays('Allemagne');
  static final Argentine = Pays('Argentine');
  static final Chili = Pays('Chili');
  static final Australie = Pays('Australie');
  static final Portugal = Pays('Portugal');

  final String name;

  Pays(this.name);

  @override
  String toString() {
    return name;
  }

  static List<Pays> countries = [
    Pays.France,
    Pays.Espagne,
    Pays.Chine,
    Pays.Italie,
    Pays.Turquie,
    Pays.USA,
    Pays.Suisse,
    Pays.Allemagne,
    Pays.Argentine,
    Pays.Chili,
    Pays.Australie,
    Pays.Portugal,
  ];
}
