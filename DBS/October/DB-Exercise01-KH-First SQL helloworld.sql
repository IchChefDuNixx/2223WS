/*
Verbinden Sie sich mit der Datenbank der TH oder installieren Sie eine lokale Instanz die Sie auch offline verwenden können 
(äußerst praktisch für den weiteren Verlauf der Vorlesung):

https://www.microsoft.com/en-us/sql-server/sql-server-downloads
Paket SQL Express
Quellen manuell runterladen
nur LocalDB Paket
Über MSSQL Server Management Studio verbinden, google sagt ihnen wie.

Folgende Codeschnipsel lassen sich nun ausführen, spielen
Sie mal damit! 
*/

/*Folgende Codezeilen erzeugen ein einfaches Schema */
create table person(
	name varchar(100),
	tel varchar (100)
)
/* In dieses können Sie Daten einfügen */
insert into person(name,tel) values
	('Klaus','125234651346'),
	('Maria','43563456'),
	('Johanna','45674567');

/* Oder Daten abrufen */
select * from person;

/* Oder die Tabelle löschen */
drop table person;

/* Ex02.1 */



create table R(
	A integer,
	Y integer,
	Z integer
)

insert into R(A,Y,Z) values
	(1,1,2),
	(2,1,1),
	(3,1,1),
	(9,3,4),
	(7,2,2);

create table S(
	Y integer,
	Z integer,
	B integer
)

insert into S(Y,Z,B) values
	(1,2,6),
	(1,2,7),
	(7,1,8),
	(7,8,9),
	(2,1,5),
	(3,9,4),
	(2,4,2),
	(9,4,1);

create table a(
	D integer
)

insert into a(D) values
	(1),
	(2);

create table b(
	Z integer,
	Y integer
)

insert into b(Z,Y) values
	(2,1),
	(1,1);

create table c(
	A integer,
	B integer
)

insert  into c(A,B) values
	(1,8),
	(1,9),
	(2,8),
	(2,9);

create table d(
	A int,
	Y int,
	Z int,
	B int
)

insert into d(A,Y,Z,B) values
	(1,1,2,6),
	(1,1,2,7),
	(2,1,1,8),
	(3,1,1,8);

create table e(
	A int,
	K int,
	Z int,
	Y int,
	B int
)

insert into e(A,K,Z,Y,B) values
	(1,1,2,1,6),
	(1,1,2,1,7),
	(2,1,1,1,8),
	(2,1,1,2,5),
	(3,1,1,1,8),
	(3,1,1,2,5),
	(9,3,4,2,2),
	(9,3,4,9,1),
	(7,2,2,1,6),
	(7,2,2,1,7);

create table f(
	A int,
	Y int,
	Z int
)

insert into f(A,Y,Z) values
	(1,1,2),
	(1,9,4);

create table g(
	Y int,
	Z int
)
	
insert into g(Y,Z) values
	(3,4),
	(2,2);

create table h(
	Y int,
	Z int
)

insert into h(Y,Z) values
	(1,2),
	(1,1);

create table i(
	Y int,
	Z int
)

insert into i(Y,Z) values
	(1,2),
	(1,1),
	(2,2);

--select * from R
--select * from S
select * from a
select * from b
select * from c
select * from d
select * from e
select * from f
select * from g
select * from h
select * from i
drop table R,S,a,b,c,d,e,f,g,h,i;