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

ALTER TABLE animals
ADD COLUMN species_id INT, 
ADD COLUMN owner_id INT ,
ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY,
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id) REFERENCES species (id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id) REFERENCES owners (id)
ON DELETE CASCADE;

CREATE TABLE vets (
id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(20) NOT NULL,
	age INT NOT NULL,
	date_of_graduation DATE NOT NULL,
	PRIMARY KEY (id)	
);

CREATE TABLE specializations (
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

CREATE TABLE visits (
    animal_id INTEGER REFERENCES animals(id),
    vet_id INTEGER REFERENCES vets(id),
    visit_date DATE NOT NULL,
    PRIMARY KEY (animal_id, vet_id, visit_date)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

ALTER TABLE owners ALTER COLUMN age DROP NOT NULL; 

ALTER TABLE owners ALTER COLUMN age 
SET DEFAULT FLOOR(RANDOM() * (60 - 18 + 1)) + 18;

ALTER TABLE visits ALTER COLUMN visit_date TYPE TIMESTAMP;

CREATE INDEX visits_clustered_index2
ON visits USING btree (vet_id, animal_id, visit_date);
SELECT vet_id from visits;

CREATE INDEX owners_clustered_index
ON owners USING btree (email, full_name, id, age);
SELECT vet_id from visits;

CREATE INDEX animal_id_index ON visits (animal_id);

CREATE INDEX visits_clustered_index2
ON visits USING btree (vet_id, animal_id, visit_date);
SELECT vet_id from visits;
