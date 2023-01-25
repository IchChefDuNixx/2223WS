drop table tier_frisst;

create table tier_frisst(
	tier varchar(30),
	frisst varchar (30)
);


insert into tier_frisst (tier, frisst) values
	('Affe','Banane'),
	('Affe','Apfel'),
	('Affe','Frosch'),
	('Frosch','Fliege'),
	('Fliege','Apfel'),
	('Fliege','Zuckerwasser'),
	('Schakal','Affe'),
	('Wolf','Schakal'),
	--('Fliege','Wolf'),
	('Wolf','Apfel');

-- Aufgabe 1a

-- Aufgabe 1b
insert into tier_frisst (tier, frisst) values
	('Fliege','Wolf');

-- Aufgabe 1c

-- Aufgabe 1d

