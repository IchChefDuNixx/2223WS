								-- ### Spickzettel PSM ###

drop function f;				-- ### Funktionen ###
create function f (@p1 int, @p2 int)-- Parameter 
returns int as						-- Returntype	
begin
	return 1;
end;
select f(1,2);						-- Aufruf der Funktion und Ausgabe 

drop procedure p;				-- ### Prozeduren ###
create procedure p @p1 int,	@p2 int,-- Eingabeparamter 
@p3 int output, @p4 int output as	-- Augabevariablen
begin
	set @p3=1; set @p4=2;
end;
declare @getp3 int; declare @getp4 int;
execute	p 1, 2,						-- Aufruf der Prozedur
		@p3=@getp3 output,			-- Zuweisen der Ausgabeparamter zu lokalen Varaiblen
		@p4=@getp4 output; 
select  @getp3,@getp4;				-- Ausgabe des Ergebnisses

								-- ### Variablen ###
declare @test int;					-- Deklaration
set @test=10;						-- Zuweisung direkt
select @test=count(*) from Kunden;	-- Zuweisung mit Select, bei mehreren der letze Wert des Selects
select @test;						-- Ausgabe
print @test;						-- Ausgabe auf der Konsole

								-- ### Kontrollstrukturen ###
if (@test <> 0)						-- if-then-else
	begin
		set @test=2;
	end 
else 
	begin 
		set @test=3;
	end;
set @test =							-- Case Block
	case 
		when @test=1 then 2
		when @test=3 then 4
		else 5
	end;

declare c cursor for			-- ### Cursor ### 
	select name, id 
	from kunde;
open c;								-- Cursor öffnen
declare @einName nvarchar(30);		-- Variablen für eine Cursorzeile anlegen
declare @eineId int;
fetch next from c					-- erste Zeile des Cursors aufrufen ..
into @einName, @eineId				-- .. Reihenfolge wie im Select vom Cursor
while @@FETCH_STATUS = 0			-- while Schleife bis cursor durchgelaufen ist
begin
	fetch next from c				-- in der Schleife typischerweise ein fetch next 
	into @einName, @eineId
end;
close c;							-- Cursor schließen
deallocate c;						-- Resourcen freigeben

	

