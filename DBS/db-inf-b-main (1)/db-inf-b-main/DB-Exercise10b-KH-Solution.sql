drop table tier_frisst;

create table tier_frisst(
	tier varchar(30),
	frisst varchar (30)
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
with 
	wer_frisst_was(Tier,Frisst) as (

		-- Rekursionsanfang	
		Select	tier, frisst 
		from tier_frisst
		
		union all
		
		-- Rekursionschritt
		select wer_frisst_was.Tier, tier_frisst.frisst
		from wer_frisst_was, tier_frisst
		where wer_frisst_was.Frisst = tier_frisst.tier
		)

select distinct * from wer_frisst_was


-- Aufgabe 1b
insert into tier_frisst (tier, frisst) values
	('Fliege','Wolf');

with 
	wer_frisst_was(Tier,Frisst,Kette) as (

		-- Rekursionsanfang	
		Select	tier, frisst, cast(tier+'#'+frisst as varchar)
		from tier_frisst
		
		union all
		
		-- Rekursionschritt
		select wer_frisst_was.Tier, tier_frisst.frisst, cast(wer_frisst_was.Kette+'#'+tier_frisst.frisst as varchar)
		from wer_frisst_was, tier_frisst
		where	wer_frisst_was.Frisst = tier_frisst.tier
				and wer_frisst_was.Kette not like ('%'+tier_frisst.frisst+'%')
		)

select distinct * from wer_frisst_was;

-- Aufgabe 1c
with 
	wer_frisst_was(Tier,Frisst,Kette, Direkt) as (

		-- Rekursionsanfang	
		Select	tier, frisst, cast(tier+'#'+frisst as varchar), cast('Ja' as varchar)
		from tier_frisst
		
		union all
		
		-- Rekursionschritt
		select wer_frisst_was.Tier, tier_frisst.frisst, cast(wer_frisst_was.Kette+'#'+tier_frisst.frisst as varchar), cast('Nein, indirekt' as varchar)
		from wer_frisst_was, tier_frisst
		where	wer_frisst_was.Frisst = tier_frisst.tier
				and wer_frisst_was.Kette not like ('%'+tier_frisst.frisst+'%')
		)

select distinct * from wer_frisst_was;

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
