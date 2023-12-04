class Domaine {
    static ChateauMalartic = new Domaine('Château Malartic Lagravière');
    static ChateauSmith = new Domaine('Château Smith Haut Lafitte');
    static ChateauPommard = new Domaine('Château de Pommard');
    static ChampagneCharles = new Domaine('Champagne Charles Mignon');
    static ARLenoble = new Domaine('AR Lenoble');
    static ChateauTracy = new Domaine('Château de Tracy');
    static ChateauRomanin = new Domaine('Château Romanin');
    static CommanderiePeyrassol = new Domaine('Commanderie de Peyrassol');
    static ChateauMontus = new Domaine('Châteaux Montus et Bouscassé');
    static ChateauBeaubois = new Domaine('Château Beaubois');

    constructor(name) {
        this.name = name;
    }

    toString() {
        return `Domaine.${this.name}`;
    }
}

module.exports = Domaine;