const commentaireModel = require('./commentaire_model');

class commentaireService {
    static async addCommentaire(message, date, utilisateur, vin) {
        try {
            const _idUser = utilisateur._id;
            const pseudoUser = utilisateur.identifiant;
            const _idVin = vin._id;
            const nomVin = vin.nom;
            const createCommentaire = new commentaireModel({
                message: message,
                date: date,
                utilisateur: {_idUser, pseudoUser},
                vin: { _idVin, nomVin }
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

    static async updateCommentaire(_id, message, date) {
        const findId = await this.findCommentaireById(_id);
        if(!findId) {
            return "Id non trouvé !";
        }
        commentaireModel.updateOne({ // modification du commentaire à partir de l'id du commentaire renseigné
            _id: _id
        }, {
            $set: {
                message: message,
                date: date
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
}

module.exports = commentaireService;
