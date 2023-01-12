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

-- 1a
select Veranstaltungen.Dozent, Veranstaltungen.Name, Veranstaltungen.Semester, min(Student_in_Veranstaltung.Note) as BestGradeGiven
from Veranstaltungen inner join Student_in_Veranstaltung 
on  Veranstaltungen.Name = Student_in_Veranstaltung.Veranstaltung and Veranstaltungen.Semester = Student_in_Veranstaltung.Semester
group by Veranstaltungen.Dozent, Veranstaltungen.Name,  Veranstaltungen.Semester
order by Semester desc, Name;

-- 1b
select Dozent, max(Note) as WorstGradeGive
from Veranstaltungen as Vst inner join Student_in_Veranstaltung as SiV
on Vst.Name = SiV.Veranstaltung and Vst.Semester = SiV.Semester
group by Dozent
order by WorstGradeGive desc, Dozent;

-- 1c
select Vst.Name, Vst.Semester, Vst.Dozent, count(SiV.Note) as StudentsParticipated
from Veranstaltungen as Vst inner join Student_in_Veranstaltung as SiV
on Vst.Name = SiV.Veranstaltung and Vst.Semester = SiV.Semester
group by Vst.Name, Vst.Semester, vst.Dozent
order by Name, Semester desc, StudentsParticipated desc;

-- 1d
select SPE.Dozent, avg(StudentsPerEvent) as AVG_SPD from( -- average students per dozent
	select Vst.Name, Vst.Dozent, count(SiV.Student) as StudentsPerEvent
	from Veranstaltungen as Vst inner join Student_in_Veranstaltung as SiV
	on Vst.Name = SiV.Veranstaltung and Vst.Semester = SiV.Semester
	group by Vst.Name, Vst.Dozent
	) as SPE 
group by Dozent 
order by AVG_SPD;

-- 2a, Semi join since the select is on just 1 of the joining tables (left)
select Vst.*
from Veranstaltungen as Vst left join Student_in_Veranstaltung as SiV
on Vst.Name = SiV.Veranstaltung and Vst.Semester = SiV.Semester
where Student is null;

-- 2b
select Studenten.Name, Studenten.Matrikel, Student_in_Veranstaltung.Veranstaltung, Student_in_Veranstaltung.Semester
from Studenten left join Student_in_Veranstaltung
on Studenten.Matrikel = Student_in_Veranstaltung.Student
order by Matrikel, Veranstaltung, Semester desc;

-- 2c
select Studenten.Name, SiVRJVst.* from(
	select Student_in_Veranstaltung.Student, Veranstaltungen.Name, Veranstaltungen.Semester
	from Student_in_Veranstaltung right join Veranstaltungen
	on Student_in_Veranstaltung.Veranstaltung = Veranstaltungen.Name and Student_in_Veranstaltung.Semester = Veranstaltungen.Semester
	) as SiVRJVst, Studenten
where SiVRJVst.Student = Studenten.Matrikel
order by Matrikel, SiVRJVst.Name, Semester desc;

-- 3
with 
-- P, 3a
descendant1 as (
	select Name, Vater as Parent from Ahnen
	union
	select Name, Mutter as Parent from Ahnen
),
-- GP, 3b
descendant2 as (
	select d10.Name, d10.Parent,
		case 
			when d10.Parent is null then null
			else d11.Parent
		end as GrandParent
	from descendant1 as d10, descendant1 as d11
	where d10.Parent is null or d10.Parent = d11.Name
),
-- GGP, 3b
descendant3 as (
	select d20.Name, d20.Parent, d20.GrandParent,
		case
			when d20.GrandParent is null then null
			else d21.GrandParent
		end as GreatGrandParent
	from descendant2 as d20, descendant2 as d21
	where d20.GrandParent is null or d20.GrandParent = d21.Parent
)
-- end with
select distinct * from descendant3
order by Name;

-- manual2
with desc1 as (
	select Name, Vater as Parent from Ahnen
	union
	select Name, Mutter as Parent from Ahnen
), 
desc2 as (
	select * from desc1
	union
	select d10.Name, d11.Parent as GrandParent
	from desc1 as d10, desc1 as d11
	where d10.Parent = d11.Name
), 
desc3 as (
	select * from desc2
	union
	select d20.Name, d21.Parent as GreatGrandParent
	from desc2 as d20, desc2 as d21
	where d20.Parent = d21.Name
) 
select distinct * from desc3 order by Name;

-- recursive, 3c
with initial as (
	select Name, Vater as Parent from Ahnen
	union
	select Name, Mutter as Parent from Ahnen
),
recursion as (
	select Name, Parent as Ancestor from initial

	union all

	select initial.Name, recursion.Ancestor
	from initial,recursion
	where initial.Parent = recursion.Name
)
select distinct * from recursion
order by Name;

-- recursive with degree of relationship, 3d chess
with initial as (
	select *,
		case
			when Parent is null then 0
			else 1
		end as Degree
	from (
		select Name, Vater as Parent from Ahnen
		union
		select Name, Mutter as Parent from Ahnen
	) as initHelper
),
recursion as (
	select * from initial

	union all

	select initial.Name, recursion.Parent,
		case
			when recursion.name = initial.Parent then recursion.Degree + 1
		end as Degree
	from recursion, initial
	where recursion.name = initial.Parent
) 
select distinct Name, Parent as Ancestor,
	case
		when Parent is null then 0
		else Degree
	end as Degree
from recursion
order by Name, Degree desc;

drop table Student_in_Veranstaltung;
drop table Veranstaltungen;
drop table Dozenten;
drop table Studenten;
drop table Ahnen;