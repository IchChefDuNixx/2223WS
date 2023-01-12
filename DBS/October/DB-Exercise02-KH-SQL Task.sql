--use Vorlesung_DB;
/*Übung 2*/

-- Tabellen erstellen
create table R(
	A int,
	Y int,
	Z int
);
create table S(
	Y int,
	Z int,
	B int
);

-- Daten einfügen wie auf dem Übungsblatt
insert into R (A,Y,Z) values
(1,1,2),
(2,1,1),
(3,1,1),
(9,3,4),
(7,2,2);

insert into S (Y,Z,B) values 
(1,2,6),
(1,2,7),
(1,1,8),
(7,8,9),
(2,1,5),
(3,9,4),
(2,4,2),
(9,4,1);


-- Daten Abfragen
--b)
select Z, Y from S where Y=1
intersect
select Z, Y from S where Y=1;

--d)
select * from R, S where R.Y=S.Y and R.Z=S.Z

--f)
select B as 'A', Z, Y from S where B=1
union
select A, Z, Y from R where A=1



-- Tabellen wieder löschen
-- macht man normalerweise nicht, ist aber für die Übungen praktisch.
drop table R, S;
