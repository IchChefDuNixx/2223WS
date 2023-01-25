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
	('Dominik',3336,'1990-12-01'),
	('Geburtstagskind',3337,'2018-11-01');

insert into Student_in_Veranstaltung (Student, Veranstaltung, Semester, Note) values 
	(3333,'Beachvolleyball','ss18',1.0),
	(3334,'Beachvolleyball','ss18',2.2),
	(3335,'Beachvolleyball','ss18',2.4),
	(3333,'Drachenfliegen','ss17',4.0),
	(3336,'Drachenfliegen','ss17',4.0),
	(3334,'Tanzgymnastik','ws17',5),
	(3335,'Tanzgymnastik','ws17',2.2),
	(3334,'Beachvolleyball','ss17',1.2),
	(3335,'Beachvolleyball','ss17',1.3);
	
-- Aufgabe 1a	
select
	name
from
	dozenten
where
	Buero like 'D%';

-- Aufgabe 1b
select distinct 
	Student 
from 
	Student_in_Veranstaltung where Semester='ss18' and Note is null ;

-- Aufgabe 1c
-- Leider sieht das leicht aus, ist aber falsch, da in TSQL die Funktion datediff nur den Jahresteil 
-- eines Datums subtrahiert. Das bedeutet select datediff(year,'2000-12-31','2001-01-01') ist 1, was bei Gebutrtstagen ja falsch ist.
-- bei MySQL hingegen ist select timestampdiff(year,'2019-01-28','2020-01-02') = 0, da ist das also besser implementiert
select
	Name as n , 
	datediff (year , Geburtstag ,CURRENT_TIMESTAMP) as 'Alter'
from
	Studenten
where
	datediff (year , Geburtstag ,CURRENT_TIMESTAMP) between 20 and 40;

-- daher sieht die Anfrage etwas komplizierter aus.
select
	Name as n , 
	CASE 
		WHEN	(MONTH(Geburtstag) > MONTH(GETDATE())) OR 
				(MONTH(Geburtstag) = MONTH(GETDATE()) AND DAY(Geburtstag) > DAY(GETDATE())) 
		THEN	datediff (year , Geburtstag ,CURRENT_TIMESTAMP)-1 
		ELSE	datediff (year , Geburtstag ,CURRENT_TIMESTAMP)
	END as 'Alter'
from
	Studenten
where
	CASE 
		WHEN	(MONTH(Geburtstag) > MONTH(GETDATE())) OR 
				(MONTH(Geburtstag) = MONTH(GETDATE()) AND DAY(Geburtstag) > DAY(GETDATE())) 
		THEN	datediff (year , Geburtstag ,CURRENT_TIMESTAMP)-1 
		ELSE	datediff (year , Geburtstag ,CURRENT_TIMESTAMP)
	END between 20 and 30;	


-- Aufgabe 2a
select
	S.Name as Student , 
	V.Name as Veranstaltung , 
	V.Raum
from
	Studenten as S 
	inner join Student_in_Veranstaltung as SinV on S.Matrikel = SinV.Student 
	inner join Veranstaltungen as V on SinV.Veranstaltung=V.Name and SinV.Semester=V.Semester
where
	V. Semester = 'ss18';

-- Aufgabe 2b
select
	A.Name as Student , 
	B.Name as '.. ist älter als'
from
	Studenten as A, 
	Studenten as B
where
	A.Geburtstag<B. Geburtstag 
order by 
	A. Geburtstag asc

-- Aufgabe 2c
select
	concat (
		S.Name, 
		' hat im ' , 
			case 
				when V. Semester='ss17' then 'Sommersemester 2017' 
				when V. Semester='ws17' then 'Wintersemester 2017' 
				when V. Semester='ss18' then 'Sommersemester 2018' 
			end , 
			' an der Veranstaltung ' , V. Veranstaltung , ' teilgenommen und ' , 
			case 
				when V. Note is null then 'noch keine Note erhalten ' 
				when V. Note<=4 then concat ( 'die Note ' , V. Note , ' erhalten . Herzlichen Glückwunsch! ') 
				when V. Note>4 then ' leider nicht bestanden . ' 
			end) as Text
from
	Studenten as S 
	inner join Student_in_Veranstaltung as V on S. Matrikel=V. Student
where
	V. Semester in ( 'ws17' , 'ss17' , 'ss18' );

-- Aufgabe 3a
select distinct 
	D.Name, 
	V.Name, 
	concat ( 'Beste Note : ' , SinV . Note) 
from 
	Dozenten as D 
	inner join Veranstaltungen as V on V. Dozent=D.Name 
	inner join Student_in_Veranstaltung as SinV on SinV.Veranstaltung = V.Name and SinV.Semester=V.Semester 
where 
	SinV.Note is not null 
	and SinV.Note <= all ( 
							select note 
							from Student_in_Veranstaltung as SinV2 
								inner join Veranstaltungen as V2 on SinV2.Veranstaltung=V2.Name and SinV2. Semester=V2.Semester 
								inner join Dozenten as D2 on V2.Dozent=D2.Name 
							where note is not null and V2.Name=V.Name and D2.Name=D.Name
							);

-- Aufgabe 3b
select distinct 
	D.Name, 
	V.Name, 
	concat ( 'Beste Note : ' , SinV . Note) 
from 
	Dozenten as D 
	inner join Veranstaltungen as V on V. Dozent=D.Name 
	inner join Student_in_Veranstaltung as SinV on SinV.Veranstaltung = V.Name and SinV.Semester=V.Semester 
where 
	SinV.Note is not null 
	and SinV.Note <= all ( 
							select note 
							from Student_in_Veranstaltung as SinV2 
								inner join Veranstaltungen as V2 on SinV2.Veranstaltung=V2.Name and SinV2. Semester=V2.Semester 
								inner join Dozenten as D2 on V2.Dozent=D2.Name 
							where note is not null and V2.Name=V.Name and D2.Name=D.Name
							)
union
select distinct 
	D.Name, 
	V.Name, 
	concat ( 'Schlechteste : ' , SinV . Note) 
from 
	Dozenten as D 
	inner join Veranstaltungen as V on V. Dozent=D.Name 
	inner join Student_in_Veranstaltung as SinV on SinV.Veranstaltung = V.Name and SinV.Semester=V.Semester 
where 
	SinV.Note is not null 
	and SinV.Note >= all ( 
							select note 
							from Student_in_Veranstaltung as SinV2 
								inner join Veranstaltungen as V2 on SinV2.Veranstaltung=V2.Name and SinV2. Semester=V2.Semester 
								inner join Dozenten as D2 on V2.Dozent=D2.Name 
							where note is not null and V2.Name=V.Name and D2.Name=D.Name
							);
	
-- Aufgabe 3c
select count(*) as anz, Student, Veranstaltung, Semester from Student_in_Veranstaltung group by Student,Veranstaltung, Semester having count(*)>1;

drop table Student_in_Veranstaltung;
drop table Veranstaltungen;
drop table Dozenten;
drop table Studenten;
