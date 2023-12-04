const userService = require('./user_services');
const { ObjectId } = require('mongodb');

exports.register = async(req, res) => {
    try {
        const { id, mdp, nom, prenom } = req.query;

        if(id == null || mdp == null || nom == null || prenom == null) { // vérification des champs
            res.status(400).send("Renseignez tous les champs !");
            return false;
        }

        const addUser = await userService.registerUser(id, mdp, nom, prenom); // appel au service pour l'ajout de l'utilisateur

        if(addUser) {
            res.status(200).send('Utilisateur ajouté !');
            return true;
        }
        else {
            res.status(400).send('Erreur lors du register !');
            return false;
        }
    }
    catch(err) {
        res.status(400).send(`L'utilisateur existe déjà !`);
        return false;
    }
}

exports.login = async(req, res) => {
    try {
        const { id, mdp } = req.query;

        if(id == null || mdp == null) {
            res.status(400).send("Renseignez tous les champs !"); // vérification des champs
            return false;
        }

        const findUser = await userService.login(id, mdp); // appel au service pour le login de l'utilisateur

        if(findUser) {
            res.status(200).send('Vous êtes maintenant connecté !')
            return true;
        }
        else {
            res.status(400).send('Connexion échouée !')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.findUserById = async(req, res) => {
    try {
        const { _id } = req.query;

        if(_id == null) {
            res.status(400).send("Renseignez l'id de l'utilisateur !"); // vérification des champs
            return false;
        }

        try {
            _idToFind = new ObjectId(_id);
        }
        catch(err) {
            res.status(400).send('ID incorrect !')
            return false;
        }

        const findUser = await userService.findUserById(_idToFind); // appel au service pour rechercher l'utilisateur dans la BDD

        if(findUser) {
            res.status(200).send(findUser);
            return true;
        }
        else {
            res.status(400).send('Utilisateur non trouvé !')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.findUserByName = async(req, res) => {
    try {
        const { id } = req.query;

        if(id == null) {
            res.status(400).send("Renseignez tous les champs !"); // vérification des champs
            return false;
        }

        const findUser = await userService.findUserByName(id); // appel au service pour rechercher l'utilisateur dans la BDD

        if(findUser) {
            res.status(200).send(findUser);
            return true;
        }
        else {
            res.status(400).send('Utilisateur non trouvé !')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}

exports.deleteUser = async(req, res) => {
    try {
        const { id } = req.query;

        if(id == null) {
            res.status(400).send("Renseignez tous les champs !"); // vérification des champs 
            return false;
        }

        const deleteUser = await userService.deleteUser(id); // appel au service pour la suppression de l'utilisateur

        if(deleteUser) {
            res.status(200).send("Utilisateur " + id + " supprimé !");
            return true;
        }
        else {
            res.status(400).send('Utilisateur non trouvé !')
            return false;
        }
    }
    catch(err) {
        console.log('Erreur controller !' + err);
        throw err;
    }
}