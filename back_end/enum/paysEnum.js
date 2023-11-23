class Pays {
    static France = new Pays('France');
    static Espagne = new Pays('Espagne');
    static Chine = new Pays('Chine');
    static Italie = new Pays('Italie');
    static Turquie = new Pays('Turquie');
    static USA = new Pays('Etats-Unis');
    static Suisse = new Pays('Suisse');
    static Allemagne = new Pays('Allemagne');
    static Argentine = new Pays('Argentine');
    static Chili = new Pays('Chili');
    static Australie = new Pays('Australie');
    static Portugal = new Pays('Portugal');

    constructor(name) {
        this.name = name;
    }

    toString() {
        return `Pays.${this.name}`;
    }
}

module.exports = Pays;