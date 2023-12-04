const mongoose = require('mongoose');
const db = require('../database');

const { Schema } = mongoose;

const vinSchema = new Schema({
    nom: {
        type: String,
        required: true
    },
    tarif: {
        type: Number,
        required: true
    },
    descriptif: {
        type: String
    },
    millesime: {
        type: Number
    },
    volume: {
        type: Number
    },
    cepage: {
        type: String
    },
    allergenes: {
        type: Array
    },
    teneurEnAlcool: {
        type: Number
    },
    imgURL: {
        type: String
    },
    nomDeDomaine: {
        type: Object
    },
    provenance: {
        type: Object
    },
    typeVin: {
        type: Object
    },
    EAN: {
        type: String
    }
});

const vinModel = db.model('vin', vinSchema);

module.exports = vinModel;
