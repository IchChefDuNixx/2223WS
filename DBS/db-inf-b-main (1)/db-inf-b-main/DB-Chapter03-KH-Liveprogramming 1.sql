create table cars (
	vin varchar(30) primary key,
	type varchar(30),
	manufacturer varchar(30) not null,
	state decimal(2,2),
	seats int,
	TUEV date,
	license_plate varchar(30) unique,
	availability bit
);

create table customers (
	name varchar(30),
	license varchar(30),
	dln varchar(30) primary key
);

create table rentals (
	dln varchar(30) foreign key references customers(dln),
	vin varchar(30) foreign key references cars(vin),
	state varchar(30),
	rental_date date,
	return_date date,
	km int,
	primary key (dln,vin,rental_date)
);
insert into customers values ('Klaus', 'B', '12345der');

insert into customers (name,license,dln) values 
	('Klaus2', 'B', '12345deer'),
	('Maria','BE','skdjfhöks');

insert into cars (vin, manufacturer,license_plate) values 
('1','BMW','M-DK299'),
('2','VW','RO-X123'),
('3','Opel','HH-K234');

update cars 
	set TUEV = CURRENT_TIMESTAMP 
	where manufacturer='BMW';

insert into rentals (dln, vin, rental_date) values ('12345deer',2,'2022-10-11');
insert into rentals (dln, vin, rental_date) values ('12345deer',3,'2022-10-11');

select * from customers
select * from cars
select * from rentals

drop table rentals;
drop table customers;
drop table cars;






