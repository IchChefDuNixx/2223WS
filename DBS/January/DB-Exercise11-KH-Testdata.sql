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

--1
create table r1(
	sid int,
	pid int,
	primary key(sid,pid)
)
create table r2(
	pid int primary key
)
insert into r1(sid,pid) values
	(101,1),
	(102,1),
	(101,3),
	(103,2),
	(102,2),
	(102,3),
	(102,4),
	(102,5);
insert into r2(pid) values
	(1),
	(2),
	(3),
	(4),
	(5);

select sid from r1
except
select sid from(
	select * from (select sid from r1) as a,r2
	except 
	select * from r1
) as b

--2
alter table Veranstaltungen
add foreign key (Dozent) references Dozenten(Name) on delete set null on update cascade

alter table Student_in_Veranstaltung
add foreign key (Student) references Studenten(Matrikel) on delete set null,
	foreign key (Veranstaltung, Semester) references Veranstaltungen(Name,Semester) on update cascade
	

select * from Studenten
select * from Dozenten
select * from Veranstaltungen
select * from Student_in_Veranstaltung

--3
create trigger newLecturer
on Dozenten
after insert
as insert into Veranstaltungen (Dozent, Name, Raum, Semester) 
   Select inserted.name, 'Einführung '+ inserted.name, null, 'SS99' from inserted 


drop trigger newLecturer
insert into Dozenten(Name, Tel, Buero) values
	('Alfredo','124','A01'),
	('Alfreda','124','A01');
delete from Dozenten where Name like ('Alfred%')
select * from Veranstaltungen

drop view eventplan

create View eventplan
as select Studenten.Name,Student_in_Veranstaltung.Veranstaltung,Student_in_Veranstaltung.Semester,stud2.Name as participant
from Studenten left join Student_in_Veranstaltung 
	on Studenten.Matrikel=Student_in_Veranstaltung.Student 
		left join Student_in_Veranstaltung as SiV 
		on Student_in_Veranstaltung.Veranstaltung=SiV.Veranstaltung and Student_in_Veranstaltung.Semester=SiV.Semester
			,Studenten as stud2
where SiV.Student=stud2.Matrikel

select eventplan.Name,Veranstaltung,eventplan.Semester,Raum,
	case
		when eventplan.Name=participant then null
		else participant
	end as participant	
from eventplan,Veranstaltungen
where eventplan.Veranstaltung=Veranstaltungen.Name and eventplan.Semester=Veranstaltungen.Semester
order by Name,participant

--4b
grant select on eventplan to public
revoke insert,delete on eventplan to public
 










drop table Student_in_Veranstaltung;
drop table Veranstaltungen;
drop table Dozenten;
drop table Studenten;
drop table Ahnen;

