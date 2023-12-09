const mongoose = require('mongoose');
const db = require('../database');

const { Schema } = mongoose;

const commentaireSchema = new Schema({
    message: {
        type: String,
        required: true,
    },
    date: {
        type: String,
        required: true
    },
    utilisateur: {
        type: Object,
        required: true
    },
    vin: {
        type: Object,
        required: true
    },
    note: {
        type: Number
    }
});

const commentaireModel = db.model('commentaire', commentaireSchema);

module.exports = commentaireModel;
