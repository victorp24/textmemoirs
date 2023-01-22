CREATE TABLE users (
    phoneNumber STRING PRIMARY KEY,
    userName STRING,
    password STRING NOT NULL
);

CREATE TABLE texts (
    textId SERIAL PRIMARY KEY,
    phoneNumber STRING REFERENCES users (phoneNumber),
    textMessage STRING,
    creationDate STRING,
    creationTime STRING
);

CREATE SEQUENCE textMemoirSequence 
    START 1
    INCREMENT 1
    MINVALUE 1;

ALTER TABLE ONLY texts ALTER COLUMN textId SET DEFAULT nextval('textMemoirSequence'::regclass);