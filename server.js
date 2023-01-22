const path = require('path');
const express = require('express');
const host = 'localhost';
const port = 5000;
const clientApp = path.join(__dirname, 'client');
const cors = require('cors');
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
app.use(cors());	

const { Client } = require('pg')

const client = new Client("postgresql://parm-nwhacks:pp4yk1Z0r6dqC3SkcOne6w@dissed-lion-4737.6wr.cockroachlabs.cloud:26257/textmemoirnwhacks?sslmode=verify-full"); 

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
    const {phoneNumber, userName, password} = req.body;
    let insertUserQuery = {
        name: "insertUserQuery",
        text: "INSERT INTO users(phoneNumber, userName, password) VALUES($1, $2, $3) RETURNING *",
        values: [phoneNumber, userName, password]
    };

    client.query(insertUserQuery)
        .then((data) => {
            res.send(data.rows[0]);
        })
        .catch((error) => {
            res.send({error: "Unable to insert user"})
        })
})

//Get Users
app.get("/getUsers", (req, res) => {
    let getUsersQuery = "SELECT * FROM users";
    client.query(getUsersQuery)
        .then((data) => {
            res.send(data.rows);
        })
        .catch((error) => {
            res.send({error: "unable to get users"});
        })
})

//AddTexts
app.post("/addText", (req, res) => {
    const {phoneNumber, textMessage, creationDate, creationTime} = req.body;
    let insertTextQuery = {
        name: "insertTextQuery",
        text: "INSERT INTO texts(phoneNumber, textMessage, creationDate, creationTime) VALUES($1, $2, $3, $4) RETURNING textId",
        values: [phoneNumber, textMessage, creationDate, creationTime]
    };

    client.query(insertTextQuery)
        .then((data) => {
            res.send(data.rows[0]);
        })
        .catch((error) => {
            res.send({error: "unable to add text"});
        })
})

//GetTextsByUserAndDay
app.get("/getTextsByUserAndDay", (req, res) => {
    const {phoneNumber, creationDate} = req.query;
    let getTextsQuery = {
        name: "getTextsByUserAndDay",
        text: "SELECT * FROM texts WHERE phoneNumber = $1 AND creationDate = $2",
        values: [phoneNumber, creationDate]
    };

    client.query(getTextsQuery)
        .then((data) => {
            res.send(data.rows);
        })
        .catch((error) => {
            res.send({error: "unable to get texts"});
        });
})

//Get All Texts
app.get("/getAllTexts", (req, res) => {
    let getAllTextsQuery = "SELECT * FROM texts";
    client.query(getAllTextsQuery)
        .then((data) => {
            res.send(data.rows);
        })
        .catch((error) => {
            res.send({error: "unable to get texts"});
        });
})


//EditTextById
app.put("/editTextsById", (req, res) => {
    const {textId, textMessage} = req.body;
    let editTextQuery = {
        name: "editTextQuery",
        text: "Update texts SET textMessage = $1 WHERE textId = $2",
        values: [textMessage, textId]
    };

    client.query(editTextQuery)
        .then(() => {
            res.send({textId});
        })
        .catch(() => {
            res.send({error: "Unable To Update Message"})
        })
})

//DeleteTextById
app.delete("/deleteTextsById", (req, res) => {
    const textId = req.body.textId;
    let deleteTextQuery = `DELETE FROM texts WHERE textId = ${textId}`
    client.query(deleteTextQuery)
        .then(() => {
            res.send({message: "Succesfully Deleted"})
        })
        .catch(() => {
            res.send({error: "Unable To Delete Text"})
        })
})

app.listen(port, () => {
    console.log(`${new Date()}  App Started. Listening on ${host}:${port}, serving ${clientApp}`);
});