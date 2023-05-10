/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
id 				INT NOT NULL,
name 			VARCHAR(20) NOT NULL,
date_of_birth	DATE NOT NULL,
escape_attempts	INT,
neutered		BOOLEAN NOT NULL,
weight_kg		DECIMAL
);
		
ALTER TABLE animals
ADD COLUMN species VARCHAR(20);

CREATE TABLE owners (
id INT GENERATED ALWAYS AS IDENTITY,
full_name VARCHAR(50) NOT NULL,
age INT NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE species (
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(20) NOT NULL,
	PRIMARY KEY (id)
);

ALTER TABLE animals
DROP COLUMN species;
ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY,
ADD COLUMN species_id INT, 
ADD COLUMN owner_id INT ,
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id) REFERENCES species (id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id) REFERENCES owners (id)
ON DELETE CASCADE;

