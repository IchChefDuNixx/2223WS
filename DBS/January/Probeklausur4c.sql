-- Rezept table
CREATE TABLE Rezept (
    RNr int PRIMARY KEY,
    RName varchar(50),
    RDauer int
);
INSERT INTO Rezept (RNr, RName, RDauer) VALUES
    (1, 'Spaghetti Bolognese', 30),
    (2, 'Grilled Cheese Sandwich', 15),
    (3, 'Chicken Curry', 45),
    (4, 'Stir-Fry Vegetables', 20),
    (5, 'Pancakes', 25),
    (6, 'Lasagna', 60),
    (7, 'Beef Tacos', 35),
    (8, 'Egg Fried Rice', 25),
    (9, 'Vegetable Soup', 30),
    (10, 'Chocolate Cake', 60);

-- Zutat table
CREATE TABLE Zutat (
    ZNr int PRIMARY KEY,
    ZName varchar(40),
    ZEinheit varchar(40)
);
INSERT INTO Zutat (ZNr, ZName, ZEinheit) VALUES
    (1, 'Ground beef', 'grams'),
    (2, 'Spaghetti', 'grams'),
    (3, 'Tomato sauce', 'milliliters'),
    (4, 'Cheese', 'grams'),
    (5, 'Bread', 'slices'),
    (6, 'Onion', 'pieces'),
    (7, 'Garlic', 'cloves'),
    (8, 'Curry powder', 'teaspoons'),
    (9, 'Vegetables', 'grams'),
    (10, 'Eggs', 'pieces');

-- braucht table
CREATE TABLE braucht (
    RNr int,
    ZNr int,
    Menge int,
    PRIMARY KEY (RNr, ZNr),
    FOREIGN KEY (RNr) REFERENCES Rezept(RNr),
    FOREIGN KEY (ZNr) REFERENCES Zutat(ZNr)
);
INSERT INTO braucht (RNr, ZNr, Menge) VALUES
    (1, 1, 500),
    (1, 2, 250),
    (1, 3, 250),
    (2, 4, 100),
    (2, 5, 2),
    (3, 1, 300),
    (3, 6, 1),
    (3, 7, 2),
    (3, 8, 2),
    (3, 9, 500),
    (4, 9, 600),
    (4, 10, 3),
    (5, 5, 4),
    (5, 10, 2),
    (6, 2, 350),
    (6, 4, 200),
    (6, 3, 250),
    (7, 1, 400),
    (7, 9, 500),
    (8, 2, 250),
    (8, 9, 500),
    (8, 10, 2),
    (9, 9, 800),
    (10, 4, 150),
    (10, 10, 200);

with minIngredients as (
	select Z.ZName, MAX(b.Menge) as max, COUNT(Z.ZName) as count
	from Rezept as R, Zutat as Z, braucht as b
	where R.RNr=b.RNr and Z.ZNr=b.ZNr and R.RDauer<=40
	group by Z.ZName
), unused as (
	select * from minIngredients
	union
	select ZName, null as max, null as count from Zutat where ZName not in (select ZName from minIngredients)
) select * from unused order by ZName asc

drop table braucht,Zutat,Rezept

drop table A
create table A(a char primary key)
insert into A(a) values ('a'),('x'),('g');
drop table B
create table B(b int, c char, primary key (b,c))
insert into B(c,b) values ('a',1),('a',2),('b',3),('b',1),('x',1),('x',5),('g',1);

select * from A
select * from B

-- B / A
select b from B
except
select b from (
	select * from (select b from B) as x cross join (select * from A) as y
	except
	select * from B
) as temp


select Wine from recommendation
except
select Wine from (
	select distinct * from (select Wine from recommendation) as x cross join (select critic from guide2) as y
	except
	select * from recommendation
) as w

drop table recommendation
create table recommendation(Wine varchar(99), critic varchar(99), primary key(Wine, critic))
insert into recommendation(Wine, critic) values 
	('La Rose GrandCru','Parker'),
	('Pinot Noir','Parker'),
	('Riesling Reserve','Parker'),
	('La Rose GrandCru','Clarke'),
	('Pinot Noir','Clarke'),
	('Riesling Reserve','Gault—Millau');
select * from recommendation

drop table guide1
create table guide1(critic varchar(99) primary key)
insert into guide1(critic) values ('Parker'),('Clarke');

drop table guide2
create table guide2(critic varchar(99) primary key)
insert into guide2(critic) values ('Parker'),('Gault—Millau');

select * from guide1
select * from guide2

drop view recoview
create view recoview as
select Wine from recommendation
except
select Wine from (
	select distinct * from (select Wine from recommendation) as x cross join (select critic from guide2) as y
	except
	select * from recommendation
) as w

select * from recoview

drop table test
create table test(id int primary key check (id>=0), count int)
create table test(id int primary key constraint non_negative check(id>=0))
create table test(id int primary key, constraint non_negative check (id>=0))
create table test(id int primary key, num int references A(num) on update cascade on delete set null)

create trigger trig on test after insert as update count set count = COUNT + 1




