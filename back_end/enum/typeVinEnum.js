class TypeVin {
    static vinBlanc = new TypeVin('Vin blanc');
    static vinRouge = new TypeVin('Vin rouge');
    static vinRose = new TypeVin('Vin rosé');
    static vinDessert = new TypeVin('Vin de dessert');
    static vinMousseux = new TypeVin('Vin mousseux');

    constructor(name) {
        this.name = name;
    }

    toString() {
        return `Pays.${this.name}`;
    }
}

module.exports = TypeVin;