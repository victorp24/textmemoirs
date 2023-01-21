CREATE TABLE users (
    phoneNumber STRING PRIMARY KEY,
    userName STRING,
    password STRING NOT NULL
);

CREATE TABLE texts (
    textId UUID PRIMARY KEY,
    phoneNumber STRING REFERENCES users (phoneNumber),
    textMessage STRING,
    creationDate STRING,
    creationTime STRING   
);


