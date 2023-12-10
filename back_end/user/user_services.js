const userModel = require('./user_model');
const crypto = require('crypto');

class UserService {
    static async registerUser(id, mdp) {
        const cryptedMdp = crypto.createHash('sha1').update(mdp).digest('hex'); // mdp crypté en SHA-1

        const key = id + cryptedMdp;
        const token = crypto.createHash('sha1').update(key).digest('hex'); // token contenant l'id et le mdp crypté en SHA-1

        try {
            const createUser = new userModel({
                identifiant: id,
                mdp: cryptedMdp,
                isConnected: false,
                isAdmin: false,
                token: token
            });
            return await createUser.save(); // sauvegarde dans la BDD
        } catch (err) {
            throw err;
        }
    }

    static async updateStatus(id, status) {
        userModel.updateOne({ // modification du commentaire à partir de l'id du commentaire renseigné
            identifiant: id
        }, {
            $set: {
                isConnected: status,
            }
        }).then(() => {
            return true;
        }).catch(() => {
            return "Erreur dans l'update !";
        });
    }

    static async login(id, mdp) {
        try {
            const cryptedMdp = crypto.createHash('sha1').update(mdp).digest('hex'); // mdp crypté en SHA-1
            const query = {
                identifiant: id,
                mdp: cryptedMdp
            }

            const findUser = await userModel.findOne(query).exec(); // recherche d'une correspondance (login,mdp) dans la BDD
            this.updateStatus(id, true);
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

    static async findUserByName(name) {
        try {
            const query = {
                identifiant: name,
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

    static async findUserByToken(token) {
        try {
            const query = {
                token: token,
            }
            const findUser = await userModel.findOne(query).exec(); // recherche d'un utilisateur ayant le token renseigné dans la BDD

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
