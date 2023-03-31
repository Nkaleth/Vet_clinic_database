/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(15) NOT NULL,
	date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL, 
	neutered BOOLEAN NOT NULL,
	weight_kg DECIMAL NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE animals
ADD COLUMN species varchar(255);

/* Create a table named owners */ 
CREATE TABLE owners (
	id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(255) NOT NULL,
	age INT NOT NULL,
		PRIMARY KEY(id)
);

/* Create a table named species */

CREATE TABLE species (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(255),
	PRIMARY KEY(id) 
);

/*** Modifying animals table ****/

/* Remove column species */

ALTER TABLE animals
DROP COLUMN species;

/* Add column species_id which is a foreign key referencing species table */

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT FK_species_animals
FOREIGN KEY (species_id)
REFERENCES species (id);

/* Add column owner_id which is a foreign key referencing the owners table */ 

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT FK_owners_animals
FOREIGN KEY (owner_id)
REFERENCES owners (id);


