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
	('Dominik',3336,'1990-08-01');

insert into Student_in_Veranstaltung (Student, Veranstaltung, Semester, Note) values 
	(3333,'Beachvolleyball','ss18',1.0),
	(3334,'Beachvolleyball','ss18',2.2),
	(3335,'Beachvolleyball','ss18',2.4),
	(3333,'Drachenfliegen','ss17',4.0),
	(3336,'Drachenfliegen','ss17',4.0),
	(3334,'Tanzgymnastik','ws17',5.0),
	(3335,'Tanzgymnastik','ws17',2.0),
	(3334,'Beachvolleyball','ss17',1.2),
	(3335,'Beachvolleyball','ss17',1.3);

-- Aufgabe 12a Median
drop function median

create function median()
returns decimal(2,1) as
begin
declare @median decimal(2,1) = 0
/*cursor*/
declare c cursor local for select Note from Student_in_Veranstaltung order by note
open c
declare @counter int = 0
while @counter < (select COUNT(*)+1 from Student_in_Veranstaltung)/2
begin
fetch next from c into @median
set @counter = @counter +1
end
deallocate c
return @median
end

select dbo.median()
-- Probe
select * from Student_in_Veranstaltung order by Note
insert into Student_in_Veranstaltung (Student, Semester,Veranstaltung,Note) values (3336, 'ss18', 'Beachvolleyball',1.0)
delete from Student_in_Veranstaltung  where student=3336 and Veranstaltung='Beachvolleyball' and Semester='ss18'

-- Median für eine bestimmte Veranstaltung
drop function median2

create function median2(@eventname varchar(30),@semester char(4))
returns decimal(2,1) as
begin
declare @median decimal(2,1) = 0
declare c cursor local for select Note from Student_in_Veranstaltung where Veranstaltung=@eventname and Semester=@semester order by note desc
open c
declare @counter int = 0
while @counter < (select COUNT(*)+1 from Student_in_Veranstaltung where Veranstaltung=@eventname and Semester=@semester)/2
begin
fetch next from c into @median
set @counter = @counter +1
end
deallocate c
return @median
end

drop procedure p2

create procedure p2(@eventname varchar(30), @semester char(4), @sum float out)
as begin
	declare @med float = dbo.median2(@eventname, @semester)
	declare @curr float = 0
	declare c cursor local for select Note from Student_in_Veranstaltung where Veranstaltung=@eventname and Semester=@semester order by note desc
		open c
		fetch next from c into @curr
		while @@FETCH_STATUS = 0
		begin
			set @sum = @sum + ABS(@curr - @med)
			fetch next from c into @curr
		end
		deallocate c
end

declare @eventname varchar(30) = 'Beachvolleyball'
declare @semester char(4) = 'ss18'
declare @sum float = 0
exec p2 @eventname,@semester,@sum out
print @sum









create function function_name(@var int = 0)
returns varchar as
begin
return 0
end

select dbo.function_name(0)

create procedure proc_name(@var int = 0,@result varchar out)
as
begin
set @result = CAST(@var as varchar)
end

declare @a int = 0
declare @b varchar = ''
exec proc_name @a,@b out

declare c cursor local for select Matrikel from Studenten
declare @curr decimal(4,0)
open c
fetch next from c into @curr
while @@FETCH_STATUS = 0
	begin
	print @curr
	fetch next from c into @curr
	end
deallocate c

select * from Veranstaltungen
select * from Student_in_Veranstaltung
select * from (select Name from Veranstaltungen intersect select Veranstaltung from Student_in_Veranstaltung) as x
