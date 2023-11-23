const userModel = require('./user_model');
const crypto = require('crypto');

class UserService {
    static async registerUser(id, mdp, nom, prenom) {
        const cryptedMdp = crypto.createHash('sha1').update(mdp).digest('hex'); // mdp crypté en SHA-1
        try {
            const createUser = new userModel({
                identifiant: id,
                mdp: cryptedMdp,
                nom: nom,
                prenom: prenom,
                isConnected: false,
                isAdmin: false
            });
            return await createUser.save(); // sauvegarde dans la BDD
        } catch (err) {
            throw err;
        }
    }

    static async login(id, mdp) {
        try {
            const cryptedMdp = crypto.createHash('sha1').update(mdp).digest('hex'); // mdp crypté en SHA-1
            const query = {
                identifiant: id,
                mdp: cryptedMdp
            }

            const findUser = await userModel.findOne(query).exec(); // recherche d'une correspondance (login,mdp) dans la BDD

            if(findUser) {
                return true;
            }
            return false;
        } 
        catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }

    static async findUserById(_id) {
        try {
            const query = {
                _id: _id,
            }
            const findUser = await userModel.findOne(query).exec(); // recherche d'un utilisateur ayant l'id saisi dans la BDD

            if(findUser) {
                return findUser;
            }
            return false;
        } 
        catch (err) {
            throw err;
        }
    }

    static async findUserByName(id) {
        try {
            const query = {
                identifiant: id,
            }
            const findUser = await userModel.findOne(query).exec(); // recherche d'un utilisateur ayant l'id saisi dans la BDD

            if(findUser) {
                return findUser;
            }
            return false;
        } 
        catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }

    static async deleteUser(id) {
        try {
            const query = {
                identifiant: id,
            }
            const deleteUser = await userModel.deleteOne(query).exec(); // supression de l'utilisateur dans la BDD

            if(deleteUser.deletedCount == 1) {
                return true;
            }
            return false;
        } 
        catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }
}

module.exports = UserService;
