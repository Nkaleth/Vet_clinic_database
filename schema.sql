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

/*** ADD "JOIN TABLE" FOR VISITS ***/

/* 

-Create a table named vets with the following columns:
-id: integer (set it as autoincremented PRIMARY KEY)
-name: string
-age: integer
-date_of_graduation: date

*/

CREATE TABLE vets (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(255) NOT NULL,
	age INT NOT NULL,
  date_of_graduation DATE NOT NULL,
    PRIMARY KEY (id)
);

/* There is a many-to-many relationship between the tables species and
 vets: a vet can specialize in multiple species, and a species 
 can have multiple vets specialized in it. Create a "join table" 
 called specializations to handle this relationship. */

CREATE TABLE specializations (
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

/* There is a many-to-many relationship between the tables 
animals and vets: an animal can visit multiple vets and one
 vet can be visited by multiple animals. 
 Create a "join table" called visits to handle this relationship, 
 it should also keep track of the date of the visit. */

CREATE TABLE visits (
		date_of_visit DATE NOT NULL,
    vet_id INTEGER REFERENCES vets(id),
    animal_id INTEGER REFERENCES animals(id),
    PRIMARY KEY (vet_id, animal_id, date_of_visit)
);


