/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    ('Agumon', '2020-02-03', 0, true, 10.5),
    ('Gabumon', '2018-11-15', 2, true, 8),
    ('Pikachu', '2021-01-07', 1, false, 15.04),
    ('Devimon', '2017-05-12', 5, true, 11),
    ('Charmander', '2020-02-08', 2, false, 11),
    ('Plantmon', '2021-11-15', 2, true, 5.7),
    ('Squirtle', '1993-04-02', 3, false, 12.13),
    ('Angemon', '2005-06-12', 1, true, 45),
    ('Boarmon', '2005-06-07', 7, true, 20.4),
    ('Blossom', '1998-10-13', 3, true, 17),
    ('Ditto', '2022-05-14', 4, true, 22);

/*** Insert the following data into the owners table: ***/

/* 
Sam Smith 34 years old. 
Jennifer Orwell 19 years old.
Bob 45 years old.
Melody Pond 77 years old.
Dean Winchester 14 years old.
Jodie Whittaker 38 years old.

*/ 

INSERT INTO owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

/*
    Insert the following data into the species table:
    Pokemon
    Digimon
*/

INSERT INTO species (name)
VALUES 
    ('Pokemon'),
    ('Digimon');


/***   Modify your inserted animals so it includes the species_id value:  ***/

 /*
  -If the name ends in "mon" it will be Digimon
  -All other animals are Pokemon 
*/

BEGIN TRANSACTION;
UPDATE animals 
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;

COMMIT; 

/*** Modify your inserted animals to include owner information (owner_id): ***/

/*** -Sam Smith owns Agumon. ***/

/* This is a TRANSACTION that includes a query to retrieve the id of the owner to use it after to update the animals owners, 
So its a transaction to UPDATE DATA using a query, it is NOT ALTERING the schema of any table */

BEGIN TRANSACTION;

DO $$

DECLARE 
    owner INT;

BEGIN 

SELECT INTO owner
id
FROM owners
WHERE full_name = 'Sam Smith';

UPDATE animals
SET owner_id = owner
WHERE name = 'Agumon';

END $$;

COMMIT;

 /* -Jennifer Orwell owns Gabumon and Pikachu.*/

 /* This is a TRANSACTION that includes a query to retrieve the id of the owner to use it after to update the animals owners, 
So its a transaction to UPDATE DATA using a query, it is NOT ALTERING the schema of any table */

BEGIN TRANSACTION;

DO $$

DECLARE 
    owner INT;

BEGIN 

SELECT INTO owner
id
FROM owners
WHERE full_name = 'Jennifer Orwell';

UPDATE animals
SET owner_id = owner
WHERE name IN ('Gabumon', 'Pikachu');

END $$;

COMMIT;

 
-- -Bob owns Devimon and Plantmon.

/* This is a TRANSACTION that includes a query to retrieve the id of the owner to use it after to update the animals owners, 
So its a transaction to UPDATE DATA using a query, it is NOT ALTERING the schema of any table */

BEGIN TRANSACTION;

DO $$

DECLARE 
    owner INT;

BEGIN 

SELECT INTO owner
id
FROM owners
WHERE full_name = 'Bob';

UPDATE animals
SET owner_id = owner
WHERE name IN ('Devimon', 'Plantmon');

END $$;

COMMIT;

-- -Melody Pond owns Charmander, Squirtle, and Blossom.

/* This is a TRANSACTION that includes a query to retrieve the id of the owner to use it after to update the animals owners, 
So its a transaction to UPDATE DATA using a query, it is NOT ALTERING the schema of any table */

BEGIN TRANSACTION;

DO $$

DECLARE 
    owner INT;

BEGIN 

SELECT INTO owner
id
FROM owners
WHERE full_name = 'Melody Pond';

UPDATE animals
SET owner_id = owner
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

END $$;

COMMIT;

-- -Dean Winchester owns Angemon and Boarmon.

/* This is a TRANSACTION that includes a query to retrieve the id of the owner to use it after to update the animals owners, 
So its a transaction to UPDATE DATA using a query, it is NOT ALTERING the schema of any table */

BEGIN TRANSACTION;

DO $$

DECLARE 
    owner INT;

BEGIN 

SELECT INTO owner   
id
FROM owners
WHERE full_name = 'Dean Winchester';

UPDATE animals
SET owner_id = owner
WHERE name IN ('Angemon', 'Boarmon');

END $$;

COMMIT;

 /* Insert the following data for vets: */  

/*  Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
    Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
    Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
    Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
*/

  INSERT INTO vets(name, age, date_of_graduation )
  VALUES 
        ('William Tatcher', 45, '2000-04-23'),
        ('Maisy Smith', 26, '2019-01-17'),
        ('Stephanie Mendez', 64, '1981-05-04'),
        ('Jack Harkness', 38, '2008-06-08');

 /* Insert the following data for specialties: */  

/*  Vet William Tatcher is specialized in Pokemon. */

/* This is a TRANSACTION that includes two queries to retrieve the id of the vet and the id of the specie to use it to update the species vets, 
So its a transaction to UPDATE DATA using a queries, it is NOT ALTERING the schema of any table */

BEGIN TRANSACTION;

DO $$

DECLARE 
    vet INT;
    specie INT;

BEGIN 

SELECT INTO vet  
id
FROM vets
WHERE name = 'William Tatcher';

SELECT INTO specie 
id
FROM species
WHERE name = 'Pokemon';

INSERT INTO specializations ( vet_id, species_id)
VALUES 
    (vet, specie);

END $$;

COMMIT;

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.

/* This is a TRANSACTION that includes two queries to retrieve the id of the vet and the id of the specie to use it to update the species vets, 
So its a transaction to UPDATE DATA using a queries, it is NOT ALTERING the schema of any table */

BEGIN TRANSACTION;

DO $$

DECLARE 
    vet INT;
    pokemon_specie INT;
    digimon_specie INT;

BEGIN 

SELECT INTO vet  
id
FROM vets
WHERE name = 'Stephanie Mendez';

-- Get the IDs of the Pokemon and Digimon species
SELECT INTO pokemon_specie 
id
FROM species
WHERE name = 'Pokemon';

SELECT INTO digimon_specie 
id
FROM species
WHERE name = 'Digimon';

-- Insert rows into the specializations table
INSERT INTO specializations (vet_id, species_id)
VALUES (vet, pokemon_specie),
       (vet, digimon_specie);

END $$;

COMMIT;



-- Vet Jack Harkness is specialized in Digimon.

/* This is a TRANSACTION that includes two queries to retrieve the id of the vet and the id of the specie to use it to update the species vets, 
So its a transaction to UPDATE DATA using a queries, it is NOT ALTERING the schema of any table */

BEGIN TRANSACTION;

DO $$

DECLARE 
    vet INT;
    specie INT;

BEGIN 

SELECT INTO vet  
id
FROM vets
WHERE name = 'Jack Harkness';

SELECT INTO specie 
id
FROM species
WHERE name = 'Digimon';

INSERT INTO specializations ( vet_id, species_id)
VALUES 
    (vet, specie);

END $$;

COMMIT;

/*** Insert the following data for visits: ***/

/* Agumon visited William Tatcher on May 24th, 2020. */
/*  Agumon visited Stephanie Mendez on Jul 22th, 2020. */

BEGIN TRANSACTION;

DO $$

DECLARE 
    vet1 INT;
    vet2 INT;
    animal INT;

BEGIN 

SELECT INTO vet1  
id
FROM vets
WHERE name = 'William Tatcher';

SELECT INTO vet2  
id
FROM vets
WHERE name = 'Stephanie Mendez';

SELECT INTO animal 
id
FROM animals
WHERE name = 'Agumon';

INSERT INTO visits(animal_id, vet_id, date_of_visit)
VALUES 
    (animal, vet1,'2020-05-24'),
    (animal, vet2,'2020-07-22');

END $$;

COMMIT;

/*  Gabumon visited Jack Harkness on Feb 2nd, 2021. */

BEGIN TRANSACTION;

DO $$

DECLARE 
    vet1 INT;
    animal INT;

BEGIN 

SELECT INTO vet1  
id
FROM vets
WHERE name = 'Jack Harkness';

SELECT INTO animal 
id
FROM animals
WHERE name = 'Gabumon';

INSERT INTO visits(animal_id, vet_id, date_of_visit)
VALUES 
    (animal, vet1,'2021-02-02');

END $$;

COMMIT;

/* 
    Pikachu visited Maisy Smith on Jan 5th, 2020.
    Pikachu visited Maisy Smith on Mar 8th, 2020.
    Pikachu visited Maisy Smith on May 14th, 2020.
*/

BEGIN TRANSACTION;

DO $$

DECLARE 
    vet1 INT;
    animal INT;

BEGIN 

SELECT INTO vet1  
id
FROM vets
WHERE name = 'Maisy Smith';

SELECT INTO animal 
id
FROM animals
WHERE name = 'Pikachu';

INSERT INTO visits(animal_id, vet_id, date_of_visit)
VALUES 
    (animal, vet1,'2020-01-05'),
    (animal, vet1,'2020-03-08'),
    (animal, vet1,'2020-05-14');

END $$;

COMMIT;

/* Devimon visited Stephanie Mendez on May 4th, 2021. */

BEGIN TRANSACTION;

DO $$

DECLARE 
    vet1 INT;
    animal INT;

BEGIN 

SELECT INTO vet1  
id
FROM vets
WHERE name = 'Stephanie Mendez';

SELECT INTO animal 
id
FROM animals
WHERE name = 'Devimon';

INSERT INTO visits(animal_id, vet_id, date_of_visit)
VALUES 
    (animal, vet1,'2021-05-04');

END $$;

COMMIT;

/* Charmander visited Jack Harkness on Feb 24th, 2021. */

BEGIN TRANSACTION;

DO $$

DECLARE 
    vet1 INT;
    animal INT;

BEGIN 

SELECT INTO vet1  
id
FROM vets
WHERE name = 'Jack Harkness';

SELECT INTO animal 
id
FROM animals
WHERE name = 'Charmander';

INSERT INTO visits(animal_id, vet_id, date_of_visit)
VALUES 
    (animal, vet1,'2021-02-24');

END $$;

COMMIT;

/* 
    Plantmon visited Maisy Smith on Dec 21st, 2019.
    Plantmon visited William Tatcher on Aug 10th, 2020.
    Plantmon visited Maisy Smith on Apr 7th, 2021.
*/

BEGIN TRANSACTION;

DO $$

DECLARE 
    vet1 INT;
    vet2 INT;
    animal INT;

BEGIN 

SELECT INTO vet1  
id
FROM vets
WHERE name = 'Maisy Smith';

SELECT INTO vet2  
id
FROM vets
WHERE name = 'William Tatcher';

SELECT INTO animal 
id
FROM animals
WHERE name = 'Plantmon';

INSERT INTO visits(animal_id, vet_id, date_of_visit)
VALUES 
    (animal, vet1,'2019-12-21'),
    (animal, vet1,'2021-04-07'),
    (animal, vet2,'2020-08-10');

END $$;

COMMIT;

/* Squirtle visited Stephanie Mendez on Sep 29th, 2019. */

BEGIN TRANSACTION;

DO $$

DECLARE
    vet1id INT;
    animalid INT;

BEGIN

SELECT INTO vet1id
id
FROM vets
WHERE name = 'Stephanie Mendez';

SELECT INTO animalid
id
FROM animals
WHERE name = 'Squirtle';

INSERT INTO visits(animal_id, vet_id, date_of_visit)
VALUES
    (animalid, vet1id, '2019-09-29');

END $$;

COMMIT;

/*
    Angemon visited Jack Harkness on Oct 3rd, 2020.
    Angemon visited Jack Harkness on Nov 4th, 2020.
*/

BEGIN TRANSACTION;

DO $$

DECLARE
    vetid INT;
    animalid INT;

BEGIN

SELECT INTO vetid
id
FROM vets
WHERE name = 'Jack Harkness';

SELECT INTO  animalid
id
FROM animals
WHERE name = 'Angemon';

INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES
    (animalid, vetid, '2020-10-03'),
    (animalid, vetid, '2020-11-04');

END $$;

COMMIT;

/* 
    Boarmon visited Maisy Smith on Jan 24th, 2019.
    Boarmon visited Maisy Smith on May 15th, 2019.
    Boarmon visited Maisy Smith on Feb 27th, 2020.
    Boarmon visited Maisy Smith on Aug 3rd, 2020.
*/

BEGIN TRANSACTION;

DO $$

DECLARE
    vetid INT;
    animalid INT;

BEGIN

SELECT INTO vetid
id
FROM vets
WHERE name = 'Maisy Smith';

SELECT INTO animalid
id
FROM animals
WHERE name = 'Boarmon';

INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES 
    (animalid, vetid, '2019-01-24'),
    (animalid, vetid, '2019-05-15'),
    (animalid, vetid, '2020-02-27'),
    (animalid, vetid, '2020-08-03');

END $$;

COMMIT;

/* 
    Blossom visited Stephanie Mendez on May 24th, 2020.
    Blossom visited William Tatcher on Jan 11th, 2021.
*/

BEGIN TRANSACTION;

DO $$

DECLARE
    vet1id INT;
    vet2id INT;
    animalid INt;

BEGIN

SELECT INTO vet1id
id
FROM vets
WHERE name = 'Stephanie Mendez';

SELECT INTO vet2id
id
FROM vets
WHERE name = 'William Tatcher';

SELECT INTO animalid
id
FROM animals
WHERE name = 'Blossom';

INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES
    (animalid, vet1id, '2020-05-24'),
    (animalid, vet2id, '2021-01-11');

END $$;

COMMIT;


  