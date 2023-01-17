/*Ex02*/
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

-- Daten einfgen wie auf dem bungsblatt
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
--a)
select distinct Y as D from R where R.Y=1 or R.Z=2
--b)
select distinct Z,Y from S where Y=1
intersect
select distinct Z,Y from S where Y=1
--c)
select * from (select distinct R.A from R where R.A < 3) as A,(select distinct S.B from S where S.B > 7) as B
--d)
select distinct R.*,S.B from R,S where R.Y=S.Y and R.Z=S.Z
--e)
select distinct R.A,R.Y as K,R.Z,S.Y,S.B from R,S where R.Z=S.Z
--f)
select distinct * from R where R.A=1
union
select S.B as A,S.Y,S.Z from S where S.B=1
--g)
select R.Y,R.Z from R
except
select S.Y,S.Z from S
--h)
select R.Y,R.Z from R
intersect
select S.Y,S.Z from S
--i)
select distinct * from (select R.Y,R.Z from R union select S.Y,S.Z from S) as unRS where Y=1 or Z=2
-- Tabellen wieder lschen
-- macht man normalerweise nicht, ist aber fr die bungen praktisch.
drop table R, S;

/*Ex03*/
--1
create table Students(
	Name varchar(30),
	Matriculation decimal(4,0) primary key
)
create table Lecturers(
	Name varchar(30) primary key,
	Office varchar(30) not null,
	Tel varchar(30)
)
create table Events(
	Name varchar(30),
	Semester char(4),
	Room varchar(8),
	Lecturer varchar(30) references Lecturers(Name),
	primary key(Name, Semester)
)
create table Students_in_Events(
	Student decimal(4,0) references Students(Matriculation),
	Event varchar(30),
	Semester char(4),
	Grade decimal(2,1),
	foreign key (Event, Semester) references Events(Name, Semester),
	constraint singleAttendance unique(Student, Event, Semester),
	constraint realGrade check (Grade is null or Grade >= 1 and Grade <= 5)
)
--2
insert into Lecturers(Name,Office,Tel) values
	('Klaus','C201','123'),
	('Maria','D120',null);
insert into Events(Name,Semester,Room,Lecturer) values
	('Dance Gymnastics','ws17','D111','Klaus'),
	('Dance Gymnastics','ss18','D111','Klaus'),
	('Sack Race','ws18',null,'Klaus'),
	('Hang-Gliding','ss17','Beach','Maria'),
	('Beach Volleyball','ss17','Beach','Maria'),
	('Beach Volleyball','ss18','Beach','Maria');
insert into Students(Name, Matriculation) values
	('Eva',3333),
	('Luise',3334),
	('Daniel',3335),
	('Dominik',3336);
insert into Students_in_Events(Student,Event,Semester,Grade) values
	(3333,'Beach Volleyball','ss18',null),
	(3334,'Beach Volleyball','ss18',null),
	(3335,'Beach Volleyball','ss18',null),
	(3336,'Hang-Gliding','ss17',null),
	(3333,'Hang-Gliding','ss17',null),
	(3334,'Dance Gymnastics','ws17',null),
	(3335,'Dance Gymnastics','ws17',null),
	(3334,'Beach Volleyball','ss17',null),
	(3335,'Beach Volleyball','ss17',null);
alter table Students_in_Events add constraint VolleyballFailingGrade check (Event='Beach Volleyball' and Grade=null or Event='Beach Volleyball' and Grade <= 4 or not Event='Beach Volleyball')
update Lecturers set Office='D22' where Name='Maria'
delete from Students_in_Events where Student=3333
alter table Students add DoB date
update Students set DoB = cast('0001-01-01' as date)
alter table Students add constraint DoBmissing check (DoB is not null)
update Students set DoB = cast('1990-03-01' as date) where Matriculation = 3333
update Students set DoB = cast('1990-04-01' as date) where Matriculation = 3334
update Students set DoB = cast('1990-05-01' as date) where Matriculation = 3335
update Students set DoB = cast('1990-06-01' as date) where Matriculation = 3336
drop table Students_in_Events, Events, Lecturers, Students

/*Ex04*/
--1
select * from Lecturers where Office like 'D%'
select Matriculation from Students where Matriculation not in (select distinct Student from Students_in_Events where Semester='ss18')
select Name as Student, datediff(year, DoB, current_timestamp) as Age from Students where datediff(year, DoB, current_timestamp) between 20 and 40
--2
select Events.Name,Events.Semester,Students.Name 
from Students, Events, Students_in_Events 
where Students.Matriculation=Students_in_Events.Student and Events.Name=Students_in_Events.Event and Events.Semester=Students_in_Events.Semester and Events.Semester='ss18'

select s1.Name, s2.Name as '-> isOlderThan'
from Students as s1,Students as s2
where datediff(day, s1.DoB, s2.DoB) > 0
order by s1.DoB

select 
	case
	when Grade >= 4 then concat(Students.Name, ' hat am ', Students_in_Events.Event, ' ', Students_in_Events.Semester, ' teilgenommen und mit ', Students_in_Events.Grade, ' bestanden!')
	when Grade < 4 then concat(Students.Name, ' hat am ', Students_in_Events.Event, ' ', Students_in_Events.Semester, ' teilgenommen, aber leider nicht bestanden')
	else concat(Students.Name, ' hat am ', Students_in_Events.Event, ' ', Students_in_Events.Semester, ' teilgenommen')
	end as Text
from Students_in_Events, Students
where Students_in_Events.Student=Students.Matriculation and Semester in ('ws17','ss17','ss18')
--3
select Events.Lecturer, Events.Name, min(Grade) as bestGrade, max(Grade) as worstGrade
from Events,Students_in_Events
where Events.Name=Students_in_Events.Event and Events.Semester=Students_in_Events.Semester
group by Lecturer,Events.Name

/*Ex10*/
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
	('Klaus','Sackhpfen','Strand','ws21'),
	('Klaus','Sackhpfen','Strand','ss22');

insert into Dozenten (Name, Buero) values ('Maria', 'D120');
insert into Veranstaltungen (Dozent, Name, Raum, Semester) values 
	('Maria','Drachenfliegen','Strand','ss22'),
	('Maria','Drachenfliegen','Strand','ws21'),
	('Maria','Beachvolleyball','Strand','ss22'),
	('Maria','Beachvolleyball','Strand','ws21');

insert into Dozenten (Name, Buero) values ('Sepp', 'D10');
insert into Veranstaltungen (Dozent, Name, Raum, Semester) values 
	('Sepp','Bankdrcken','F101','ss21'),
	('Sepp','Bankdrcken','F101','ws21');

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
	(3335,'Sackhpfen','ws21',3.0),
	(3335,'Beachvolleyball','ss22',1.0),
	(3331,'Tanzgymnastik','ss22',3.7),
	(3331,'Sackhpfen','ws21',1.0),
	(3336,'Drachenfliegen','ws21',1.3),
	(3336,'Beachvolleyball','ws21',1.3);

--1a
with Events_leftJoin_SiE as (
	select Veranstaltungen.*,Student_in_Veranstaltung.Student, Student_in_Veranstaltung.Note
	from Veranstaltungen left join Student_in_Veranstaltung
	on Veranstaltungen.Name=Student_in_Veranstaltung.Veranstaltung and Veranstaltungen.Semester=Student_in_Veranstaltung.Semester
)
select Events_leftJoin_SiE.Dozent, Events_leftJoin_SiE.Name, min(Note) as bestGradeGiven
from Events_leftJoin_SiE
group by Dozent,Name
--b
select Veranstaltungen.Dozent, max(Student_in_Veranstaltung.Note) as worstGradeGiven
from Veranstaltungen left join Student_in_Veranstaltung
on Veranstaltungen.Name=Student_in_Veranstaltung.Veranstaltung and Veranstaltungen.Semester=Student_in_Veranstaltung.Semester
group by Veranstaltungen.Dozent
--c
select Veranstaltungen.Dozent, Veranstaltungen.Name, Veranstaltungen.Semester, count(*) as participants
from Veranstaltungen,Student_in_Veranstaltung
where Veranstaltungen.Name=Student_in_Veranstaltung.Veranstaltung and Veranstaltungen.Semester=Student_in_Veranstaltung.Semester
group by Dozent,Name,Veranstaltungen.Semester
--d
select Dozent, avg(ct) from (
	select Dozent,Veranstaltung,Veranstaltungen.Semester,count(*) as ct
	from Veranstaltungen,Student_in_Veranstaltung
	where Veranstaltungen.Name=Student_in_Veranstaltung.Veranstaltung and Veranstaltungen.Semester=Student_in_Veranstaltung.Semester
	group by Dozent,Veranstaltung,Veranstaltungen.Semester
) as temp
group by Dozent
--2a
select *
from Veranstaltungen left join Student_in_Veranstaltung
on Veranstaltungen.Name=Student_in_Veranstaltung.Veranstaltung and Veranstaltungen.Semester=Student_in_Veranstaltung.Semester
where Student is null
--b
select *
from Studenten left join Student_in_Veranstaltung
on Studenten.Matrikel=Student_in_Veranstaltung.Student
--c
select *
from Student_in_Veranstaltung right join Studenten
on Student_in_Veranstaltung.Student=Studenten.Matrikel
--3a
create table Ahnen(
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

with FDR as (
	select Name, Vater as Ahne from Ahnen
	union
	select Name, Mutter as Ahne from Ahnen
),
SDR as (
	select distinct FDR1.*, FDR2.Ahne as Urahne from FDR as FDR1,FDR as FDR2 where FDR1.Ahne=FDR2.Name or FDR1.Ahne is null and FDR2.Ahne is null
),
TDR as (
	select distinct SDR1.*, SDR2.Ahne as Ururahne from SDR as SDR1, SDR as SDR2 where SDR1.Urahne=SDR2.Name or SDR1.Urahne is null and SDR2.Ahne is null
)
select * from TDR order by Ururahne desc, Urahne desc, Ahne desc, Name
--b
with FDR as (
	select Name, Vater as Ahne,
		case
			when Vater is not null then 1
			else 0
		end as deg
	from Ahnen
	union
	select Name, Mutter as Ahne,
		case
			when Mutter is not null then 1
			else 0
		end as deg
	from Ahnen
), SDR as (
	select * from FDR
	union
	select FDR1.Name,FDR2.Ahne, 
		case
			when FDR2.Ahne is not null then FDR1.deg+1
			else FDR1.deg
		end as deg
	from FDR as FDR1, FDR as FDR2 where FDR1.Ahne=FDR2.Name
), TDR as (
	select * from SDR
	union
	select SDR.Name,FDR.Ahne,
		case
			when FDR.Ahne is not null then SDR.deg+1
			else SDR.deg
		end as deg
	from SDR,FDR where SDR.Ahne=FDR.Name
) select distinct * from TDR where Ahne is not null or deg=0 order by deg;
--c
with FDR as (
	select Name, Vater as Ahne from Ahnen
	union
	select Name, Mutter as Ahne from Ahnen
), recursion as (
	select * from FDR
	union all
	select FDR.Name,recursion.Ahne from FDR,recursion where FDR.Ahne=recursion.Name
) select distinct * from recursion order by Name
--d
with FDR as (
	select Name, Vater as Ahne,
		case
			when Vater is not null then 1
			else 0
		end as deg
	from Ahnen
	union
	select Name, Mutter as Ahne,
		case
			when Mutter is not null then 1
			else 0
		end as deg
	from Ahnen
), recursion as (
	select * from FDR
	union all
	select recursion.Name,FDR.Ahne,
		case
			when FDR.Ahne is not null then recursion.deg+1
			else recursion.deg
		end as deg
	from recursion,FDR
	where recursion.Ahne=FDR.Name
) select distinct * from recursion where Ahne is not null or deg=0 order by deg

drop table Student_in_Veranstaltung;
drop table Veranstaltungen;
drop table Dozenten;
drop table Studenten;
drop table Ahnen;

