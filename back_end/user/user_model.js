const mongoose = require('mongoose');
const db = require('../database');

const { Schema } = mongoose;

const userSchema = new Schema({
    identifiant: {
        type: String,
        required: true,
        unique: true,
    },
    mdp: {
        type: String,
        required: true
    },
    nom: {
        type: String
    },
    prenom: {
        type: String
    },
    isConnected: {
        type: Boolean,
        default: false
    },
    isAdmin: {
        type: Boolean,
        default: false
    }
});

const userModel = db.model('user', userSchema);

module.exports = userModel;
