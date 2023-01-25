drop table bookings;
drop table bookingProperty;
drop table seats;
drop table flights;
drop table requested_booking_properties;

create table flights(
	no int primary key,
	start varchar(30) not null,
	destination varchar(30) not null,
	departure_time datetime,
	arrival_time datetime
);

create table seats(
	id int,
	flight int foreign key references flights(no),
	price decimal(8,2),
	primary key (id,flight)
);

create table bookingProperty(
	seat int,
	flight int,
	property varchar(30),
	primary key (seat,flight,property),
	foreign key (seat,flight) references seats(id,flight) 
);

create table bookings(
	seat int,
	flight int,
	name varchar(30),
	primary key (seat,flight),
	foreign key (seat,flight) references seats(id,flight)
)

create table requested_booking_properties(
	property varchar(30)
)


insert into flights (no,start,destination,departure_time,arrival_time) values 
	(1,'München','New York'			,'2022-01-08 12:35:00', '2022-01-08 18:35:00'),--
	(2,'München','Berlin'			,'2022-01-08 08:15:00', '2022-01-08 09:18:00'),--
	(3,'Berlin','New York'			,'2022-01-08 11:27:00', '2022-01-08 17:48:00'),--
	(4,'New York','Berlin'			,'2022-01-08 22:01:00', '2022-01-09 04:17:00'),--
	(5,'Amsterdam','Berlin'			,'2022-01-08 08:07:00', '2022-01-08 10:35:00'),--
	(6,'München','Amsterdam'		,'2022-01-08 01:35:00', '2022-01-08 02:18:00'),--
	(7,'Amsterdam','New York'		,'2022-01-09 12:35:00', '2022-01-09 22:09:00'),--
	(8,'München','Buenos Aires'		,'2022-01-08 00:08:00', '2022-01-08 08:12:00'),--
	(9,'Buenos Aires','Amsterdam'	,'2022-01-08 07:35:00', '2022-01-08 15:57:00'),--
	(10,'Buenos Aires','Ottawa'		,'2022-01-08 09:51:00', '2022-01-08 18:02:00'),--
	(11,'Ottawa','Amsterdam'		,'2022-01-08 20:12:00', '2022-01-09 02:04:00');--

insert into seats (id, flight, price) values
	(1,1,8000),
	(1,2,1200),
	(1,3,8200),
	(1,4,8650),
	(1,5,750),
	(1,6,1220),
	(1,7,6950),
	(1,8,7999),
	(1,9,6450),
	(1,10,9720),
	(1,11,3499),
	(2,1,1200),
	(2,2,49),
	(2,3,1100),
	(2,4,1099),
	(2,5,99),
	(2,6,49),
	(2,7,999),
	(2,8,1399),
	(2,9,999),
	(2,10,1350),
	(2,11,349),
	(3,1,1200),
	(3,2,49),
	(3,3,1100),
	(3,4,1099),
	(3,5,99),
	(3,6,49),
	(3,7,999),
	(3,8,1399),
	(3,9,999),
	(3,10,1350),
	(3,11,349);

insert into bookingProperty (seat,flight,property) values
	(1,1,'first'),
	(1,1,'window'),
	(1,1,'plus'),

	(1,2,'first'),
	(1,2,'window'),
	(1,2,'plus'),

	(1,3,'first'),
	(1,3,'window'),
	(1,3,'plus'),

	(1,4,'first'),
	(1,4,'window'),
	(1,4,'plus'),

	(1,5,'first'),
	(1,5,'window'),
	(1,5,'plus'),

	(1,6,'first'),
	(1,6,'window'),
	(1,6,'plus'),

	(1,7,'first'),
	(1,7,'window'),
	(1,7,'plus'),

	(1,8,'first'),
	(1,8,'window'),
	(1,8,'plus'),

	(1,9,'first'),
	(1,9,'window'),
	(1,9,'plus'),

	(1,10,'first'),
	(1,10,'window'),
	(1,10,'plus'),

	(1,11,'first'),
	(1,11,'window'),
	(1,11,'plus'),


	(2,1,'2nd'),
	(2,1,'window'),
	(2,1,'premium_tv'),

	(2,2,'2nd'),
	(2,2,'window'),
	(2,2,'premium_tv'),

	(2,3,'2nd'),
	(2,3,'window'),
	(2,3,'premium_tv'),

	(2,4,'2nd'),
	(2,4,'window'),
	(2,4,'premium_tv'),

	(2,5,'2nd'),
	(2,5,'window'),
	(2,5,'premium_tv'),

	(2,6,'2nd'),
	(2,6,'window'),
	(2,6,'premium_tv'),

	(2,7,'2nd'),
	(2,7,'window'),
	(2,7,'premium_tv'),

	(2,8,'2nd'),
	(2,8,'window'),
	(2,8,'premium_tv'),

	(2,9,'2nd'),
	(2,9,'window'),
	(2,9,'premium_tv'),

	(2,10,'2nd'),
	(2,10,'window'),
	(2,10,'premium_tv'),

	(2,11,'2nd'),
	(2,11,'window'),
	(2,11,'premium_tv'),


	(3,1,'2nd'),
	(3,1,'aisle'),
	(3,1,'extra_leg'),

	(3,2,'2nd'),
	(3,2,'aisle'),
	(3,2,'extra_leg'),

	(3,3,'2nd'),
	(3,3,'aisle'),
	(3,3,'extra_leg'),

	(3,4,'2nd'),
	(3,4,'aisle'),
	(3,4,'extra_leg'),

	(3,5,'2nd'),
	(3,5,'aisle'),
	(3,5,'extra_leg'),

	(3,6,'2nd'),
	(3,6,'aisle'),
	(3,6,'extra_leg'),

	(3,7,'2nd'),
	(3,7,'aisle'),
	(3,7,'extra_leg'),

	(3,8,'2nd'),
	(3,8,'aisle'),
	(3,8,'extra_leg'),

	(3,9,'2nd'),
	(3,9,'aisle'),
	(3,9,'extra_leg'),

	(3,10,'2nd'),
	(3,10,'aisle'),
	(3,10,'extra_leg'),

	(3,11,'2nd'),
	(3,11,'aisle'),
	(3,11,'extra_leg');

insert into bookings (flight,seat,name) values 
	(1,2,'Mr John Smith'),
	(6,2,'Mrs. Pamela Anderson'),
	(5,2,'Mrs. Berta Benz'),
	(3,1,'Mrs. Berta Benz'),
	(10,3,'Mr. Borat Sagdiev'),
	(11,3,'Mr. Borat Sagdiev'),
	(7,1,'Mr. Feng Shu'),
	(11,1,'Mr. Feng Shu');

insert into requested_booking_properties (property) values ('window'),('2nd'),('premium_tv');


-- Gesucht: Alle Flüge von München nach New York, die einen freien Sitzplatz Window, 2nd, premium_tv haben.
