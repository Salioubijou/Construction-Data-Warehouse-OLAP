DROP TABLE IF EXISTS file_rouge.customer;
DROP TABLE IF EXISTS file_rouge.prestation;
DROP TABLE IF EXISTS file_rouge.ventes;
DROP TABLE IF EXISTS file_rouge.ventes_unicaen;

CREATE TABLE file_rouge.customer(
	customer_id serial,
	nom VARCHAR(64) NOT NULL,
	prenom VARCHAR(64) NOT NULL,
	adresse VARCHAR(128) NOT NULL,
	PRIMARY KEY(customer_id)
);

CREATE TABLE file_rouge.prestation(
	prestation_id serial,
	code INT NOT NULL,
	description VARCHAR(128) NOT NULL,
	PRIMARY KEY(prestation_id)
);


CREATE TABLE file_rouge.ventes_unicaen (
  id serial,
  date TIMESTAMP NOT NULL,
  prestation_id INT NOT NULL,
  price int NOT NULL,
  insertion_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE TABLE file_rouge.ventes(
  id int,
  date TIMESTAMP NOT NULL,
  customer_id int NOT NULL,
  prestation_id int NOT NULL,
  price int NOT NULL,
  zip_code int DEFAULT NULL,
  insertion_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);


drop function incrementerIdVentes;

create or replace function incrementerIdVentes() returns opaque as
'declare
  compteurId integer;
begin
    select into compteurId max(id) from file_rouge.ventes;
    if compteurId is null then
      compteurId:=0;
    end if;
    new.id := compteurId + 1;
  return new;
end; '
LANGUAGE'plpgsql';


create trigger ventesTrigger
before insert
on file_rouge.ventes
for each row
execute procedure incrementerIdVentes();


