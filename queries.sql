/*Queries that provide answers to the questions from all projects.*/

SELECT * 
FROM animals
WHERE  name LIKE '%mon';

SELECT name
FROM animals 
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name
FROM animals
WHERE neutered = 'true' AND escape_attempts < 3;

SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

SELECT *
FROM animals
WHERE neutered = 'true';

SELECT *
FROM animals
WHERE name <> 'Gabumon';

SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE name = 'null';
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT deleted_animals_after_jan_2022;

UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO deleted_animals_after_jan_2022;

BEGIN;
UPDATE animals
SET weight_kg = weight_kg * - 1
WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*)
FROM animals;

SELECT COUNT(*)
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg)
FROM animals;

SELECT neutered, AVG(escape_attempts)
FROM animals
GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

SELECT A.name as animals, O.full_name as owner
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Melody Pond';

SELECT A.name as animals, S.name as species
FROM animals A
JOIN species S ON A.species_id = S.id
WHERE S.name = 'Pokemon';

SELECT A.name as animals, O.full_name as owners
FROM owners O
LEFT JOIN animals A ON A.owner_id = O.id;

SELECT S.name as species_name, COUNT(A.id) as animal_count
FROM species S
LEFT JOIN animals A ON A.species_id = S.id
GROUP BY S.name;

SELECT A.name as animal, S.name as species, O.full_name as owner
FROM animals A
JOIN species S ON A.species_id = S.id
JOIN owners O ON A.owner_id = O.id
WHERE S.name = 'Digimon' AND O.full_name = 'Jennifer Orwell';

SELECT A.name as animal, O.full_name as owner, A.escape_attempts
FROM animals A
JOIN species S ON A.species_id = S.id
JOIN owners O ON A.owner_id = O.id
WHERE A.escape_attempts = 0 AND O.full_name = 'Dean Winchester';

SELECT COUNT(A.id) as animal_count, O.full_name as owner
FROM owners  O
LEFT JOIN animals A ON A.owner_id = O.id
GROUP BY O.full_name
HAVING COUNT(A.id) = (
SELECT MAX(animal_count) FROM (SELECT COUNT(id) AS animal_count
 FROM animals GROUP BY owner_id) subq);


SELECT A.name as animal_name, V.visit_date, vt.name as veteran_name
FROM visits V
JOIN animals A on V.animal_id = A.id
JOIN vets vt ON V.vet_id = vt.id
WHERE vt.name = 'William Tatcher'
ORDER BY V.visit_date DESC
LIMIT 1;

SELECT COUNT(A.id) as animals, vt.name as veteran_name
FROM visits V
JOIN animals A on V.animal_id = A.id
JOIN vets vt ON V.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez'
GROUP BY vt.name;

SELECT vt.name, sp.name as specialization
FROM vets vt
LEFT JOIN specializations S ON S.vet_id = vt.id
LEFT JOIN species sp ON S.species_id = sp.id;

SELECT A.name as animals, V.visit_date, vt.name as veteran_name
FROM visits V
JOIN animals A ON V.animal_id = A.id
JOIN vets vt ON V.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez' 
AND V.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT COUNT(A.id) as visits, A.name as animal
FROM visits V
JOIN animals A ON V.animal_id = A.id
GROUP BY A.name
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT A.name as animal, V.visit_date, vt.name as veteran_name
FROM visits V
JOIN animals A ON V.animal_id = A.id
JOIN vets vt ON V.vet_id = vt.id
WHERE vt.name = 'Maisy Smith'
ORDER BY V.visit_date ASC
LIMIT 1;

SELECT A.*, vt.*, V.visit_date as most_recent_visits
FROM visits V
JOIN animals A ON V.animal_id = A.id
JOIN vets vt ON V.vet_id = vt.id
ORDER BY V.visit_date DESC
LIMIT 1;

SELECT COUNT(*)
FROM visits V
JOIN animals A ON V.animal_id = A.id
LEFT JOIN specializations S ON (V.vet_id = S.vet_id 
AND A.species_id = S.species_id)
WHERE S.vet_id IS NULL;

SELECT S.name as recommended_speciality, COUNT(*) as count_species_visits

FROM visits V
JOIN animals A on V.animal_id = A.id 
JOIN species S on S.id = A.species_id 
JOIN vets vt on vt.id = V.vet_id 
WHERE vt.name = 'Maisy Smith' 
GROUP BY S.name 
ORDER BY count_species_visits DESC 
LIMIT 1;