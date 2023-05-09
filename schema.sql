/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
id 				INT NOT NULL,
name 			VARCHAR(20) NOT NULL,
date_of_birth	DATE NOT NULL,
escape_attempts	INT,
neutered		BOOLEAN NOT NULL,
weight_kg		DECIMAL
);
		
