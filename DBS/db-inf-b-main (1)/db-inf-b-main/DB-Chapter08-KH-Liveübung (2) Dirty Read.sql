/*
drop table konto;
drop table daten;

create table konto(
kontonummer int primary key,
betrag int
);
insert into konto (kontonummer,betrag) values (1,100);
insert into konto (kontonummer,betrag) values (2,0);

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
--READ UNCOMMITTED	-- Auch geblockte können gelesen werden, keine Lesesperren angefordert (alle Probleme)
--READ COMMITTED	-- Geblockte können nicht gelesen werden, keine Lesesperren angefordert (kein Dirty Read)
--REPEATABLE READ	-- Nur freigegebene können gelesen werden, Lesesperren angefordert (kein Dirty oder Nonrepeatable Read, kein Lost Update) 
SERIALIZABLE		-- REPEATABLE READ + es können keine neuen Schlüssel in die verwendeten Schlüsselbereiche eingefügt werden. (plus kein Phantom Read)
;  

BEGIN TRANSACTION;
update konto set betrag=10000 where kontonummer=1;

---------- Eine sinnlose Pause ---------------
select * from daten d1, daten d2, daten d3;
----------------------------------------------
-- Wenn jetzt zwischendurch jemand für dieses Konto einen Bonus bekommt
-- aber die Transaktion garnicht durch geht, hat er zu viel Bonus bekommen
/*
SET TRANSACTION ISOLATION LEVEL 
READ UNCOMMITTED	
BEGIN TRANSACTION;
declare @bonus int;
set @bonus=(select betrag from konto where kontonummer=1)*0.2;
update konto set betrag=@bonus where kontonummer=2;
select * from konto
*/

rollback transaction;
select * from konto;









