const path = require('path');
const fs = require('fs');
const express = require('express');
const host = 'localhost';
const port = 5000;
const clientApp = path.join(__dirname, 'client');
// express app
let app = express();

// helper function to log all incoming requests to the web server
function logRequest(req, res, next){
	console.log(`${new Date()}  ${req.ip} : ${req.method} ${req.path}`);
	next();
}

app.use(express.json({limit:'50mb', extended : true})) 						// to parse application/json
app.use(express.urlencoded({ limit:'50mb', extended: true })) // to parse application/x-www-form-urlencoded
app.use(logRequest);	

const { Client } = require('pg')

const client = new Client( "postgresql://parm-nwhacks:<ENTER-SQL-USER-PASSWORD>@dissed-lion-4737.6wr.cockroachlabs.cloud:26257/textmemoirDB?sslmode=verify-full" ) 

client.connect((err) => {
if (err) {
    console.error('connection error', err.stack)
} else {
    console.log('connected')
}
})

app.get('/', (req, res) => {
    res.json({
        success: true,
    });
});


// serve static files (client-side)
app.use('/', express.static(clientApp, { extensions: ['html'] }));

app.get('/api/stop', function (req, res) {
	console.log('check')
	res.json('done')
});

app.post('/api/stop', function (req, res) {
	console.log(req.body)
	res.json(req.body)
});

app.listen(port, () => {
    console.log(`${new Date()}  App Started. Listening on ${host}:${port}, serving ${clientApp}`);
});