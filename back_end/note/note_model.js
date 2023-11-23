const mongoose = require('mongoose');
const db = require('../database');

const { Schema } = mongoose;

const noteSchema = new Schema({
    nbEtoiles: {
        type: Number,
        min: 0,
        max : 5,
        required: true,
    },
    vin: {
        type: Object,
        required: true
    },
    utilisateur: {
        type: Object,
        required: true
    }
});

const noteModel = db.model('note', noteSchema);

module.exports = noteModel;
