const commentaireService = require('./commentaire_services');
const userService = require('../user/user_services');
const vinService = require('../vin/vin_services');
const { ObjectId } = require('mongodb');

exports.addCommentaire = async(req, res) => {
    try {
        const { message, id, vin, note } = req.body;
        
        if(message == null || message.length == 0 || message == "null") {
            res.status(400).send("Renseignez le message !");
            return false;
        }

        if(note == null || note.length == 0 || note == "null") {
            res.status(400).send("Renseignez la note !");
            return false;
        }
        
        const d = new Date();
        const stringDate = d.toLocaleDateString() + " à " + d.toLocaleTimeString();

        findUser = await userService.findUserByName(id);
        findVin = await vinService.findVinByName(vin);

        if(!findUser) {
            res.status(400).send(`Utilisateur non existant !`);
            return false;
        }

        if(!findVin) {
            res.status(400).send(`Vin non existant !`);
            return false;
        }

        let commentaireAlreadyExists = await commentaireService.findCommentaireByVinNameAndUser(vin, id);
        let addCommentaire;

        if(commentaireAlreadyExists) {
            try {
                _idToFind = new ObjectId(commentaireAlreadyExists._id);
            }
            catch(err) {
                res.status(400).send('ID incorrect !')
                return false;
            }
            addCommentaire = await commentaireService.updateCommentaire(_idToFind, message, stringDate, note);
        }
        else {
            addCommentaire = await commentaireService.addCommentaire(message, stringDate, findUser, findVin, note);
        }

        if(addCommentaire != false) {
            res.status(200).send('Commentaire ajouté !');
            return true;
        }
        else {
            res.status(400).send(`Erreur lors de l'ajout !`);
            return false;
        }
        
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.findCommentaireByVinName = async(req, res) => {
    try {
        const { nom } = req.body;

        if(nom == null) {
            res.status(400).send("Renseignez le nom du vin !"); // vérification des champs
            return false;
        }

        const findCommentaire = await commentaireService.findCommentaireByVinName(nom); // appel au service pour rechercher le commentaire dans la BDD

        if(findCommentaire) {
            res.status(200).send(findCommentaire);
            return true;
        }
        else {
            res.status(400).send('Commentaire non trouvé !')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.updateCommentaire = async(req, res) => {
    try {
        const { _id, message, note } = req.body;

        const d = new Date();
        const date = d.toLocaleDateString() + " à " + d.toLocaleTimeString();


        if(_id == null || _id.length == 0) {
            res.status(400).send("Renseignez l'id du commentaire !"); // vérification des champs
            return false;
        }

        if(message == null || message.length == 0) {
            res.status(400).send("Renseignez le message du commentaire !"); // vérification des champs
            return false;
        }

        if(date == null || date.length == 0) {
            res.status(400).send("Renseignez la date du commentaire !"); // vérification des champs
            return false;
        }

        if(note != null && note < 0 || note > 5) {
            res.status(400).send("La note doit être comprise entre 1 et 5 !"); // vérification des champs
            return false;
        }

        try {
            _idToFind = new ObjectId(_id);
        }
        catch(err) {
            res.status(400).send('ID incorrect !')
            return false;
        }

        const updateCommentaire = await commentaireService.updateCommentaire(_idToFind, message, date, note); // appel au service pour update le commentaire dans la BDD

        if(updateCommentaire != "Id non trouvé !" && updateCommentaire != "Erreur dans l'update !") {
            res.status(200).send("Commentaire mis à jour !");
            return true;
        }
        else {
            res.status(400).send(updateCommentaire);
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.deleteCommentaire = async(req, res) => {
    try {
        const { _id } = req.body;

        if(_id == null) {
            res.status(400).send("Renseignez l'id du commentaire !"); // vérification des champs 
            return false;
        }

        try {
            _idToFind = new ObjectId(_id);
        }
        catch(err) {
            res.status(400).send('ID incorrect !')
            return false;
        }

        const deleteCommentaire = await commentaireService.deleteCommentaire(_id); // appel au service pour la suppression du commentaire

        if(deleteCommentaire) {
            res.status(200).send("Commentaire supprimé !");
            return true;
        }
        else {
            res.status(400).send('Commentaire non trouvé !')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.getMoyenneByVin = async(req, res) => {
    try {
        const { vin } = req.body;

        if(vin == null) {
            res.status(400).send("Renseignez le vin !"); // vérification des champs 
            return false;
        }

        const getMoyenne = await commentaireService.getMoyenneByVin(vin); // appel au service pour la suppression du commentaire

        if(getMoyenne) {
            res.status(200).send(getMoyenne);
            return true;
        }
        else {
            res.status(400).send('Pas de note trouvée !')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}