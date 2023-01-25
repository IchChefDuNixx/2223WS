/*

drop table konto;
drop table daten;

create table konto(
kontonummer int primary key,
betrag int
);
insert into konto (kontonummer,betrag) values (1,100);

create table daten(
	i int
);
insert into daten (i) values 
(1),(2),(3),(4),(5),(6),(7),(8),(9),(0),(9),(6),(4),(5),(6),(4),(4),(4),(4),(4),(4),
(1),(2),(3),(4),(5),(6),(7),(8),(9),(0),(9),(6),(4),(5),(6),(4),(4),(4),(4),(4),(4),
(1),(2),(3),(4),(5),(6),(7),(8),(9),(0),(9),(6),(4),(5),(6),(4),(4),(4),(4),(4),(4),
(1),(2),(3),(4),(5),(6),(7),(8),(9),(0),(9),(6),(4),(5),(6),(4),(4),(4),(4),(4),(4),
(1),(2),(3),(4),(5),(6),(7),(8),(9),(0),(9),(6),(4),(5),(6),(4),(4),(4),(4),(4),(4);

select * from konto;

*/

SET TRANSACTION ISOLATION LEVEL 
--READ UNCOMMITTED	-- Auch geblockte k�nnen gelesen werden, keine Lesesperren angefordert (alle Probleme)
READ COMMITTED		-- Geblockte k�nnen nicht gelesen werden, keine Lesesperren angefordert (kein Dirty Read)
--REPEATABLE READ	-- Nur freigegebene k�nnen gelesen werden, Lesesperren angefordert (kein Dirty oder Nonrepeatable Read, kein Lost Update) 
--SERIALIZABLE		-- REPEATABLE READ + es k�nnen keine neuen Schl�ssel in die verwendeten Schl�sselbereiche eingef�gt werden. (plus kein Phantom Read)
;   

BEGIN TRANSACTION;

declare @kontostand int;
set @kontostand=(select betrag from konto where kontonummer=1);

---------- Eine sinnlose Pause ---------------
select * from daten d1, daten d2, daten d3;
----------------------------------------------

-- Wenn ich jetzt zwischendurch im Lotto Gewinne habe ich 
-- Pech gehabt. Lost Update Problem
-- update Konto set betrag=betrag+100000 where kontonummer=1;

set @kontostand=@kontostand+200;
update konto set betrag=@kontostand where kontonummer=1;

select * from konto;

commit transaction;

select * from konto;








