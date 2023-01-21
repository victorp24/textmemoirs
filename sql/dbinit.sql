CREATE TABLE users (
    phoneNumber STRING PRIMARY KEY,
    userName STRING,
    password STRING NOT NULL
);

CREATE TABLE texts (
    textId UUID NOT NULL DEFAULT gen_random_uuid(),
    phoneNumber STRING REFERENCES users (phoneNumber),
    textMessage STRING,
    creationDate STRING,
    creationTime STRING,
    CONSTRAINT "primary" PRIMARY KEY (textId)   
);