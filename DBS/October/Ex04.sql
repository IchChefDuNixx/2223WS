create table Students (
Name varchar(30),
Matriculation decimal(4,0),

primary key (Matriculation),
Check (Matriculation >= 0)
)


create table Lecturers (
Name varchar(30),
Office varchar(30) not null,
Tel varchar(30),

primary key (Name)
)


create table Events (
Name varchar(30),
Semester char(4),
Room varchar(8),
Lecturer varchar(30),

primary key (Name,Semester),
foreign key (Lecturer) references Lecturers(Name)
)


create table Student_in_Events (
Student decimal(4,0),
Event varchar(30),
Semester char(4),
Grade float,

foreign key (Student) references Students(Matriculation),
foreign key (Event,Semester) references Events(Name,Semester),
constraint grade_interval check (Grade >= 1.0 and Grade <= 5.0),
constraint volleyball_grade_exception check (Event = 'Beach Volleyball' and Grade <= 4.0 or Event != 'Beach Volleyball'),
constraint student_registration_limit unique(Student,Event,Semester)
)


insert into Students(Name, Matriculation) values
('Eva',3333),
('Luise',3334),
('Daniel',3335),
('Dominik',3336);
--('',),


insert into Lecturers(Name,Office,Tel) values
('Klaus','C201','123'),
('Maria','D120',null);
--('','',''),


insert into Events(Name,Semester,Room,Lecturer) values
('Dance Gymnastics','ws17','D111','Klaus'),
('Dance Gymnastics','ss18','D111','Klaus'),
('Sack Race','ws18',null,'Klaus'),
('Hang-Gliding','ss17','Beach','Maria'),
('Hang-Gliding','ss18','Beach','Maria'),
('Beach Volleyball','ss18','Beach','Maria'),
('Beach Volleyball','ss17','Beach',null);
--('','','',''),


insert into Student_in_Events(Student,Event,Semester,Grade) values
(3333,'Beach Volleyball','ss18',1.0),
(3334,'Beach Volleyball','ss18',4.0),
(3335,'Beach Volleyball','ss18',3.3),
(3333,'Hang-Gliding','ss17',5.0),
(3336,'Hang-Gliding','ss17',2.6),
(3334,'Dance Gymnastics','ws17',1.0),
(3335,'Dance Gymnastics','ws17',5.0),
(3334,'Beach Volleyball','ss17',3.0),
(3335,'Beach Volleyball','ss17',4.0);
--(,'','',),

update Lecturers set Office = 'D22' where Name = 'Maria'
delete from Student_in_Events where Student = 3333

alter table Students add Date_of_birth date
update Students set Date_of_birth = cast('1990-03-01' as date) where Matriculation = 3333
update Students set Date_of_birth = cast('1990-04-01' as date) where Matriculation = 3334
update Students set Date_of_birth = cast('1990-05-01' as date) where Matriculation = 3335
update Students set Date_of_birth = cast('1990-06-01' as date) where Matriculation = 3336

update Students set Date_of_birth = cast('1111-11-11' as date) where Date_of_birth is null
alter table Students alter column Date_of_birth date not null

select * from Students
select * from Lecturers
select * from Events
select * from Student_in_Events

-- # 4.1
select * from Lecturers where Office like 'D%' --a

select Student from Student_in_Events --b
except
select Student from Student_in_Events where Semester like 'ss18' and Grade > 0

select Name, --c
	case
		when datediff(year, Date_of_birth, CURRENT_TIMESTAMP) between 20 and 40 then datediff(year, Date_of_birth, CURRENT_TIMESTAMP)
		else 0
	end as age
from Students

-- # 4.2
select distinct Student, Event, Room from Student_in_Events, Events --a
where Student_in_Events.Semester = Events.Semester and
Student_in_Events.Event = Events.Name and
Student_in_Events.Semester like 'ss18'

select Students.Name, --b
	case
		when datediff(day, Students2.Date_of_birth, Students.Date_of_birth) > 0 then Students2.Name
	end as is_older_than
from Students, Students as Students2 where datediff(day, Students2.Date_of_birth, Students.Date_of_birth) > 0
order by Students.Date_of_birth

select --c
	case
		when Semester = 'ss17' and Grade <= 4 then Students.Name + ' took part in the ' + Student_in_Events.Event + ' event in the summer semester 2017 and obtained the grade ' + cast(Student_in_Events.Grade as varchar) + ', Congratulations!'
		when Semester = 'ws17' and Grade <= 4 then Students.Name + ' took part in the ' + Student_in_Events.Event + ' event in the winter semester 2017 and obtained the grade ' + cast(Student_in_Events.Grade as varchar) + ', Congratulations!'
		when Semester = 'ss18' and Grade <= 4 then Students.Name + ' took part in the ' + Student_in_Events.Event + ' event in the summer semester 2018 and obtained the grade ' + cast(Student_in_Events.Grade as varchar) + ', Congratulations!'
		when Semester = 'ss17' and Grade > 4 then Students.Name + ' took part in the ' + Student_in_Events.Event + ' event in the summer semester 2017 and obtained the grade ' + cast(Student_in_Events.Grade as varchar) + ', failed :('
		when Semester = 'ws17' and Grade > 4 then Students.Name + ' took part in the ' + Student_in_Events.Event + ' event in the winter semester 2017 and obtained the grade ' + cast(Student_in_Events.Grade as varchar) + ', failed :('
		when Semester = 'ss18' and Grade > 4 then Students.Name + ' took part in the ' + Student_in_Events.Event + ' event in the summer semester 2018 and obtained the grade ' + cast(Student_in_Events.Grade as varchar) + ', failed :('
	end as Text
from Students,Student_in_Events where Students.Matriculation = Student_in_Events.Student and Semester in ('ss17', 'ws17', 'ss18')
order by Matriculation

-- # 4.3 a,b
select Events.Name, Events.Lecturer, min(Student_in_Events.Grade) as topGrade, max(Student_in_Events.Grade) as worstGrade from Events, Student_in_Events 
where Events.Name = Student_in_Events.Event and Events.Semester = Student_in_Events.Semester and Lecturer is not null
group by Events.Name, Events.Lecturer

select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS

drop table Student_in_Events,Events,Lecturers,Students