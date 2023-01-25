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
*/

SET TRANSACTION ISOLATION LEVEL 
--READ UNCOMMITTED	-- Auch geblockte k�nnen gelesen werden, keine Lesesperren angefordert (alle Probleme)
--READ COMMITTED	-- Geblockte k�nnen nicht gelesen werden, keine Lesesperren angefordert (kein Dirty Read)
REPEATABLE READ	-- Nur freigegebene k�nnen gelesen werden, Lesesperren angefordert (kein Dirty oder Nonrepeatable Read, kein Lost Update) 
--SERIALIZABLE		-- REPEATABLE READ + es k�nnen keine neuen Schl�ssel in die verwendeten Schl�sselbereiche eingef�gt werden. (plus kein Phantom Read)
;  

BEGIN TRANSACTION;
select count(*) from konto;

---------- Eine sinnlose Pause ---------------
select * from daten d1, daten d2, daten d3;
----------------------------------------------
-- Jetzt gibt es zwischendurch ein neues Konto (Phantomkonto)
-- insert into konto (kontonummer,betrag) values (2,100);
select count(*) from konto;

commit transaction;








