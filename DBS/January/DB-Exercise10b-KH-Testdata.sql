create table tier_frisst(
	Tier varchar(30),
	Frisst varchar(30)
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
	select tier_frisst.*,cast(tier+frisst as varchar) as Liste from tier_frisst
), recursion as (
	select * from base
	union all
	select recursion.tier,base.frisst,cast(concat(recursion.Liste,base.frisst) as varchar)
	from recursion,base
	where recursion.frisst=base.tier 
	and recursion.Liste not like ('%'+base.Frisst+'%')
) select distinct * from recursion
delete from tier_frisst where tier='Fliege' and frisst='Wolf'
-- Aufgabe 1c
with base as (
	select tier_frisst.*,cast(tier+frisst as varchar) as Liste,cast('True' as varchar) as 'Direct?' from tier_frisst
), recursion as (
	select * from base
	union all
	select recursion.tier,base.frisst,cast(concat(recursion.Liste,base.frisst) as varchar),cast('False' as varchar) as 'Direct?'
	from recursion,base
	where recursion.frisst=base.tier 
	and recursion.Liste not like ('%'+base.Frisst+'%')
) select distinct * from recursion order by [Direct?] desc

-- Aufgabe 1d
with 
	wer_frisst_was(Tier, Frisst, Kette, Direkt, naechstes_Tier) as (

		-- Rekursionsanfang	
		Select	tier, frisst, cast(tier+'#'+frisst as varchar), cast('Ja' as varchar), frisst
		from tier_frisst
		
		union all
		
		-- Rekursionschritt
		select wer_frisst_was.Tier, tier_frisst.frisst, cast(wer_frisst_was.Kette+'#'+tier_frisst.frisst as varchar), cast('Nein, indirekt' as varchar), wer_frisst_was.naechstes_Tier
		from wer_frisst_was, tier_frisst
		where	wer_frisst_was.Frisst = tier_frisst.tier
				and wer_frisst_was.Kette not like ('%'+tier_frisst.frisst+'%')
		)

select distinct * from wer_frisst_was;



drop table tier_frisst;

