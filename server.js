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

const client = new Client("postgresql://parm-nwhacks:<ENTER-SQL-USER-PASSWORD>@dissed-lion-4737.6wr.cockroachlabs.cloud:26257/textmemoirdatabase?sslmode=verify-full"); 

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

//Endpoints
//Insert User
app.post("/insertUser", (req, res) => {
    const {userPhoneNumber, userName, userPassword} = req.body;
    let insertUserQuery = {
        name: "insertUserQuery",
        text: "INSERT INTO users(phoneNumber, userName, password) VALUES($1, $2, $3) RETURNING *",
        values: [userPhoneNumber, userName, userPassword]
    };

    client.query(insertUserQuery)
        .then((data) => {
            res.send(data.rows[0]);
        })
        .catch((error) => {
            console.log(error.stack);
            res.send({error: "Something Went Wrong"})
        })
})

//Get Users
app.get("/getUsers", (req, res) => {
    let getUsersQuery = "SELECT * FROM users";
    client.query(getUsersQuery)
        .then((data) => {
            res.send(data.rows[0]);
        })
        .catch((error) => {
            res.send(error.stack);
        })
})

//AddTexts
app.post("/addText", (req, res) => {
    const {userPhoneNumber, textBody, creationDate, creationTime} = req.body;
    let insertTextQuery = {
        name: "insertTextQuery",
        text: "INSERT INTO texts(phoneNumber, textMessage, creationDate, creationTime) VALUES($1, $2, $3, $4) RETURNING textId",
        values: [userPhoneNumber, textBody, creationDate, creationTime]
    };

    client.query(insertTextQuery)
        .then((data) => {
            res.send(data.rows[0]);
        })
        .catch((error) => {
            console.log(error.stack);
        })
})

//GetTextsByUserAndDay
app.get("/getTextsByUserAndDay", (req, res) => {
    const {userPhoneNumber, textDate} = req.body;
    let getTextsQuery = {
        name: "getTextsByUserAndDay",
        text: "SELECT * FROM texts WHERE phoneNumber = $1 AND creationDate = $2",
        values: [userPhoneNumber, textDate]
    };

    client.query(getTextsQuery)
        .then((data) => {
            console.log(data);
            res.send(data);
        })
        .catch((error) => {
            console.log(error.stack);
        });
})


//EditTextById
app.put("/editTextsById", (req, res) => {

})

//DeleteTextById
app.delete("/deleteTextsById", (req, res) => {

})

app.listen(port, () => {
    console.log(`${new Date()}  App Started. Listening on ${host}:${port}, serving ${clientApp}`);
});