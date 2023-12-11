const vinModel = require('./vin_model');
const Domaine = require('../enum/domaineEnum')
const Pays = require('../enum/paysEnum')
const TypeVin = require('../enum/typeVinEnum');

class vinService {
    static async addVin(nom, descriptif, EAN, millesime, tarif, volume, cepage, allergenes, teneurEnAlcool, imgURL, nomDeDomaine, provenance, typeVin) {
        const findDomaine = Domaine[nomDeDomaine];
        const findPays = Pays[provenance];
        const findType = TypeVin[typeVin];
        if (isNaN(tarif) || isNaN(millesime) || isNaN(volume)) {
            return "Le tarif, le millesime et le volume doivent-être des nombres !";
          }
          if(EAN.length != 13) {
            return "L'EAN doit comporter 13 chiffres !";
          }
        if(!(findDomaine instanceof Domaine)) { // si les champs renseignés ne font pas parti de la liste de pays/nom de domaine/type de vin parmi mes Enum 
            return "Domaine incorrect !";
        }
        if(!(findPays instanceof Pays)) {
            return "Pays incorrect !";
        }
        if(!(findType instanceof TypeVin)) { 
            return "Type incorrect !";
        }
        if(millesime < 1472 || millesime > 2023) { // verification de l'année saisie
            return "Millesime incorrect !";
        }
        try {
            const createvin = new vinModel({
                nom: nom,
                descriptif: descriptif,
                EAN: EAN,
                millesime: millesime,
                tarif: tarif,
                volume: volume,
                cepage: cepage, 
                teneurEnAlcool: teneurEnAlcool,
                imgURL: imgURL,
                nomDeDomaine: findDomaine,
                provenance: findPays,
                typeVin: findType
            });
            return await createvin.save(); // sauvegarde du vin dans la BDD
        } catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }

    static async findVinByEAN(ean) {
        try {
            const query = {
                EAN : ean,
            }

            const findVin = await vinModel.findOne(query).exec(); // recherche d'un vin ayant l'id renseigné dans la BDD

            if(findVin) {
                return findVin;
            }
            return false;
        } 
        catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }

    static async findVinByName(nom) {
        try {
            const query = {
                nom: nom,
            }

            const findVin = await vinModel.findOne(query).exec(); // recherche d'un vin ayant le nom renseigné dans la BDD

            if(findVin) {
                return findVin;
            }
            return false;
        } 
        catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }

    static async updateVin(nom, nouveauNom, descriptif, EAN, millesime, tarif, volume, cepage, allergenes, teneurEnAlcool, imgURL, nomDeDomaine, provenance, typeVin) {
        const vin = await this.findVinByName(nom);
        if(!vin) {
            return "Vin non trouvé !";
        }
        const findDomaine = Domaine[nomDeDomaine];
        const findPays = Pays[provenance];
        const findType = TypeVin[typeVin];
        if(!(findDomaine instanceof Domaine)) { // si les champs renseignés ne font pas parti de la liste de pays/nom de domaine etc..
            return "Domaine incorrect !";
        }
        if(!(findPays instanceof Pays)) {
            return "Pays incorrect !";
        }
        if(!(findType instanceof TypeVin)) { 
            return "Type incorrect !";
        }
        if(millesime < 1472 || millesime > 2023) {
            return "Millesime incorrect !";
        }
        vinModel.updateOne({ // modification du vin à partir du nom du vin renseigné
            nom: nom
        }, {
            $set: {
                nom: nouveauNom,
                descriptif: descriptif,
                EAN: EAN,
                millesime: millesime,
                tarif: tarif,
                volume: volume,
                cepage: cepage, 
                allergenes: allergenes.split(","),
                teneurEnAlcool: teneurEnAlcool,
                imgURL: imgURL,
                nomDeDomaine: findDomaine,
                provenance: findPays,
                typeVin: findType
            }
        }).catch(() => {
            console.log("Erreur dans l'update !");
        });
    }

    static async deleteVin(nom) {
        try {
            const query = {
                nom: nom,
            }
            const deleteVin = await vinModel.deleteOne(query).exec(); // supression du vin dans la BDD

            if(deleteVin.deletedCount == 1) {
                return true;
            }
            return false;
        } 
        catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }

    static async findVins() {
        try {
            const query = {}

            const findVin = await vinModel.find(query).exec(); // recherche d'un vin ayant le nom renseigné dans la BDD

            if(findVin) {
                return findVin;
            }
            return false;
        } 
        catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }
}

module.exports = vinService;
