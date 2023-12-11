class Domaine {
    static ChateauMalartic = new Domaine('Chateau Malartic');
    static ChampagneCharles = new Domaine('Champagne Charles');
    static ARLenoble = new Domaine('AR Lenoble');
    static ChateauTracy = new Domaine('Chateau Tracy');
    static ChateauRomanin = new Domaine('Chateau Romanin');
    static CommanderiePeyrassol = new Domaine('Commanderie Peyrassol');
    static ChateauMontus = new Domaine('Chateaux Montus');
    static ChateauBeaubois = new Domaine('Chateau Beaubois');
    static Pernaud = new Domaine('Pernaud');

    constructor(name) {
        this.name = name;
    }

    toString() {
        return `Domaine.${this.name}`;
    }
}

module.exports = Domaine;