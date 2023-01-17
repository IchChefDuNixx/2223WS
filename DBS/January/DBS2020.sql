create table lehrer (
	lnr int primary key,
	lname nvarchar(100) not null
)
create table unterrichtet (
	lehrer int foreign key references lehrer(lnr),
	fach nvarchar(20),
	klasse nvarchar(10),
	primary key(fach, klasse)
)
create table noten (
	datum date,
	klasse nvarchar(10),
	fach nvarchar(20),
	sch�ler nvarchar(100),
	note float
	primary key (datum, klasse, fach, sch�ler),
	foreign key (fach, klasse) references unterrichtet(fach, klasse)
)
INSERT INTO lehrer (lnr, lname) VALUES (1, 'Smith');
INSERT INTO lehrer (lnr, lname) VALUES (2, 'Johnson');
INSERT INTO lehrer (lnr, lname) VALUES (3, 'Williams');
INSERT INTO unterrichtet (lehrer, fach, klasse) VALUES (1, 'History', '8A');
INSERT INTO unterrichtet (lehrer, fach, klasse) VALUES (2, 'Art', '8A');
INSERT INTO unterrichtet (lehrer, fach, klasse) VALUES (3, 'Physical Education', '8A');
INSERT INTO unterrichtet (lehrer, fach, klasse) VALUES (1, 'Math', '10A');
INSERT INTO unterrichtet (lehrer, fach, klasse) VALUES (2, 'Science', '10B');
INSERT INTO unterrichtet (lehrer, fach, klasse) VALUES (3, 'English', '10C');
INSERT INTO noten (datum, klasse, fach, sch�ler, note) VALUES ('2021-01-01', '10A', 'Math', 'StudA', 85);
INSERT INTO noten (datum, klasse, fach, sch�ler, note) VALUES ('2021-01-02', '10B', 'Science', 'StudB', 90);
INSERT INTO noten (datum, klasse, fach, sch�ler, note) VALUES ('2021-01-03', '10C', 'English', 'StudC', 80);
INSERT INTO noten (datum, klasse, fach, sch�ler, note) VALUES ('2021-01-01', '8A', 'History', 'StudD', 85);
INSERT INTO noten (datum, klasse, fach, sch�ler, note) VALUES ('2021-01-02', '8A', 'Art', 'StudE', 90);
INSERT INTO noten (datum, klasse, fach, sch�ler, note) VALUES ('2021-01-03', '8A', 'Physical Education', 'StudF', 80);

--3a
select sch�ler,note
from noten
where klasse='8a' and fach='Art' -- statt Physik
order by sch�ler
--b maybe left join and case to get the 0
select lehrer.lname, cast(avg(noten.note) as decimal(4,2)) as avgGrade
from lehrer, unterrichtet, noten
where lehrer.lnr=unterrichtet.lehrer and unterrichtet.fach=noten.fach and unterrichtet.klasse=noten.klasse
group by lehrer.lname
order by avg(noten.note) desc -- weil in DE gr��er = schlechter
--c
create function topNote(@klasse nvarchar(10), @fach nvarchar(20))
returns table
as
return (
	select sch�ler, max(note) as besteNote
	from noten 
	where fach=@fach and klasse=@klasse
	group by sch�ler
);
select * from topNote('Math', '10A')
select sch�ler, max(note) as besteNote
from noten 
where fach='Math' and klasse='10A'
group by sch�ler
--2
/*
a1,a2 -> a3
c1 -> c2
c1,b1 -> c2,b2
a1,a2,c1 -> a3,c2,mag1
key(a1,a2,c1,b1)
*/
--4
/*
a primary key und unique werte bzw tupel m�ssen in der datenbank einmalig sein. durch beide l�sst sich ein datensatz eindeutig feststellen. der interne speicher wird nur nach dem primary key sortiert.
b das hei�t, dass �nderungen in einer view die selben �nderungen zu folge haben m�ssen wie wenn man diese operation an der datenbank selbst ausf�hrt.
c referenzielle integrit�t in/zwischen tabellen besteht wenn bestimmte regeln befolgt werden, die daf�r sorgen, dass die daten accurate und consistent sind.
d bei der verwendung von group by muss entweder jedes element in der selektionsliste direkt mit einbezogen oder in einer aggregatfunktion sein.
e eine sprache ist relational vollst�ndig wenn man mit den funktionen alle querys darstellen kann, die auch mit relationaler algebra m�glich sind.
f BCNF vereinheitlicht tabellen auf einem hohen niveau, verhindert anomalien und reduziert redundanz.
g 3NF ist �hnlich zu BCNF indem dadurch anomalien/redundanzen reduziert werden. das ist zwar immer erstrebenswert, aber in manchen szenarien kommt es vor, dass die daten in einem non-3NF konformen zustand besser sind oder die tabelle nicht in 3NF gebracht werden kann.
*/















drop table noten
drop table unterrichet
drop table lehrer