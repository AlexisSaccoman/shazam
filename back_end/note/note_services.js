const noteModel = require('./note_model');

class noteService {
    static async addNote(nbEtoiles, vin, utilisateur) {
        try {
            const _idUser = utilisateur._id;
            const identifiantUser = utilisateur.identifiant;
            const _idVin = vin._id;
            const nomVin = vin.nom;
            const createNote = new noteModel({
                nbEtoiles: nbEtoiles,
                vin: { _idVin, nomVin },
                utilisateur: { _idUser, identifiantUser }
            });
            return await createNote.save();
        } catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }

    static async findNoteById(_id) {
        try {
            const query = {
                _id: _id,
            }

            const findNote = await noteModel.findOne(query).exec(); // recherche d'une note ayant l'id saisi dans la BDD

            if(findNote) {
                return findNote;
            }
            return false;
        } 
        catch (err) {
            console.log('Erreur service !' + err);
            throw err;
        }
    }

    static async updateNote(_id, nbEtoiles) {
        const findId = await this.findNoteById(_id);
        if(!findId) {
            return "Id non trouvé !";
        }
        noteModel.updateOne({ // modification de la note à partir de l'id de la note renseigné
            _id: _id
        }, {
            $set: {
                nbEtoiles: nbEtoiles,
            }
        }).catch(() => {
            return "Erreur dans l'update !";
        });
    }

    static async deleteNote(_id) {
        try {
            const query = {
                _id: _id,
            }
            const deleteNote = await noteModel.deleteOne(query).exec(); // supression de la note dans la BDD

            if(deleteNote.deletedCount == 1) {
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

module.exports = noteService;
