const vinService = require('./vin_services');
const userService = require('../user/user_services');

exports.addVin = async(req, res) => {
    try {
        const { nom, descriptif, EAN, tarif, millesime, volume, cepage, allergenes, teneurEnAlcool, imgURL, nomDeDomaine, provenance, typeVin } = req.query;
        if(nom == null || tarif == null || EAN == null) {
            res.status(400).send("Renseignez le nom, le tarif et l'EAN !");
            return false;
        }
        const addVin = await vinService.addVin(nom, descriptif, EAN, millesime, tarif, volume, cepage, allergenes, teneurEnAlcool, imgURL, nomDeDomaine, provenance, typeVin); // appel au service pour l'ajout du vin

        if(addVin != "Domaine incorrect !" && addVin != "Pays incorrect !" && addVin != "Type incorrect !" && addVin != "Millesime incorrect !") { // verification des champs
            res.status(200).send('Vin ajouté !');
            return true;
        }
        else {
            res.status(400).send(addVin);
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.updateVin = async(req, res) => {
    try {
        let { nom, nouveauNom, descriptif, EAN, tarif, millesime, volume, cepage, allergenes, teneurEnAlcool, imgURL, nomDeDomaine, provenance, typeVin } = req.query;
        if(nom == null || tarif == null || EAN == null) {
            res.status(400).send("Renseignez le nom, le tarif et l'EAN !");
            return false;
        }
        if(nouveauNom == null) { // s'il n'y a pas de nouveau nom, on garde l'ancien
            nouveauNom = nom;
        }
        const updateVin = await vinService.updateVin(nom, nouveauNom, descriptif, EAN, millesime, tarif, volume, cepage, allergenes, teneurEnAlcool, imgURL, nomDeDomaine, provenance, typeVin); // appel au service pour l'update du vin

        if(updateVin != "Vin non trouvé !" && updateVin != "Domaine incorrect !" && updateVin != "Pays incorrect !" && updateVin != "Type incorrect !" && updateVin != "Millesime incorrect !" ) { // verification des champs
            res.status(200).send('Vin modifié !');
            return true;
        }
        else {
            res.status(400).send(updateVin);
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.findVinByEAN = async(req, res) => {
    try {
        const { ean } = req.query;

        if(ean == null) {
            res.status(400).send("Renseignez l'EAN du vin !"); // vérification des champs
            return false;
        }

        if(ean.length != 13) {
            res.status(400).send("L'EAN doit comporter 13 chiffres !"); // vérification des champs
            return false;
        }

        const findVin = await vinService.findVinByEAN(ean); // appel au service pour rechercher le vin dans la BDD

        if(findVin) {
            res.status(200).send(findVin);
            return true;
        }
        else {
            res.status(400).send('Vin non trouvé !')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.findVinByName = async(req, res) => {
    try {
        const { nom } = req.query;

        if(nom == null) {
            res.status(400).send("Renseignez le nom du vin !"); // vérification des champs
            return false;
        }

        const findVin = await vinService.findVinByName(nom); // appel au service pour rechercher le vin dans la BDD

        if(findVin) {
            res.status(200).send(findVin);
            return true;
        }
        else {
            res.status(400).send('Vin non trouvé !')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.deleteVin = async(req, res) => {
    try {
        const { nom } = req.query;

        if(nom == null) {
            res.status(400).send("Renseignez le nom du vin !"); // vérification des champs 
            return false;
        }

        //const user = { id : "1", mdp : "2" }

        const findUser = userService.findUserByToken("1e34429ab638a51127171d1f13ed257fb8da57d4");

        if(!findUser) {
            res.status(400).send('Utilisateur non trouvé !')
            return false;
        }

        const deleteVin = await vinService.deleteVin(nom); // appel au service pour la suppression du vin

        if(deleteVin) {
            res.status(200).send("Vin " + nom + " supprimé !");
            return true;
        }
        else {
            res.status(400).send('Vin non trouvé !')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.findVins = async(req, res) => {
    try {

        const findVin = await vinService.findVins(); // appel au service pour rechercher tous les vins dans la BDD

        if(findVin) {
            res.status(200).send(findVin);
            return true;
        }
        else {
            res.status(400).send('Aucun vin trouvé')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}