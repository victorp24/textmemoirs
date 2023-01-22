CREATE TABLE users (
    phoneNumber VARCHAR(255) PRIMARY KEY,
    userName VARCHAR(255),
    password VARCHAR(255) NOT NULL
);

CREATE TABLE texts (
    textId SERIAL PRIMARY KEY,
    phoneNumber VARCHAR(255) REFERENCES users (phoneNumber),
    textMessage VARCHAR(255),
    creationDate VARCHAR(255),
    creationTime VARCHAR(255)
);

CREATE SEQUENCE textMemoirSequence 
    START 1
    INCREMENT 1
    MINVALUE 1;

ALTER TABLE ONLY texts ALTER COLUMN textId SET DEFAULT nextval('textMemoirSequence'::regclass);