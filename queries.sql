/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT * FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts From animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/**** Query and update animals table ****/

/* Inside a transaction update the animals table by setting the species column to unspecified.
Verify that change was made. Then roll back the change and verify that the species 
columns went back to the state before the transaction. * */
BEGIN TRANSACTION;
SAVEPOINT SP1;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK TO SP1;

/*
-Inside a transaction:
-Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-Commit the transaction.
-Verify that change was made and persists after commit. 
*/
BEGIN TRANSACTION;
UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT; 

/*
-Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
-After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
*/

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;

/* 
-Inside a transaction:
-Delete all animals born after Jan 1st, 2022.
-Create a savepoint for the transaction.
-Update all animals' weight to be their weight multiplied by -1.
-Rollback to the savepoint
-Update all animals' weights that are negative to be their weight multiplied by -1.
-Commit transaction
*/

BEGIN TRANSACTION;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP2;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO SP2;

UPDATE animals

SET  weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT; 

/*********************************************/

/* Write queries to answer the following questions: */ 

/* How many animals are there? */

SELECT COUNT(name) FROM animals;

/* How many animals have never tried to escape? */

SELECT COUNT(name) FROM animals
WHERE animals.escape_attempts = 0;

/* What is the average weight of animals? */

SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */

SELECT neutered, SUM(escape_attempts) as total_escape_attempts
FROM animals
GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */

SELECT species, AVG(escape_attempts)
FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species;

/** JOIN **/

/**** Write queries (using JOIN) to answer the following questions ****/

/* What animals belong to Melody Pond?  */

SELECT animals.name
FROM animals
JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

/*  List of all animals that are pokemon (their type is Pokemon). */

SELECT animals.name
FROM animals
JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';
selec
/* List all owners and their animals, remember to include those that don't own any animal. */ 

SELECT owners.full_name, animals.name
FROM owners
FULL OUTER JOIN animals
ON animals.owner_id = owners.id;

/* How many animals are there per species? */

SELECT species.name, COUNT(*)
FROM animals
JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell. */

SELECT animals.name
FROM animals
JOIN species
ON animals.species_id = species.id
JOIN owners
ON animals.owner_id = owners.id
WHERE species.name = 'Digimon'
AND owners.full_name = 'Jennifer Orwell';

/* List all animals owned by Dean Winchester that haven't tried to escape.
  */ 
SELECT animals.name
FROM animals
JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester'
AND animals.escape_attempts = 0;

/* Who owns the most animals? */
SELECT owners.full_name, COUNT(*)
FROM animals
JOIN owners
ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(*) DESC;