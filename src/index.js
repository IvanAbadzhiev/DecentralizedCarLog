const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const Web3 = require('web3');
const web3 = new Web3(Web3.providers.HttpProvider('localhost:8545'));
const path = require('path');

let urlencodedParser = bodyParser.urlencoded({ extended: false });

app.use(bodyParser.json());
app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);

app.get('/', (req, res) => {
	res.render('index.html', {
		page : 'index'
	});
});

app.get('/services', (req, res) => {
	res.render('services.html',{
		page : 'services'
	});
});

app.post('/services', urlencodedParser, (req,res) => {
	let serviceAddress = req.body.name;
});

app.get('/cars', (req,res) => {
	res.render('cars.html',{
		page : 'cars'
	});
});

app.get('/vin/:vin', function(req, res){
	let vin = req.params.vin;
	
	res.render('vinReport.html',{
		vin : vin
	});
});

app.use('/scripts', express.static(path.join(__dirname, 'node_modules/')));
app.use('/css', express.static(path.join(__dirname, 'css/')));

app.listen(3000, () => console.log('App listen on port 3000'));