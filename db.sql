--drop table if exists dw.ventes;
DROP TABLE IF EXISTS dw.customer, dw.prestation, dw.annee, dw.trimestre, dw.mois,
dw.jour, dw.heure, dw.ventes, dw.cities, dw.regions, dw.departments;

CREATE TABLE dw.customer(
	customer_id serial,
	nom VARCHAR(64) NOT NULL,
	prenom VARCHAR(64) NOT NULL,
	adresse VARCHAR(128) NOT NULL,
	created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(customer_id)
);

insert into dw.customer(customer_id, nom, prenom, adresse) values(-1, 'Université de Caen Normandie', ' ', 'Espl. de la Paix, 14000 Caen');

CREATE TABLE dw.prestation(
	prestation_id serial,
	code int NOT NULL,
	description VARCHAR(128) NOT NULL,
	created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(prestation_id)
);

CREATE TABLE dw.regions (
  id serial,
  code varchar(3)   NOT NULL,
  name varchar(255)   NOT NULL,
  slug varchar(255)   NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT regions_code_unique UNIQUE(code)
);

CREATE TABLE dw.departments (
  id serial,
  region_code varchar(3)   NOT NULL,
  code varchar(3)   NOT NULL,
  name varchar(255)   NOT NULL,
  slug varchar(255)   NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT departments_code_unique UNIQUE(code)
);

CREATE TABLE dw.cities (
  id serial,
  department_code varchar(3)   NOT NULL,
  insee_code varchar(5)   DEFAULT NULL,
  zip_code varchar(5)   DEFAULT NULL,
  name varchar(255)   NOT NULL,
  slug varchar(255)   NOT NULL,
  gps_lat float4 NOT NULL,
  gps_lng float4 NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE dw.annee(
	annee_id serial,
	annee int NOT NULL,
	PRIMARY KEY(annee_id)
);


CREATE TABLE dw.trimestre(
	trimestre_id serial,
	trimestre int,
	annee int NOT NULL,
	PRIMARY KEY(trimestre_id)
);

CREATE TABLE dw.mois(
	mois_id serial,
	mois int NOT NULL,
	trimestre int NOT NULL,
	human_readable_month varchar(20) NOT NULL,
	PRIMARY KEY(mois_id)
);

CREATE TABLE dw.jour(
	jour_id serial,
	jour int NOT NULL,
	--day_of_week varchar(15) NOT NULL,
	mois int NOT NULL,
	PRIMARY KEY(jour_id)
);

CREATE TABLE dw.heure(
	heure_id serial,
	heure int NOT NULL,
	--minutes int NOT NULL,
	slot varchar(6) NOT NULL,
  part_of_day varchar(12) NOT NULL,
	jour int NOT NULL,
	PRIMARY KEY(heure_id)
);

CREATE TABLE dw.ventes(
  id serial,
	heure_id int NOT NULL,
	customer_id int NOT NULL,
	cities_id int NOT NULL,
	prestation_id int NOT NULL,
	price int NOT NULL,
	insertion_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
);

