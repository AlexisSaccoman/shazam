const commentaireService = require('./commentaire_services');
const userService = require('../user/user_services');
const vinService = require('../vin/vin_services');
const { ObjectId } = require('mongodb');

exports.addCommentaire = async(req, res) => {
    try {
        const { message, id, vin } = req.query;
        
        if(message == null || vin == null || id == null) {
            res.status(400).send("Renseignez tous les champs !");
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

        const addCommenataire = await commentaireService.addCommentaire(message, stringDate, findUser, findVin);

        if(addCommenataire) {
            res.status(200).send('Commentaire ajoutée !');
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

exports.findCommentaireById = async(req, res) => {
    try {
        const { _id } = req.query;

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

        const findCommentaire = await commentaireService.findCommentaireById(_idToFind); // appel au service pour rechercher le commentaire dans la BDD

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
        const { _id, message } = req.query;

        const d = new Date();
        const date = d.toLocaleDateString() + " à " + d.toLocaleTimeString();


        if(_id == null) {
            res.status(400).send("Renseignez l'id du commentaire !"); // vérification des champs
            return false;
        }

        if(message == null) {
            res.status(400).send("Renseignez le message du commentaire !"); // vérification des champs
            return false;
        }

        if(date == null) {
            res.status(400).send("Renseignez la date du commentaire !"); // vérification des champs
            return false;
        }

        try {
            _idToFind = new ObjectId(_id);
        }
        catch(err) {
            res.status(400).send('ID incorrect !')
            return false;
        }

        const updateCommentaire = await commentaireService.updateCommentaire(_idToFind, message, date); // appel au service pour update le commentaire dans la BDD

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
        const { _id } = req.query;

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