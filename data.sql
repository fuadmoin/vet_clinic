/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (1, 'Agumon', '02, 03, 2020', 0, 'true', 10.23 ),
       (2, 'Gabumon', '11, 15, 2018', 2, 'true', 8 ),
	   (3, 'Pikachu', '01, 07, 2021', 1, 'false', 15.04 ),
	   (4, 'Devimon', '05, 12, 2017', 5, 'true', 11 );

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES  (5, 'Charmander', '02, 08, 2020', 0, 'false', -11 ),
        (6, 'Plantmon', '11, 15, 2021', 2, 'true', -5.7 ),
		(7, 'Squirtle', '04, 02, 1993', 3, 'false', -12.13 ),
        (8, 'Angemon', '06, 12, 2005', 1, 'true', -45 ),
		(9, 'Boramon', '06, 07, 2005', 7, 'true', 20.4 ),
        (10, 'Blossom', '10, 13, 1998', 3, 'true', 17 ),
		(11, 'Ditto', '05, 14, 2022', 4, 'true', 22 );

INSERT INTO owners (age, full_name)
VALUES (34, 'Sam Smith'), (19, 'Jennifer Orwell'), 
	   (45, 'Bob'), (77, 'Melody Pond'),
	   (14, 'Dean Winchester'), (38, 'Jodie Whittaker');

INSERT INTO species (name)
VALUES ('Pokemon'), ('Digimon');

UPDATE animals
SET species_id = (CASE
    WHEN name LIKE '%mon' 
	THEN (SELECT id FROM species WHERE name = 'Digimon')
    ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END);

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '04, 23, 2000'),
		('Maisy Smith', 26, '01, 17, 2019'),
		('Stephanie Mendez', 64, '05, 04, 1981'),
		('Jack Harkness', 38, '01, 08, 2008');

INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'),
	   (SELECT id FROM species WHERE name = 'Pokemon')),
	   ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
	   (SELECT id FROM species WHERE name = 'Pokemon')),
	   ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
	   (SELECT id FROM species WHERE name = 'Digimon')),
	   ((SELECT id FROM vets WHERE name = 'Jack Harkness'),
	   (SELECT id FROM species WHERE name = 'Digimon'));

INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'),
	   (SELECT id FROM animals WHERE name = 'Agumon'),
	   '05, 24, 2020' ),
	    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
	   (SELECT id FROM animals WHERE name = 'Agumon'),
	   '07, 22, 2020' ),
	    ((SELECT id FROM vets WHERE name = 'Jack Harkness'),
	   (SELECT id FROM animals WHERE name = 'Gabumon'),
	   '02, 02, 2021' ),
	    ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
	   (SELECT id FROM animals WHERE name = 'Pikachu'),
	   '01, 05, 2020' ),
	    ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
	   (SELECT id FROM animals WHERE name = 'Pikachu'),
	   '03, 08, 2020' ),
	    ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
	   (SELECT id FROM animals WHERE name = 'Pikachu'),
	   '05, 14, 2020' ),
	    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
	   (SELECT id FROM animals WHERE name = 'Devimon'),
	   '05, 04, 2021' ),
	    ((SELECT id FROM vets WHERE name = 'Jack Harkness'),
	   (SELECT id FROM animals WHERE name = 'Charmander'),
	   '02, 24, 2021' ),
	    ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
	   (SELECT id FROM animals WHERE name = 'Plantmon'),
	   '12, 21, 2019' ),
	    ((SELECT id FROM vets WHERE name = 'William Tatcher'),
	   (SELECT id FROM animals WHERE name = 'Plantmon'),
	   '08, 10, 2020' ),
	    ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
	   (SELECT id FROM animals WHERE name = 'Plantmon'),
	   '04, 07, 2021' ),
	    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
	   (SELECT id FROM animals WHERE name = 'Squirtle'),
	   '09, 29, 2019' ),
	    ((SELECT id FROM vets WHERE name = 'Jack Harkness'),
	   (SELECT id FROM animals WHERE name = 'Angemon'),
	   '10, 03, 2020' ),
	    ((SELECT id FROM vets WHERE name = 'Jack Harkness'),
	   (SELECT id FROM animals WHERE name = 'Angemon'),
	   '11, 04, 2020' ),
	    ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
	   (SELECT id FROM animals WHERE name = 'Boarmon'),
	   '01, 24, 2019' ),
	    ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
	   (SELECT id FROM animals WHERE name = 'Boarmon'),
	   '05, 15, 2019' ),
	    ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
	   (SELECT id FROM animals WHERE name = 'Boarmon'),
	   '02, 27, 2020' ),
	    ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
	   (SELECT id FROM animals WHERE name = 'Boarmon'),
	   '08, 03, 2020' ),
	    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
	   (SELECT id FROM animals WHERE name = 'Blossom'),
	   '05, 24, 2020' ),
	    ((SELECT id FROM vets WHERE name = 'William Tatcher'),
	   (SELECT id FROM animals WHERE name = 'Blossom'),
	   '01, 11, 2021' );
	  	
INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT * FROM (SELECT id FROM animals) animal_ids,
(SELECT id FROM vets) vets_ids,
generate_series('1760-01-01'::timestamp, '1959-01-01', '4 hours') visit_timestamp;

INSERT INTO owners (full_name, email) select 
'Owner ' || generate_series(1,2500000), 
'owner_' || generate_series(1,2500000) || '@mail.com';
