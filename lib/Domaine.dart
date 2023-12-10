class Domaine {
  static final ChateauMalartic = Domaine('Chateau Malartic');
  static final ChateauSmith = Domaine('Chateau Smith');
  static final ChateauPommard = Domaine('Chateau Pommard');
  static final ChampagneCharles = Domaine('Champagne Charles');
  static final ARLenoble = Domaine('AR Lenoble');
  static final ChateauTracy = Domaine('Chateau Tracy');
  static final ChateauRomanin = Domaine('Chateau Romanin');
  static final CommanderiePeyrassol = Domaine('Commanderie Peyrassol');
  static final ChateauMontus = Domaine('Chateaux Montus');
  static final ChateauBeaubois = Domaine('Chateau Beaubois');

  final String name;

  Domaine(this.name);

  @override
  String toString() {
    return name;
  }

  static List<Domaine> domaines = [
    Domaine.ChateauMalartic,
    Domaine.ChateauSmith,
    Domaine.ChateauPommard,
    Domaine.ChampagneCharles,
    Domaine.ARLenoble,
    Domaine.ChateauTracy,
    Domaine.ChateauRomanin,
    Domaine.CommanderiePeyrassol,
    Domaine.ChateauMontus,
    Domaine.ChateauBeaubois,
  ];
}
