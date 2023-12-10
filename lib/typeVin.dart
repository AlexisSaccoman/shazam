class TypeVin {
  static final VinBlanc = TypeVin('Vin Blanc');
  static final VinRouge = TypeVin('Vin Rouge');
  static final VinRose = TypeVin('Vin Rose');
  static final VinDessert = TypeVin('Vin Dessert');
  static final VinMousseux = TypeVin('Vin Mousseux');

  final String name;

  TypeVin(this.name);

  @override
  String toString() {
    return name;
  }

  static List<TypeVin> wineTypes = [
    TypeVin.VinBlanc,
    TypeVin.VinRouge,
    TypeVin.VinRose,
    TypeVin.VinDessert,
    TypeVin.VinMousseux,
  ];
}
