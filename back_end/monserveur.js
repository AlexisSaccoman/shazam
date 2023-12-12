// inclusion des modules
const express = require('express');
const https = require('https');
const fs = require('fs');
const app = express();

const cors = require('cors');
app.use(cors());

// inclusion des controllers

const userController = require('./user/user_controller');
const noteController = require('./note/note_controller');
const vinController = require('./vin/vin_controller');
const commentaireController = require('./commentaire/commentaire_controller');

const port = 3189; // mon port impair

const bodyParser = require('body-parser'); // parser pour méthode POST

app.use(bodyParser.urlencoded({extended:true})); // lire les données au format HTML

app.use(bodyParser.json({limit: '10mb'})); // lire les données en JSON

app.use(express.static(__dirname)); // __dirname : variable d'environnement contenant le path de monserveur.js

const options = { // fichiers contenant clé/certificat pour la connexion en HTTPS
	key: fs.readFileSync('key.pem'),
	cert: fs.readFileSync('cert.pem')
}

const server = https.createServer(options, app).listen(port, () => { // écoute sur mon port
	console.log(`Ecoute sur le port ${port}`);
});

app.get('/', (req, res) => {
	res.send('Accueil');
});

// opérations user --------------------------------------

app.post('/register', async (req, res) => {
    try {
        await userController.register(req, res);
    } catch (err) {
        console.log('Erreur register ! ' + err);
        throw err;
    }
});

app.post('/login', async (req, res) => {
    try {
        await userController.login(req, res);
    } catch (err) {
        console.log('Erreur login ! ' + err);
        throw err;
    }
});

app.post('/logout', async (req, res) => {
    try {
        await userController.logout(req, res);
    } catch (err) {
        console.log('Erreur logout ! ' + err);
        throw err;
    }
});

// opérations vin --------------------------------------

app.post('/addVin', async (req, res) => {
    try {
        await vinController.addVin(req, res);
    } catch (err) {
        console.log('Erreur addVin ! ' + err);
        throw err;
    }
});

app.post('/updateVin', async (req, res) => {
    try {
        await vinController.updateVin(req, res);
    } catch (err) {
        console.log('Erreur updateVin ! ' + err);
        throw err;
    }
});

app.post('/findVinByEAN', async (req, res) => {
    try {
        await vinController.findVinByEAN(req, res);
    } catch (err) {
        console.log('Erreur findVinByEAN ! ' + err);
        throw err;
    }
});

app.post('/deleteVin', async (req, res) => {
    try {
        await vinController.deleteVin(req, res);
    } catch (err) {
        console.log('Erreur deleteVin ! ' + err);
        throw err;
    }
});

app.post('/findVins', async (req, res) => {
    try {
        await vinController.findVins(req, res);
    } catch (err) {
        console.log('Erreur findVins ! ' + err);
        throw err;
    }
});


// opérations commentaire --------------------------------------

app.post('/addCommentaire', async (req, res) => {
    try {
        await commentaireController.addCommentaire(req, res);
    } catch (err) {
        console.log('Erreur addCommentaire ! ' + err);
        throw err;
    }
});

app.post('/findCommentaireByVinName', async (req, res) => {
    try {
        await commentaireController.findCommentaireByVinName(req, res);
    } catch (err) {
        console.log('Erreur findCommentaireByVinName ! ' + err);
        throw err;
    }
});

app.post('/updateCommentaire', async (req, res) => {
    try {
        await commentaireController.updateCommentaire(req, res);
    } catch (err) {
        console.log('Erreur updateCommentaire ! ' + err);
        throw err;
    }
});

app.post('/deleteCommentaire', async (req, res) => {
    try {
        await commentaireController.deleteCommentaire(req, res);
    } catch (err) {
        console.log('Erreur deleteCommentaire ! ' + err);
        throw err;
    }
});

// opérations note --------------------------------------

app.post('/addNote', async (req, res) => {
    try {
        await noteController.addNote(req,res);
    } catch (err) {
        console.log('Erreur addNote ! ' + err);
        throw err;
    }
});

app.post('/getMoyenneByVin', async (req, res) => {
    try {
        await commentaireController.getMoyenneByVin(req,res);
    } catch (err) {
        console.log('Erreur getMoyenneByVin ! ' + err);
        throw err;
    }
});

app.post('/findNoteById', async (req, res) => {
    try {
        await noteController.findNoteById(req,res);
    } catch (err) {
        console.log('Erreur findNoteById ! ' + err);
        throw err;
    }
});

app.post('/updateNote', async (req, res) => {
    try {
        await noteController.updateNote(req,res);
    } catch (err) {
        console.log('Erreur updateNote ! ' + err);
        throw err;
    }
});

app.post('/deleteNote', async (req, res) => {
    try {
        await noteController.deleteNote(req,res);
    } catch (err) {
        console.log('Erreur deleteNote ! ' + err);
        throw err;
    }
});

/* 

Liste de requêtes : 

- User : 

    pedago.univ-avignon.fr:3189/register?id=sneux&mdp=1234&nom=sneux&prenom=sneux 

    pedago.univ-avignon.fr:3189/login?id=sneux&mdp=1234

    pedago.univ-avignon.fr:3189/findUserByName?id=sneux

    pedago.univ-avignon.fr:3189/findUserById?_id=655fc14e2145d32e861d5fdf

    pedago.univ-avignon.fr:3189/deleteUser?id=sneux

- Vin : 

    pedago.univ-avignon.fr:3189/addVin?nom=Vin de Mirabelle&EAN=1234567891234&descriptif=Joli vin&tarif=12.81&millesime=1999&volume=1.2&cepage=raisin&allergenes=ceci,cela,encorececi,encorecela&teneurEnAlcool=1.2&imgURL=blablabla.png&nomDeDomaine=ARLenoble&provenance=France&typeVin=vinRouge

    https://pedago.univ-avignon.fr:3189/updateVin?nom=Vin de Mirabelle&nouveauNom=VinModifié&EAN=123&descriptif=Joli%20vin&tarif=12.81&millesime=1999&volume=1.2&cepage=raisin&allergenes=ceci,cela,encorececi,encorecela&teneurEnAlcool=1.2&imgURL=blablabla.png&nomDeDomaine=ARLenoble&provenance=France&typeVin=vinRouge

    https://pedago.univ-avignon.fr:3189/deleteVin?nom=VinModifié

    https://pedago.univ-avignon.fr:3189/findVinById?_id=655fc14e2145d32e861d5fdf

    https://pedago.univ-avignon.fr:3189/findVinByName?nom=Vin de Mirabelle
    
- Commentaire : 

    pedago.univ-avignon.fr:3189/addCommentaire?message=Jesuisla&vin=Vin de Mirabelle&id=sneux

    https://pedago.univ-avignon.fr:3189/findCommentaireById?_id=655fc14e2145d32e861d5fdf

    https://pedago.univ-avignon.fr:3189/updateCommentaire?_id=655fc14e2145d32e861d5fdf&message=jeModifieTonMessage

    https://pedago.univ-avignon.fr:3189/deleteCommentaire?_id=655fc9e6d040adfa2de2a072

- Note :

    pedago.univ-avignon.fr:3189/addNote?nbEtoiles=5&vin=Vin de Mirabelle&id=sneux

    pedago.univ-avignon.fr:3189/findNoteById?_id=655fc14e2145d32e861d5fdf

    pedago.univ-avignon.fr:3189/updateNote?_id=655fc14e2145d32e861d5fdf&nbEtoiles=3

    pedago.univ-avignon.fr:3189/deleteNote?_id=655fc14e2145d32e861d5fdf


*/

const crypto = require('crypto');

app.get('/test', async (req, res) => {
    try {

        const user = { id: "moi", mdp: "moi2" }

        const cryptedMdp = crypto.createHash('sha1').update(user.mdp).digest('hex'); // mdp crypté en SHA-1

        const key = user.id + cryptedMdp;

        const token = crypto.createHash('sha1').update(key).digest('hex'); // mdp crypté en SHA-1

        res.send(key);

    } catch (err) {
        throw err;
    }
});
