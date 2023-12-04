const mongoose = require("mongoose");

const connexion = mongoose.createConnection('mongodb://127.0.0.1:27017/vin_alexis_walid').on('open', () => {
  //console.log('connected !');
}).on('error', () => {
  console.log('error !');
});

module.exports = connexion;
