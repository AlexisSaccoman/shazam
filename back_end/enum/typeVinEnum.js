class TypeVin {
    static VinBlanc = new TypeVin('Vin Blanc');
    static VinRouge = new TypeVin('Vin Rouge');
    static VinRose = new TypeVin('Vin Rose');
    static VinDessert = new TypeVin('Vin Dessert');
    static VinMousseux = new TypeVin('Vin Mousseux');

    constructor(name) {
        this.name = name;
    }

    toString() {
        return `Pays.${this.name}`;
    }
}

module.exports = TypeVin;