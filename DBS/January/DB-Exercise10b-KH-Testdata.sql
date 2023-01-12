create table tier_frisst(
	tier varchar(30),
	frisst varchar(30)
);


insert into tier_frisst (tier, frisst) values
	('Affe','Banane'),
	('Affe','Apfel'),
	('Affe','Frosch'),
	('Frosch','Fliege'),
	('Fliege','Apfel'),
	('Fliege','Zuckerwasser'),
	('Schakal','Affe'),
	('Wolf','Schakal'),
	--('Fliege','Wolf'),
	('Wolf','Apfel');

-- Aufgabe 1a
with base as (
	select * from tier_frisst
),
recursion as (
	select * from base
	union all
	select recursion.tier,base.frisst 
	from recursion,base
	where recursion.frisst=base.tier
) select distinct * from recursion
-- Aufgabe 1b
insert into tier_frisst (tier, frisst) values
	('Fliege','Wolf');
with base as (
	select tier_frisst.*,cast(frisst as varchar) as Liste from tier_frisst
),
recursion as (
	select * from base
	union all
	select recursion.tier,base.frisst,cast(concat(recursion.Liste,base.frisst) as varchar)
	from recursion,base
	where recursion.frisst=base.tier 
	and recursion.Liste not like ('%'+recursion.tier+'%')
) select distinct * from recursion
delete from tier_frisst where tier='Fliege' and frisst='Wolf'
-- Aufgabe 1c

-- Aufgabe 1d

drop table tier_frisst;

