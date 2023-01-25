drop table Student_in_Veranstaltung;
drop table Veranstaltungen;
drop table Dozenten;
drop table Studenten;

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
	-- Lösung zu 11.2.b und 11.2.c
	foreign key (Dozent) references Dozenten(Name) on delete set null on update cascade
);
create table Student_in_Veranstaltung(
	Student decimal(4,0),
	Veranstaltung varchar(30),
	Semester char(4),
	Note Decimal(2,1),
	-- Lösung zu 11.2.a
	foreign key (Student) references Studenten(Matrikel) on delete cascade,
	-- Lösung zu 11.2.c
	foreign key (Veranstaltung, Semester) references Veranstaltungen(Name,Semester) on update cascade,
	constraint schulnote check(Note >= 1 and Note<=5),
	primary key (Student, Veranstaltung, Semester)
);

insert into Dozenten (Name, Tel, Buero) values ('Klaus', '123', 'C201');
insert into Veranstaltungen (Dozent, Name, Raum, Semester) values 
	('Klaus','Tanzgymnastik','D111','ss18'),
	('Klaus','Tanzgymnastik','D111','ws17'),
	('Klaus','Sackhüpfen',null,'ws17');

insert into Dozenten (Name, Buero) values ('Maria', 'D120');
insert into Veranstaltungen (Dozent, Name, Raum, Semester) values 
	('Maria','Drachenfliegen','Strand','ss17'),
	('Maria','Drachenfliegen','Strand','ss18'),
	('Maria','Beachvolleyball','Strand','ss17'),
	('Maria','Beachvolleyball','Strand','ss18');

insert into Dozenten (Name, Buero) values ('Sepp', 'D10');

insert into Studenten (Name, Matrikel, Geburtstag) values 
	('Eva',3333,'1990-03-01'),
	('Luise',3334,'1990-06-02'),
	('Daniel',3335,'1990-07-01'),
	('Sepp',3331,'1993-02-01'),
	('Dominik',3336,'1990-08-01');

insert into Student_in_Veranstaltung (Student, Veranstaltung, Semester, Note) values 
	(3333,'Beachvolleyball','ss18',1.0),
	(3334,'Beachvolleyball','ss18',2.2),
	(3335,'Beachvolleyball','ss18',2.4),
	(3331,'Beachvolleyball','ss18',2.4),
	(3336,'Beachvolleyball','ss18',2.4),
	(3333,'Drachenfliegen','ss17',4.0),
	(3336,'Drachenfliegen','ss17',4.0),
	(3334,'Tanzgymnastik','ws17',5),
	(3335,'Tanzgymnastik','ws17',2.2),
	(3334,'Beachvolleyball','ss17',1.2),
	(3335,'Beachvolleyball','ss17',1.3);


-- Aufgabe 11.1 Division: Alle Veranstaltungen die vollständig bewertet wurden
select SinV.Veranstaltung, SinV.Semester
from Student_in_Veranstaltung as SinV
	except
select 
		Unvollstaendig.Veranstaltung,  
		Unvollstaendig.Semester
from(
		select	
			AlleMoeglichenBewertungen.Veranstaltung,
			AlleMoeglichenBewertungen.Semester,
			Studenten.Matrikel 
		from (select distinct veranstaltung, semester from Student_in_Veranstaltung) as AlleMoeglichenBewertungen, Studenten
			except 	
		select Veranstaltung, Semester, Student from Student_in_Veranstaltung where note is not null	-- Hier, wenn man es ganz genau nimmt könnte es auch Studis 
																									-- geben die null als Note haben, und das ist keine Bewertung
) as Unvollstaendig


-- Aufgabe 11.3 Trigger (Auskommentiert, da nicht im Batch verarbeitbar)
/*
drop trigger erzeuge_einfuerhungsveranstaltung
create trigger erzeuge_einfuerhungsveranstaltung 
on Dozenten
		after insert
		as begin
			 insert into Veranstaltungen (Dozent, Name, Raum, Semester) 
			 Select inserted.name, 'Einführung '+ inserted.name, null, 'SS99' from inserted 
		end;
*/

-- Aufgabe 11.4.a Sichten (Auskommentiert, da nicht im Batch verarbeitbar)
/*
drop view Veranstaltungsplan;
create view Veranstaltungsplan as
	select	S.Name as Student, V.Name as Veranstaltung, V.Semester as Semester, V.Raum as Raum, D.Name as Dozent
	From	Studenten as S 
			left join Student_in_Veranstaltung as SinV on (SinV.Student = S.Matrikel)
			left join Veranstaltungen as V on (V.Name=SinV.Veranstaltung and V.Semester=SinV.Semester)
			left join Dozenten as D on (V.Dozent=D.Name)
*/
-- select * from Veranstaltungsplan;

-- Aufgabe 11.4.b Zugriffskontrolle
grant select on Veranstaltungsplan to public;
revoke insert, update, delete on Veranstaltungsplan to public;

