drop table Student_in_Veranstaltung;
drop table Veranstaltungen;
drop table Dozenten;
drop table Studenten;
drop table Ahnen;

create table Studenten(
	Name varchar(30),
	Matrikel decimal(4,0),
	Geburtstag date,
	primary key (Matrikel),
	constraint matrikel_nicht_negativ check(Matrikel>=0)
);
create table Dozenten(
	Name varchar(30),
	Buero varchar(30) not null,
	Tel varchar(30),
	primary key(Name)
);
create table Veranstaltungen(
	Name varchar (30),
	Semester char(4),
	Raum varchar (8),
	Dozent varchar (30),
	primary key (Name, Semester),
	foreign key (Dozent) references Dozenten(Name)
);
create table Student_in_Veranstaltung(
	Student decimal(4,0),
	Veranstaltung varchar(30),
	Semester char(4),
	Note Decimal(2,1),
	foreign key (Student) references Studenten(Matrikel),
	foreign key (Veranstaltung, Semester) references Veranstaltungen(Name,Semester),
	constraint schulnote check(Note >= 1 and Note<=5),
	primary key (Student, Veranstaltung, Semester)
);

insert into Dozenten (Name, Tel, Buero) values ('Klaus', '123', 'C201');
insert into Veranstaltungen (Dozent, Name, Raum, Semester) values 
	('Klaus','Tanzgymnastik','D111','ss22'),
	('Klaus','Tanzgymnastik','D111','ws21'),
	('Klaus','Sackhüpfen','Strand','ws21'),
	('Klaus','Sackhüpfen','Strand','ss22');

insert into Dozenten (Name, Buero) values ('Maria', 'D120');
insert into Veranstaltungen (Dozent, Name, Raum, Semester) values 
	('Maria','Drachenfliegen','Strand','ss22'),
	('Maria','Drachenfliegen','Strand','ws21'),
	('Maria','Beachvolleyball','Strand','ss22'),
	('Maria','Beachvolleyball','Strand','ws21');

insert into Dozenten (Name, Buero) values ('Sepp', 'D10');
insert into Veranstaltungen (Dozent, Name, Raum, Semester) values 
	('Sepp','Bankdrücken','F101','ss21'),
	('Sepp','Bankdrücken','F101','ws21');


insert into Studenten (Name, Matrikel, Geburtstag) values 
	('Eva',3333,'2000-03-01'),
	('Luise',3334,'2000-06-02'),
	('Daniel',3335,'2000-07-01'),
	('Sepp',3331,'2000-02-01'),
	('Dominik',3336,'2000-08-01');

insert into Student_in_Veranstaltung (Student, Veranstaltung, Semester, Note) values 
	(3333,'Tanzgymnastik','ws21',1.0),
	(3333,'Drachenfliegen','ss22',1.3),
	(3333,'Beachvolleyball','ws21',2.2),
	(3334,'Tanzgymnastik','ss22',3.0),
	(3334,'Tanzgymnastik','ws21',5.0),
	(3335,'Sackhüpfen','ws21',3.0),
	(3335,'Beachvolleyball','ss22',1.0),
	(3331,'Tanzgymnastik','ss22',3.7),
	(3331,'Sackhüpfen','ws21',1.0),
	(3336,'Drachenfliegen','ws21',1.3),
	(3336,'Beachvolleyball','ws21',1.3);
	
create table Ahnen 
(
	Name varchar(50) not null,
	Vater varchar(50),
	Mutter varchar(50),
	primary key (Name),
	foreign key (Vater) references Ahnen(Name),
	foreign key (Mutter) references Ahnen(Name)
)

insert into Ahnen (Name, Vater, Mutter) values 
	('Greta','Markus','Sabine'),
	('Herbert','Gerd','Hanna'),
	('Marie','Herbert','Greta'),
	('Luise','Markus','Sabine'),
	('Sebastian','Gerd','Hanna'),
	('Vitus','Gerd','Hanna'),
	('Gerd','Max','Sibylle'),
	('Hanna','Moritz','Uschi'),
	('Klaus','Moritz','Uschi'),
	('Sophie','Hubert','Hella'),
	('Markus','Hubert','Hella'),
	('Sabine','Michi','Denka'),
	('Hubert',null,null),
	('Hella',null,null),
	('Michi',null,null),
	('Denka',null,null),
	('Max',null,null),
	('Sibylle',null,null),
	('Moritz',null,null),
	('Uschi',null,null);
	
-- Aufgabe 10.1.a
-- Beste Note
select
	D.Name,
	V.Name,
	min(SinV.Note)
from 
	Dozenten as D
	inner join Veranstaltungen as V 
	on V.Dozent=D.Name
	inner join Student_in_Veranstaltung as SinV 
	on SinV.Veranstaltung = V.Name and SinV.Semester=V.Semester
group by D.Name,V.Name;

-- Aufgabe 10.1.b
-- schlechteste Note eines Dozenten
select
	D.Name,
	--V.Name,
	max(SinV.Note)
from 
	Dozenten as D
	inner join Veranstaltungen as V 
	on V.Dozent=D.Name
	inner join Student_in_Veranstaltung as SinV 
	on SinV.Veranstaltung = V.Name and SinV.Semester=V.Semester
group by D.Name--,V.Name;

-- Aufgabe 10.1.c
-- Anzahl studenten in jeder Veranstaltung
select
	D.Name,
	V.Name,
	count(*)
from 
	Veranstaltungen as V
	inner join Dozenten as D
	on V.Dozent=D.Name
	inner join Student_in_Veranstaltung as SinV 
	on SinV.Veranstaltung = V.Name and SinV.Semester=V.Semester
group by D.Name,V.Name;

-- Aufgabe 10.1.d
-- Durchscnittliche Anzahl der Studenten in den Veranstaltungen eines Dozenten
select
	anz.dozenten_name,
	avg(anz.anzahl_studenten)
from 
	(	select
			D.Name as dozenten_name,
			V.Name,
			count(*) as anzahl_studenten --cast(count(*) as decimal(4,2)) as anzahl_studenten --Für Nachkommastellen in der Rundung
		from 
			Dozenten as D
			inner join Veranstaltungen as V 
			on V.Dozent=D.Name
			inner join Student_in_Veranstaltung as SinV 
			on SinV.Veranstaltung = V.Name and SinV.Semester=V.Semester
		group by D.Name,V.Name
	) as anz
group by dozenten_name;

-- Aufgabe 10.2.a
-- Alle Veranstaltungen eines Dozenten für die sich noch kein Student registriert hat
select * 
from	Dozenten left join Veranstaltungen on Veranstaltungen.Dozent=Dozenten.Name
		left join Student_in_Veranstaltung on 
				Veranstaltungen.Name=Student_in_Veranstaltung.Veranstaltung and 
				Veranstaltungen.Semester=Student_in_Veranstaltung.Semester
where	Veranstaltungen.Name is not null and 
		Veranstaltungen.Semester is not null and
		Student_in_Veranstaltung.Semester is null and
		Student_in_Veranstaltung.Veranstaltung is null and
		Student_in_Veranstaltung.Student is null

-- Aufgabe 10.2.b
-- Liste aller Studenten, wenn möglich mit besuchten Veranstaltungen
Select * 
from	Studenten 
		left join Student_in_Veranstaltung on Student_in_Veranstaltung.Student=Studenten.Matrikel 

-- Aufgabe 10.2.c
-- Right join 
Select * 
from	Student_in_Veranstaltung
		right join Studenten  on Student_in_Veranstaltung.Student=Studenten.Matrikel;


-- Aufgabe 10.3.a
-- Alle direkten Ahnen zu eiener Person
select Name as Name, Vater as Ahne
from Ahnen 
	union 
select Name as Name, Mutter as Ahne
from Ahnen;

-- Aufgabe 10.3.b
-- erste, zweite und dritte Verwandtschaftsverhältnisse
-- (Aufgabe 9.3.4 direkt mit Verwandschaftsgrad)
with 
	ersteVerwandtschaftsverhaeltnisse (Name,Ahne,Grad) as (
		select Name, Vater as Ahne, 1 as Grad
		from Ahnen 
			union 
		select Name, Mutter as Ahne, 1 as Grad
		from Ahnen 
	),

	zweiteVerwandtschaftsverhaeltnisse (Name,Ahne,Grad) as (
		select ersteVerwandtschaftsverhaeltnisse.Name as Name , Ahnen.Name as Ahne, ersteVerwandtschaftsverhaeltnisse.Grad+1
		from ersteVerwandtschaftsverhaeltnisse, Ahnen
		where
			Ahnen.Name in 
			(
				select naechsterAhne.Vater 
				from Ahnen as naechsterAhne 
				where ersteVerwandtschaftsverhaeltnisse.Ahne=naechsterAhne.Name
			) or 
			Ahnen.Name in 
			(
				select naechsterAhne.Mutter 
				from Ahnen as naechsterAhne 
				where ersteVerwandtschaftsverhaeltnisse.Ahne=naechsterAhne.Name
			)
	),

	dritteVerwandtschaftsverhaeltnisse (Name,Ahne,Grad) as (
		select zweiteVerwandtschaftsverhaeltnisse.Name as Name , Ahnen.Name as Ahne, zweiteVerwandtschaftsverhaeltnisse.Grad+1
		from zweiteVerwandtschaftsverhaeltnisse, Ahnen
		where
			Ahnen.Name in 
			(
				select naechsterAhne.Vater 
				from Ahnen as naechsterAhne 
				where zweiteVerwandtschaftsverhaeltnisse.Ahne=naechsterAhne.Name
			) or 
			Ahnen.Name in 
			(
				select naechsterAhne.Mutter 
				from Ahnen as naechsterAhne 
				where zweiteVerwandtschaftsverhaeltnisse.Ahne=naechsterAhne.Name
			)
	)

select * from ersteVerwandtschaftsverhaeltnisse
union
select * from zweiteVerwandtschaftsverhaeltnisse
union
select * from dritteVerwandtschaftsverhaeltnisse;

-- Aufgabe 10.3.c die Rekursion
-- (Aufgabe 10.3.d direkt mit Verwandschaftsgrad)
with Stammbaum(Name, Ahne, Grad) as
(
	select A.Name as Name, A.Vater as Ahne, 1 as Grad
	from Ahnen as A

	union all

	select A.Name as Name, A.Mutter as Ahne, 1 as Grad
	from Ahnen as A

	union all

	select S.Name as Name , A.Name as Ahne, Grad+1 as Grad 
	from Stammbaum as S, Ahnen as A 
	where
		A.Name in 
		(
			select naechsterAhne.Vater 
			from Ahnen as naechsterAhne 
			where S.Ahne=naechsterAhne.Name
		) or 
		A.Name in 
		(
			select naechsterAhne.Mutter 
			from Ahnen as naechsterAhne 
			where S.Ahne=naechsterAhne.Name
		)
)
select DISTINCT * from Stammbaum  
order by Name ASC, Grad DESC ;


-- Alternative Implementierung zu der Rekursion (auch mit Verwandschaftsgrad)
-- Zuerst erstellen wir eine Tabelle Combo, die alle
-- (Name, Eltern) Einträge enthält, dann machen wir auf dieser
-- Tabelle die Rekursion.
with 
Combo(Name, Ahne, Grad) as
(
	select A.Name as Name, A.Vater as Ahne, 1 as Grad
	from Ahnen as A

	union all

	select A.Name as Name, A.Mutter as Ahne, 1 as Grad
	from Ahnen as A	
),

Stammbaum2(Name, Ahne, Grad) as
(
	select * from Combo 

	union all

	select S.Name as Name , A.Name as Ahne, S.Grad+1 as Grad 
	from Stammbaum2 as S, Combo as A 
	where
		A.Name in 
		(
			select naechsterAhne.Ahne 
			from Combo as naechsterAhne 
			where S.Ahne=naechsterAhne.Name
		) 
)
select * from Stammbaum2;


-- Noch eine alternative Implementierung, bei der quasi andersrum
-- in den Ahnen Stammbaum geschaut wird. 

with 
Verwandschaft(Name, Ahne, Grad) as
(
	select 
		Kind.Name as 'Kind', 
		Ahne.Name as 'Ahne',
		cast(1 as int) as 'Grad'
	from
		Ahnen as Kind, Ahnen as Ahne
	where 
		Kind.Vater = Ahne.Name 
		or Kind.Mutter=Ahne.Name
),

Stammbaum(Name, Ahne, Grad) as
(
	select Name, Ahne, Grad from Verwandschaft

	union all

	select 
		Kind.Name as 'Kind', 
		Ahne.Ahne as 'Ahne',
		Kind.Grad+1
	from
		Stammbaum as Kind, Verwandschaft as Ahne
	where 
		Kind.Ahne=Ahne.Name
)
select * from Stammbaum;
