create table Students (
SName varchar(30),
SMatriculation decimal(4,0) primary key,
SBirthday date
)

create table Lecturers (
LName varchar(30) primary key,
LOffice varchar(5),
LPhone int
)

create table Events (
EName varchar(30),
ESemester varchar(4),
ERoom varchar(5),
ELecturer varchar(30) references Lecturers(LName),
primary key (EName, ESemester)
)

insert into Students (SName, SMatriculation, SBirthday) values
('Heintje', 2143, '1900-01-01'),
('Eva', 3333, '1900-01-01'),
('Luise', 3334, '1990-03-01'),
('Daniel', 3335, '1990-04-02'),
('Daniel', 3336, '1990-10-10'),
('Heintje', 3337, '1990-10-10')

insert into Lecturers (LName, LOffice, LPhone) values
('Klaus', 'C201', 123),
('Maria', 'D22', null),
('Marlene', 'C204', 443),
('Matze', 'E4', null)

insert into Events (EName, ESemester, ERoom, ELecturer) values
('Beachvolleyball', 'ss17', 'Beach', 'Maria'),
('Beachvolleyball', 'ss18', 'Beach', 'Maria'),
('Drachenfliegen', 'ss17', 'Beach', 'Maria'),
('Drachenfliegen', 'ss18', 'Beach', 'Maria'),
('Sackhüpfen', 'ws17', 'null', 'Klaus'),
('Sackhüpfen', 'ws18', 'null', 'Klaus'),
('Tanzgymnastik', 'ss18', 'D111', 'Klaus'),
('Tanzgymnastik', 'ws17', 'D111', 'Klaus')


select * from Students
select * from Lecturers
select * from Events

select * from Students,Lecturers,Events where Lecturers.LName = Events.ELecturer and Lecturers.LName = 'Maria' and Students.SMatriculation between 3333 and 3334


drop table Events, Lecturers, Students
/*
5.1a
dom(Students) = {SName, SMatriculate, SBirthday} > {string, date}
dom(Lecturers) = {LName, LOffice, LPhone} -> {string, int}

b
S = {Students(a1), Lecturers(a2), Events(a3)}

S:
SMatriculate | Integer     PK FK
LName		 | varchar(30) PK FK
EName		 | varchar(30) PK FK
ESemester	 | varchar(4)  PK FK

Students: 
SName		 | varchar(30)
SMatriculate | Integer PK
SBirthday	 | date

Lecturers:
LName | varchar(30) PK
...

Events:
...

c
r(Dozenten) = {DName, DBuero, DTel}

d
t2(ESemester) = ss18, starting at 1

e
del: If LName is deleted, I lose information about the Office
ins: Just storing a phone number doesn't make sense
upd: Inconsistencies can occur in the format for the phone numbers (like country prefixes)

5.2a
SName has duplicates, not unique

b
ELectureres in Events has duplicates, is not a key itself

c
LName in Lecturers is unique and a key

d
r(ESemester, ERoom, ELecturer) = {ESemester, ERoom, ELecturer} != Events, missing EName

e
r(LName, LOffice) = {LName, LOffice, LPhone}
r(LName) = {LName, LOffice, LPhone}
r(LOffice) = {LOffice}
r(LName) is the minimal identifier attribute set of Lecturers

f
LOffice is unique and not null

g
r(r1, r2..., rn) = {r1, r2..., rn} = R -> is superkey and maybe key

h
r(EName, ESemester) = {EName, ESemester, ERoom, ELecturer} = Events

5.3a
SMatriculate -> SName, SBirthday
LName -> LOffice, LPhone
EName, ESemester -> ERoom
SMatriculate, EName, ESemester -> Grade

b
SMatriculate -> SName
SMatriculate -> SBirthday

LName -> LOffice
LName -> LPhone

EName, ESemester -> ERoom

SMatriculate, EName, ESemester -> Grade

c
{SMatriculation}+ = {SMatriculation, SName, SBirthday}
{LName}+ = {LName, LOffice, LPhone}
{EName, ESemester}+ = {EName, ESemester, ERoom}
{SMatriculation, EName, ESemester}+ = {SMatriculation, EName, ESemester, ERoom, Grade}

d {SMatriculation}+ = {SMatriculation, SName, SBirthday}

e {SMatriculation, LName} = {SMatriculation, SName, SBirthday, LName, LOffice, LPhone}

f {SMatriculation, LOffice, ERoom} = {SMatriculation, SName, SBirthday, LOffice, ERoom}

g
Cover(F@b):
split
minimal left side
removed unneccessary FDs

SMatriculate -> SName, SBirthday
LName -> LOffice, LPhone
EName, ESemester -> ERoom
SMatriculate, EName, ESemester -> Grade

h
1.
SMatriculate -> SName
SMatriculate -> SBirthday

LName -> LOffice
LName -> LPhone

EName, ESemester -> ERoom

SMatriculate, EName, ESemester -> Grade

2.
none

3.
not on the right side: SMatriculate, LName, EName, ESemester

4.
{SMatriculate, LName, EName, ESemester}+ = R
(SMatriculate, LName, EName, ESemester) first try -> is the only key
*/