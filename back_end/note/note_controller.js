const noteService = require('./note_services');
const userService = require('../user/user_services');
const vinService = require('../vin/vin_services');
const { ObjectId } = require('mongodb');

exports.addNote = async(req, res) => {
    try {
        const { nbEtoiles, vin, id } = req.body;
        if(nbEtoiles == null || vin == null || id == null) {
            res.status(400).send("Renseignez tous les champs !"); // vérification des champs
            return false;
        }

        if(nbEtoiles < 1 || nbEtoiles > 5 ) {
            res.status(400).send("Entrez une notre entre 1 et 5 !"); // vérification de la note
            return false;
        }

        const findUser = await userService.findUserByName(id); // recherche d'un utilisateur à partir de son pseudo
        const findVin = await vinService.findVinByName(vin); // recherche d'un vin à partir de son nom

        if(!findUser) {
            res.status(400).send(`Utilisateur non existant !`);
            return false;
        }
        if(!findVin) {
            res.status(400).send(`Vin non trouvé !`);
            return false;
        }

        const addNote = await noteService.addNote(nbEtoiles, findVin, findUser); // appel au service pour ajouter une note

        if(addNote) {
            res.status(200).send('Note ajoutée !');
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

exports.findNoteById = async(req, res) => {
    try {
        const { _id } = req.body;

        if(_id == null) {
            res.status(400).send("Renseignez l'id de la note !"); // vérification des champs
            return false;
        }

        try {
            _idToFind = new ObjectId(_id);
        }
        catch(err) {
            res.status(400).send('ID incorrect !')
            return false;
        }

        const findNote = await noteService.findNoteById(_idToFind); // appel au service pour rechercher la note dans la BDD

        if(findNote) {
            res.status(200).send(findNote);
            return true;
        }
        else {
            res.status(400).send('Note non trouvé !')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.updateNote = async(req, res) => {
    try {
        const { _id, nbEtoiles } = req.body;

        if(_id == null) {
            res.status(400).send("Renseignez l'id de la note !"); // vérification des champs
            return false;
        }

        if(nbEtoiles == null) {
            res.status(400).send("Renseignez le nombre d'étoiles de la note !"); // vérification des champs
            return false;
        }

        if(nbEtoiles < 1 || nbEtoiles > 5 ) {
            res.status(400).send("Entrez une notre entre 1 et 5 !"); // vérification de la note
            return false;
        }

        try {
            _idToFind = new ObjectId(_id);
        }
        catch(err) {
            res.status(400).send('ID incorrect !')
            return false;
        }

        const updateNote = await noteService.updateNote(_idToFind, nbEtoiles); // appel au service pour update la note dans la BDD

        if(updateNote != "Id non trouvé !" && updateNote != "Erreur dans l'update !") {
            res.status(200).send("Note mise à jour !");
            return true;
        }
        else {
            res.status(400).send(updateNote);
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.deleteNote = async(req, res) => {
    try {
        const { _id } = req.body;

        if(_id == null) {
            res.status(400).send("Renseignez l'id de la note !"); // vérification des champs 
            return false;
        }

        try {
            _idToFind = new ObjectId(_id);
        }
        catch(err) {
            res.status(400).send('ID incorrect !')
            return false;
        }

        const deleteNote = await noteService.deleteNote(_id); // appel au service pour la suppression de la note

        if(deleteNote) {
            res.status(200).send("Note supprimée !");
            return true;
        }
        else {
            res.status(400).send('Note non trouvé !')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}
