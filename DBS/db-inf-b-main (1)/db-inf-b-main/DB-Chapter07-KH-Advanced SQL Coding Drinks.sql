/*
drop table verkauf;
drop table rezepte;
drop table zutaten;
drop table drinks;

*/


create table zutaten(
	name varchar(200),
	hersteller varchar(200),
	alk decimal(3,0) default 100.0,
	ean_code char(13),
	preis decimal(5,2),
	gebinde decimal(4,0),
	primary key (name,hersteller),
	CONSTRAINT alk_macht_sinn CHECK (alk<=100 and alk>=0)
);

create table drinks(
	name varchar(200),
	typ varchar(200) null,
	preis decimal(4,2),
	primary key (name)
);

create table rezepte(
	name varchar(200) not null,
	hersteller varchar(200) not null,
	menge decimal(3,0),
	drink varchar(200),
	/*	Wenn wir möchten, dass sich bei Änderung der Primary Keys 
		auch die Foreign Keys ändern: */
		foreign key (drink) references drinks(name) on update cascade on delete cascade,
		foreign key (name,hersteller) references zutaten(name,hersteller) on update cascade on delete cascade
);

create table verkauf(
	datum date,
	drink varchar(200) references Drinks(name)
);

insert into zutaten (name, hersteller, alk, ean_code,preis,gebinde) values 
	('Vodka','Jelzin',30.0,'453rfedafsteg',12.00,1000), 
	('Vodka2','Jelzin',30.9,'3637262728292',11.00,1000), 
	('Orangensaft','Albi',0,'3637262428292',2.99,1000), 
	('Das rote Zeug','Zuckerfabrik 1A',0,'3637262428292',14.00,1000), 
	('Brauner Rum','Botucal',32,null,22.00,700),
	('Weißer Rum','Bacardi',36,null,18,800),
	('Tonic Water','Harrys',0,null,8,750),
	('Gin','Bombay',34.2,null,16,900),
	('Maracujasaft','Albi',0,null,3.99, 1000),
	('Kokussahne','Thaipeh',0,null,12,350),
	('Triple Sec','Zuckerfabrik 1A',12,null,14,650),
	('Cocktailkirsche','Zuckerfabrik 1A',0,null,12,1000),
	('Tequilla','Sierra',32,null,8.99,750),
	('Das grüne Zeug','Zuckerfabrik 1A',1,'3637262418292',12,1000);

insert into drinks (name, typ, preis) values 
	('Vodka Orange','Longrink',8.00), 
	('Zombie','Longrink',12.00), 
	('Gin Tonic','Longrink',8.00), 
	('Hurricane','Longrink',8.00), 
	('Tequilla Sunrise','Longrink',6.99),
	('Vanilla Coke','Softdrink', 1.99),
	('KotzCola','Longdrink',99.99);

insert into rezepte (name, hersteller, menge, drink) values 
	('Vodka','Jelzin',20,'Vodka Orange'), 
	('Orangensaft','Albi',130,'Vodka Orange'), 
	('Tequilla','Sierra',30,'Tequilla Sunrise'),
	('Das rote Zeug','Zuckerfabrik 1A',10,'Tequilla Sunrise'),
	('Orangensaft','Albi',170,'Tequilla Sunrise'),
	('Brauner Rum','Botucal',20,'Zombie'),
	('Weißer Rum','Bacardi',20,'Zombie'),
	('Maracujasaft','Albi',80,'Zombie'),
	('Orangensaft','Albi',80,'Zombie'),
	('Gin','Bombay',30,'Gin Tonic'),
	('Tonic Water','Harrys',170,'Gin Tonic'),
	('Triple Sec','Zuckerfabrik 1A',20,'Hurricane'),
	('Das grüne Zeug','Zuckerfabrik 1A',5,'Hurricane'),
	('Das rote Zeug','Zuckerfabrik 1A',5,'Hurricane'),
	('Weißer Rum','Bacardi',20,'Hurricane'),
	('Orangensaft','Albi',120,'Hurricane'),
	('Orangensaft','Albi',200,'Vanilla Coke'),
	('Vodka','Jelzin',10,'KotzCola'),
	('Vodka2','Jelzin',10,'KotzCola'),
	('Orangensaft','Albi',10,'KotzCola'),
	('Das rote Zeug','Zuckerfabrik 1A',10,'KotzCola'),
	('Brauner Rum','Botucal',10,'KotzCola'),
	('Weißer Rum','Bacardi',10,'KotzCola'),
	('Tonic Water','Harrys',10,'KotzCola'),
	('Gin','Bombay',10,'KotzCola'),
	('Maracujasaft','Albi',10,'KotzCola'),
	('Kokussahne','Thaipeh',10,'KotzCola'),
	('Triple Sec','Zuckerfabrik 1A',10,'KotzCola'),
	('Cocktailkirsche','Zuckerfabrik 1A',10,'KotzCola'),
	('Tequilla','Sierra',10,'KotzCola'),
	('Das grüne Zeug','Zuckerfabrik 1A',10,'KotzCola');



insert into verkauf (datum, drink) values 
	('2020-10-10','Hurricane'),
	('2020-10-10','Vanilla Coke'),
	('2020-10-11','Hurricane'),
	('2020-10-12','Gin Tonic'),
	('2020-10-14','Vanilla Coke'),
	('2020-10-18','Zombie'),
	('2020-11-10','Hurricane'),
	('2020-12-10','Hurricane'),
	('2020-10-09','Zombie'),
	('2020-11-11','Vanilla Coke'),
	('2020-11-11','Hurricane'),
	('2020-11-11','Hurricane'),
	('2020-12-10','Zombie');

-- Liveübung vom 01.12.2020

-- Aggregatfunktionen
-- Die Attribute in der Select Liste sind entweder in einer Aggegatfunktion, oder im Group By

-- Was würde es kosten, alle Drinks von der Karte zu kaufen?
select sum(preis) from drinks

-- Welche Menge ergibt sich pro Drink aus den Zutaten (für Drinks >= 200ml)
select drink, sum(menge) from rezepte group by drink having sum(menge) >=200

-- Welche Menge jeder Zutat (Hersteller egal) wird benötigt, um jeden Drink einmal zu mixen? 
select name, sum(menge) from rezepte group by name

-- Was ist die höchste Menge der Zutat Orangensaft, die von einem Drink verbraucht wird?
select max(menge) from rezepte where name like 'Orangensaft'

-- Welcher Drink steckt hinter der höchsten Menge an Orangensaft?
select * from rezepte where name like 'Orangensaft' and menge = (select max(menge) from rezepte where name like 'Orangensaft')

-- Was ist die höchste Menge der Zutat Orangensaft, die von einem Drink verbraucht wird und wie heißt dieser Drink?
select	drink, groesste_mengen.groesste_menge 
from	(
			select  max(groesse) as groesste_menge
			from (
					select drink, sum(menge) as groesse 
					from rezepte group by drink
				 ) as mengen
		) as groesste_mengen, rezepte
group by drink, groesste_mengen.groesste_menge
having sum(rezepte.menge) = groesste_mengen.groesste_menge

-- Alkoholfreie Drinks
select r.drink, sum(z.alk)
from rezepte as r join zutaten as z on (r.hersteller=z.hersteller and r.name=z.name)
group by r.drink
having sum(z.alk)=0

-- Alle Drinks die im Zeitraum zwischen dem 10. Oktober 2020 und dem 01.November 2020 verkuaft wurden
select drinks.name, count(*) 
from drinks left join verkauf on (drinks.name=verkauf.drink)
where datum between '2020-10-10' and '2020-11-01' 
group by drinks.name

-- Nur die verkauften Drinks die alkoholfrei sind.
select drinks.name, count(*) 
from drinks left join verkauf on (drinks.name=verkauf.drink)
where datum between '2020-10-10' and '2020-11-01' and 
drinks.name in (
	select r.drink
	from rezepte as r join zutaten as z on (r.hersteller=z.hersteller and r.name=z.name)
	group by r.drink
	having sum(z.alk)=0
	)
group by drinks.name

-- Outer Joins
-- Welche Zutaten gibt es und in welchen Rezepten werden sie verwendet?
select	* 
from	zutaten as z 
		left join rezepte as r on (z.name=r.name and r.hersteller=z.hersteller)
where	r.name is null and r.hersteller is null and r.drink is null

-- Welche Zutaten gibt es, inwelchen Rezepten werden sie verwendet und welchen Rezepten fehlt eine Zutat?
select	* 
from	zutaten as z full 
		outer join rezepte as r on (z.name=r.name and r.hersteller=z.hersteller)

-- Top K (vier kleinsten Matrikelnummern, sie benötigen das Skript aus den vergangene Übungen zu Studenten)
select		s1.Matrikel, count(*)
from		Studenten as s1, 
			Studenten as s2
where		s1.Matrikel>=s2.Matrikel
group by	s1.Matrikel
having		count(*) <=4

-- gleich zu
select top(4) * from Studenten order by Matrikel 

-- Benannten Anfragen
with meine_tolle_tabelle 

as (
	select top(4) * from Studenten order by Matrikel 
	)

select * from meine_tolle_tabelle

-- Beispiel Division
-- Alle Drinks, die alle Zutaten enthalten
select name from drinks

except

-- Die Drinks die nicht alle Zutaten haben.
select d.drink from 
(
-- Alle möglichen Zutatenkombinationen
select drinks.name as 'drink', zutaten.name,zutaten.hersteller from drinks,zutaten -- alle möglichen Kombinationen von drinks und Zutaten
except -- ich ziehe ab..
select drink as drink, name, hersteller from rezepte) as d -- die tatsächlichen Kombinationen von Drinks und Zutaten
-- bleibt übrig: alle drinks, die die Eigenschaften nicht erfüllen


-- alles was drin ist
Select 
	drinks.name as Drink,
	drinks.preis as Preis,
	zutaten.name as Zutat,
	rezepte.menge as Menge,
	zutaten.alk as Alkoholgehalt,
	zutaten.preis as 'Preis pro Gebinde',
	zutaten.gebinde as Gebindegröße
from 
	drinks 
	inner join rezepte on rezepte.drink=drinks.name 
	inner join zutaten on zutaten.hersteller=rezepte.hersteller and zutaten.name = rezepte.name
order by 
	zutaten.name;

-- Anzahl der Zutaten die verwendet werden
Select 
	count(distinct rezepte.Name) as 'Verwendete Zutaten'
from 
	rezepte

-- Anzahl der Zutaten die pro drink verwendet werden
Select 
	rezepte.drink,
	count(*) as 'Anzahl Zutaten'
from 
	rezepte
group by drink
having count(*) > 2
order by count(*) desc

-- jetzt mal die Größe der Drinks
Select 
	drinks.name as Drink,
	sum(rezepte.menge) as Inhalt
from 
	drinks 
	join rezepte on rezepte.drink=drinks.name 
	join zutaten on zutaten.hersteller=rezepte.hersteller and zutaten.name = rezepte.name
group by drinks.name;

-- wieviel von den zutaten steckt durchschnittlich in den Drinks?
Select 
	zutaten.name as Zutat,
	avg(rezepte.menge) as 'Durchschnittliche Menge'
from 
	drinks 
	join rezepte on rezepte.drink=drinks.name 
	join zutaten on zutaten.hersteller=rezepte.hersteller and zutaten.name = rezepte.name
group by zutaten.name;

-- höchster Alkoholgehalt
select 
	zutaten.name
from 
	zutaten
where alk=(
	select 
		max(zutaten.alk)
	from zutaten)

-- Alkoholgehalt der Cocktails und bester Deal
select
	drinks.name,
	drinks.preis,
	(100/sum(rezepte.menge))*sum(rezepte.menge*(zutaten.alk/100)) as Alkoholgehalt,
	sum(rezepte.menge*(zutaten.alk/100))/drinks.preis as 'ml Alk pro Euro',
	sum(rezepte.menge*(zutaten.preis/zutaten.gebinde)) as Materialkosten,
	drinks.preis-sum(rezepte.menge*(zutaten.preis/zutaten.gebinde)) as Deckungsbeitrag,
	((drinks.preis-sum(rezepte.menge*(zutaten.preis/zutaten.gebinde)))/drinks.preis) as Grenzdeckungsbeitrag
from 
	drinks 
	join rezepte on rezepte.drink=drinks.name 
	join zutaten on zutaten.hersteller=rezepte.hersteller and zutaten.name = rezepte.name
group by drinks.name, drinks.preis
order by sum(rezepte.menge*(zutaten.alk/100))/drinks.preis DESC;


-- Die besten drei Cocktails mit dem Top-K Pattern 
select
	drinks.name,
	drinks.preis,
	(100/sum(rezepte.menge))*sum(rezepte.menge*(zutaten.alk/100)) as Alkoholgehalt,
	sum(rezepte.menge*(zutaten.alk/100))/drinks.preis as 'ml Alk pro Euro',
	(	select count(*) as anz from 
		(	select d2.name as anz
			from drinks as d2
				join rezepte as r2 on r2.drink=d2.name 
				join zutaten as z2 on z2.hersteller=r2.hersteller and z2.name = r2.name
			group by d2.name, d2.preis
			having sum(r2.menge*(z2.alk/100))/d2.preis >= sum(rezepte.menge*(zutaten.alk/100))/drinks.preis
		) as Rangfunktion 
	) as 'Rang'
from 
	drinks 
	join rezepte on rezepte.drink=drinks.name 
	join zutaten on zutaten.hersteller=rezepte.hersteller and zutaten.name = rezepte.name
group by drinks.name, drinks.preis
having 
	(	select count(*) as anz from 
		(	select d2.name as anz
			from drinks as d2
				join rezepte as r2 on r2.drink=d2.name 
				join zutaten as z2 on z2.hersteller=r2.hersteller and z2.name = r2.name
			group by d2.name, d2.preis
			having sum(r2.menge*(z2.alk/100))/d2.preis >= sum(rezepte.menge*(zutaten.alk/100))/drinks.preis
		) as Rangfunktion 
	)<=3
order by sum(rezepte.menge*(zutaten.alk/100))/drinks.preis DESC;


-- Die besten drei Cocktails mit dem Top-K Ausdruck
select top(3)
	drinks.name,
	drinks.preis,
	(100/sum(rezepte.menge))*sum(rezepte.menge*(zutaten.alk/100)) as Alkoholgehalt,
	sum(rezepte.menge*(zutaten.alk/100))/drinks.preis as 'ml Alk pro Euro'
from 
	drinks 
	join rezepte on rezepte.drink=drinks.name 
	join zutaten on zutaten.hersteller=rezepte.hersteller and zutaten.name = rezepte.name
group by drinks.name, drinks.preis
order by sum(rezepte.menge*(zutaten.alk/100))/drinks.preis DESC;



