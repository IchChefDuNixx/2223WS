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
	(3334,'Tanzgymnastik','ws17',5),
	(3335,'Tanzgymnastik','ws17',2.0),
	(3334,'Beachvolleyball','ss17',1.2),
	(3335,'Beachvolleyball','ss17',1.3);

-- Aufgabe 1.a Median über alle
drop function median_ueber_alle;
create function median_ueber_alle()
returns decimal (2,1) 
as begin
	declare @AnzahlNoten int;
	select @AnzahlNoten=COUNT(*) from Student_in_Veranstaltung;

	declare @median decimal (2,1) 
	set @median=0;

	declare CursorNoten cursor for select top (ROUND(((@AnzahlNoten/2)+1),1)) Note from Student_in_Veranstaltung order by Note DESC;
	open CursorNoten;

	declare @lastvalue decimal (2,1);
	set @lastvalue=0;
			
	declare @llastvalue decimal (2,1);
	set @llastvalue=0;

	declare @tmp decimal (2,1);
	set @tmp=0;

	fetch next from CursorNoten into @lastvalue;
	while @@FETCH_STATUS = 0  
	begin
		set @tmp=@lastvalue;
		fetch next from CursorNoten into @lastvalue;
		if @@FETCH_STATUS = 0 set @llastvalue=@tmp;
	end;

	close CursorNoten;
	deallocate CursorNoten;


	if (@AnzahlNoten % 2) = 0 
	begin
		set @median = (@lastvalue+@llastvalue)/2
	end
	else
	begin
		set @median=@lastvalue;
	end;

	return @median;
end;

-- Probe
select * from Student_in_Veranstaltung order by Note
select dbo.median_ueber_alle()

insert into Student_in_Veranstaltung (Student, Semester,Veranstaltung,Note) values (3336, 'ss18', 'Beachvolleyball',1.0)
 

-- Median für eine bestimmte Veranstaltung
drop function median_fuer_veranstaltung;
create function median_fuer_veranstaltung(@name varchar(30),@semester varchar(4))
returns decimal (2,1) 
as begin
	declare @AnzahlNoten int;
	select @AnzahlNoten=COUNT(*) from Student_in_Veranstaltung where Semester=@semester and Veranstaltung=@name;
	--print @AnzahlNoten;

	declare @median decimal (2,1) 
	set @median=0;

	declare CursorNoten cursor for 
		select top (ROUND(((@AnzahlNoten/2)+1),1)) Note 
		from Student_in_Veranstaltung 
		where Semester=@semester and Veranstaltung=@name
		order by Note DESC;
	open CursorNoten;

	declare @lastvalue decimal (2,1);
	set @lastvalue=0;	
		
	declare @llastvalue decimal (2,1);
	set @llastvalue=0;

	declare @tmp decimal (2,1);
	set @tmp=0;

	fetch next from CursorNoten into @lastvalue;
	while @@FETCH_STATUS = 0  
	begin
		--print @lastvalue;
		set @tmp=@lastvalue;
		fetch next from CursorNoten into @lastvalue;
		if @@FETCH_STATUS = 0 set @llastvalue=@tmp;
	end;

	close CursorNoten;
	deallocate CursorNoten;

	if (@AnzahlNoten % 2) = 0 
	begin
		set @median = (@lastvalue+@llastvalue)/2
	end
	else
	begin
		set @median=@lastvalue;
	end;
	return @median;
end;


select	S.Name, 
		sinv.Note, 
		dbo.median_fuer_veranstaltung(sinv.Veranstaltung,sinv.Semester) as Median, 
		dbo.median_fuer_veranstaltung(sinv.Veranstaltung,sinv.Semester)-sinv.Note as Abweichung,
		sinv.Veranstaltung, 
		sinv.Semester, 
		d.Name 
from	Student_in_Veranstaltung as sinv 
		inner join Studenten as s on (s.Matrikel=sinv.Student) 
		inner join Veranstaltungen as v on (v.Semester=sinv.Semester and v.Name=sinv.Veranstaltung) 
		inner join Dozenten as d on (d.Name=v.Dozent)
order by sinv.Veranstaltung, sinv.Semester, sinv.Note




-- Zusatzaufgaben


-- Wir wollen eine zufällige Matrikelnummer aus der Tabelle Studenten ermitteln,
-- um dann später ein zufälliges Tupel aus der Tabelle Studenten zu erhalten


-- leider können wir in TSQl keine RAND Funktion direkt in einer Funktion benutzen, also
-- speichern wir sie in einem View 
-- https://stackoverflow.com/questions/31468836/use-rand-in-user-defined-function

CREATE VIEW vw_getRANDValue
AS
SELECT RAND() AS Value

select * from vw_getRANDValue


create function getRandomStudent()  
returns int as							
begin

	declare @return int;
	declare @position int;
	declare @anzStud int;
	
	-- Wir suchen uns die passende Position
	select @anzStud=count(*) from Studenten;
	SELECT @position=cast(((select * from dbo.vw_getRANDValue)*(@anzStud)) as int);

	-- und gehen an diese Stelle mittels Cursor
	declare c cursor for select matrikel from Studenten 
	open c;								
	fetch next from c into @return;		
	declare @i int = 0;
	while @@FETCH_STATUS = 0 and @i != @position			
	begin
		fetch next from c				
		into @return;
		set @i = @i +1;
	end;
	close c;							
	deallocate c;						
	return @return
end;

select * from Studenten where Matrikel=dbo.getRandomStudent()

-- Alternativ ohne Cursor
select top(1) * from (
	select top(cast(((RAND()*(select count(*) from Studenten)+1)) as int)) * 
	from Studenten 
	order by Matrikel ASC
) as x order by Matrikel DESC

-- Median ohne PSM
select avg(y.Note) as median from (
	select top( cast(cast(((select COUNT(*) from Student_in_Veranstaltung)/2) as int) + 1 - (select ROUND(((cast((select COUNT(*) from Student_in_Veranstaltung) as float)/2)), 0)-1)
			as int))
 x.Note from (
			select	top (ROUND((((select COUNT(*) from Student_in_Veranstaltung)/2)+1), 1)) 
					Note 
			from	Student_in_Veranstaltung 
			order by Note DESC
		) as x 
order by Note ASC) as y 

-- 






