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

    