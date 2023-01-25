drop table rentals;
drop table customers;
drop table cars;

create table cars (
	manufacturer varchar(30),
	serial_number varchar(30),
	license_plate varchar(30) unique null,
	type varchar(30),
	seats int check(seats >0),
	service_date date,
	primary key (manufacturer, serial_number)
);

create table customers (
	name varchar(30),
	license varchar(30),
	dln varchar(30) primary key
);

create table rentals (
	manufacturer varchar(30),
	serial_number varchar(30),
	customer varchar(30) foreign key references customers(dln),
	state varchar(30),
	rental_date date,
	return_date date,
	km int,
	costs decimal(6,2),
	price decimal(6,2),
	foreign key (manufacturer, serial_number) references cars(manufacturer, serial_number),
	primary key (customer,manufacturer,serial_number,rental_date),
	check (rental_date<return_date)
);

insert into customers (name,license,dln) values 
	('Klaus', 'B', '1'),
	('Maria','BE','2'),
	('Markus', 'B', '3'),
	('Sabine','CE','4');

insert into cars (license_plate, manufacturer, serial_number, type, seats, service_date) values 
('M-DK299','VW',		'1','Caddy',5,'2023-11-01'),
('RO-TX123','Porsche',	'1','Chantal',5,'2023-11-01'),
('RO-TH1','Seat',		'1','Seagull',5,'2023-11-01'),
('N-K22','Ford',		'1','Focus',5,'2023-11-01'),
('HH-TR-2312','VW',		'2','Phaeton',5,'2023-11-01'),
('M-M1','BMW',			'1','3er',4,'2022-12-12'),
('K-GB99','BMW',		'2','1er',2,'2023-09-01'),
('MG-VL633','Opel',		'1','Corsa',4,'2021-11-01');

insert into rentals (manufacturer, serial_number, customer, rental_date, return_date, km, price, costs) values 
('VW','1','1',		'2022-10-01','2022-10-11',2584,	299.00,146.25),
('Porsche','1','2',	'2022-10-01','2022-10-22',576,	675.00,246.25),
('Seat','1','3',	'2022-10-01','2022-12-03',10456,1299.00,501.76),
('Ford','1','4',	'2022-11-01','2022-11-04',11,	199.00,11.26),
('VW','2','4',		'2022-10-01','2022-10-02',122,	50.50,126.10);


select * from customers
select * from cars
select * from rentals

--Select with natural join providing when a car will be returned by whom 
select cars.license_plate, c.name, r.return_date
from 
	rentals as r	
	join cars on (r.manufacturer=cars.manufacturer and r.serial_number=cars.serial_number)
	join customers as c on (r.customer=c.dln)

--Select giving us the number of days each car was rented out
select  cars.license_plate, datediff(day, rental_date, return_date) as 'rented days'
from	rentals join cars on (rentals.manufacturer=cars.manufacturer and rentals.serial_number=cars.serial_number)

--we are looking for all cars that are registered in Rosenheim
select	cars.license_plate 
from	cars 
where	cars.license_plate like 'RO-%'

--we are looking for all cars from rosenheim and replace RO with Rosenheim
select 'Rosenheim '+substring(cars.license_plate,4,LEN(cars.license_plate)) 
from	cars 
where	cars.license_plate like 'RO-%'

--a case example
select	cars.license_plate,
		case 
			when cars.service_date<CURRENT_TIMESTAMP then 'Service interval execeeded '
			when cars.service_date>CURRENT_TIMESTAMP then 'you have '+ cast(datediff(day, CURRENT_TIMESTAMP, service_date) AS varchar)+' day(s) left to service the car'
			else 'Service is required today'
		end as warning
from	cars

--the cars with the largest number of seats
select * from cars where cars.seats >= all (select cars.seats from cars)

--the cars with the smallest number of seats
select * from cars where cars.seats <= all (select cars.seats from cars)

--not the cars with the smallest number of seats
select * from cars where cars.seats > some (select cars.seats from cars)

--a list of cars that never were rented
select cars.license_plate from cars 
except 
select cars.license_plate from cars join rentals on (cars.manufacturer=rentals.manufacturer and cars.serial_number = rentals.serial_number)
