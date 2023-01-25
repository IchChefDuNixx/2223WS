--use Vorlesung_DB;
/*Übung 2*/


create table Studenten(
	Name varchar(30),
	Matrikel decimal(4,0),
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

-- Zusatzaufgabe
alter table Studenten add Geburtstag date;
update Studenten set Geburtstag='19000101' where Geburtstag is null;
alter table Studenten alter column Geburtstag date not null;

-- Alternative
alter table Studenten add constraint my_birthday_constraint default '1990-01-01' for Geburtstag

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
insert into Studenten (Name, Matrikel, Geburtstag) values 
	('Eva',3333,'1990-03-01'),
	('Luise',3334,'1990-06-02'),
	('Daniel',3335,'1990-07-01'),
	('Dominik',3336,'1990-08-01');
insert into Student_in_Veranstaltung (Student, Veranstaltung, Semester) values 
	(3333,'Beachvolleyball','ss18'),
	(3334,'Beachvolleyball','ss18'),
	(3335,'Beachvolleyball','ss18'),
	(3333,'Drachenfliegen','ss17'),
	(3336,'Drachenfliegen','ss17'),
	(3334,'Tanzgymnastik','ws17'),
	(3335,'Tanzgymnastik','ws17'),
	(3334,'Beachvolleyball','ss17'),
	(3335,'Beachvolleyball','ss17');

update Student_in_Veranstaltung set Note=4.0 where Veranstaltung='Beachvolleyball' and (Note<4.0 or Note is null);
update Dozenten set Buero='D22' where Name='Maria';

delete from Student_in_Veranstaltung where Student='3333'

-- Maria aus den Dozenten löschen
delete from Student_in_Veranstaltung where Veranstaltung in (Select name from Veranstaltungen where Dozent='Maria')
delete from Veranstaltungen where Dozent = 'Maria'
delete from Dozenten where name='Maria';

drop table Student_in_Veranstaltung;
drop table Veranstaltungen;
drop table Studenten;
drop table Dozenten;
