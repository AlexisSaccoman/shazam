const commentaireModel = require('./commentaire_model');

class commentaireService {
    static async addCommentaire(message, date, utilisateur, vin, note) {
        try {
            const _idUser = utilisateur._id;
            const pseudoUser = utilisateur.identifiant;
            const _idVin = vin._id;
            const nomVin = vin.nom;
            const createCommentaire = new commentaireModel({
                message: message,
                date: date,
                utilisateur: {_idUser, pseudoUser},
                vin: { _idVin, nomVin },
                note : note
            });
            return await createCommentaire.save();
        } catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }

    static async findCommentaireByVinName(nom) {
        try {
            const query = {
                'vin.nomVin': nom
            };
              
            const findCommentaire = await commentaireModel.find(query).exec(); // recherche des commentaires ayant le vin saisi dans la BDD

            if(findCommentaire) {
                return findCommentaire;
            }
            return false;
        } 
        catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }

    static async findCommentaireByVinNameAndUser(nom, utilisateur) {
        try {
            const query = {
                'vin.nomVin': nom,
                'utilisateur.pseudoUser': utilisateur
            };
              
            const findCommentaire = await commentaireModel.findOne(query).exec(); // recherche des commentaires ayant le vin saisi dans la BDD

            if(findCommentaire) {
                return findCommentaire;
            }
            return false;
        } 
        catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }

    static async updateCommentaire(_id, message, date, note) {
        commentaireModel.updateOne({ // modification du commentaire à partir de l'id du commentaire renseigné
            _id: _id
        }, {
            $set: {
                message: message,
                date: date,
                note: note
            }
        }).catch(() => {
            return "Erreur dans l'update !";
        });
    }

    static async deleteCommentaire(_id) {
        try {
            const query = {
                _id: _id,
            }
            const deleteCommentaire = await commentaireModel.deleteOne(query).exec(); // supression du commentaire dans la BDD

            if(deleteCommentaire.deletedCount == 1) {
                return true;
            }
            return false;
        } 
        catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }

    static async getMoyenneByVin(vin) {
        try {
            const query = {
                "vin.nomVin": vin,
                note: { $exists: true }
            }
            const getVins = await commentaireModel.find(query).exec(); // supression du commentaire dans la BDD

            if(getVins.length > 0) {

                let moyenne = {};

                let sum = 0;
                for(let i = 0; i < getVins.length; i++) {
                    sum += getVins[i].note;
                }
                moyenne.id = sum / getVins.length;

                return moyenne;
            }
            return false;
        } 
        catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }
}

module.exports = commentaireService;
