-- A
create table Customer(
	State varchar(50),
	PostCode int,
	City varchar(50),
	Street varchar(50),
	Phone int,
	Email varchar(50),
	LastName varchar(50),
	FirstName varchar(50),
	Login varchar(50) primary key,
	Password varchar(50)
)

create table Cart(
	Date date,
	ID int primary key,
	Type varchar(50),
	Owner varchar(50) references Customer(Login)
)

create table ItemCategory(
	ID int primary key,
	Description varchar(500)
)

create table Item(
	ItemNumber int primary key,
	Name varchar(50),
	Price float,
	Picture varchar(50),
	Category int references ItemCategory(ID),
)

create table SKU(
	SKUNumber int primary key,
	Color varchar(50),
	Size int,
	Location varchar(50),
	Item int references Item(ItemNumber) not null
)

create table SKUinCart(
	Cart int references Cart(ID),
	SKU int references SKU(SKUNumber),
	Quantity int,
	primary key(Cart, SKU)
)

select * from Customer
select * from Cart
select * from SKU
select * from Item
select * from ItemCategory
select * from SKUinCart
drop table SKUinCart, SKU, Item, ItemCategory, Cart, Customer



-- B
create table Train(
	ID int primary key,
	operator varchar(50),
)

create table Carriage(
	ID int primary key,
	DoM date,
	attachedTrain int references Train(ID) not null
)

create table Feature(
	Descriptor varchar(50) primary key,
)

create table Seat(
	SeatNumber int primary key,
	isWindow bit,
	inCarriage int references Carriage(ID) not null
)

create table hasFeature(
	Carriage int references Carriage(ID),
	Feature varchar(50) references Feature(Descriptor),
	primary key(Carriage, Feature)
)

select * from Train
select * from Carriage
select * from Seat
select * from Feature
select * from hasFeature
drop table hasFeature, Feature, Seat, Carriage, Train



-- C
create table Student(
	Matriculation int primary key,
	Name varchar(99),
	Birthday date
)

create table Lecturer(
	Name varchar(99) primary key,
	Office varchar(99),
	Phone int
)

create table Lecture(
	Name varchar(99),
	Semester varchar(4),
	Room varchar(99),
	Lecturer varchar(99) references Lecturer(Name) not null,
	primary key(Name, Semester)
)

create table StudentInLecture(
	Student int references Student(Matriculation),
	Name varchar(99),
	Semester varchar(4),
	Grade int,
	foreign key (Name, Semester) references Lecture(Name, Semester),
	primary key (Student, Name, Semester)
)

select * from Student
select * from Lecturer
select * from Lecture
select * from StudentInLecture
drop table StudentInLecture, Lecture, Lecturer, Student



-- D
create table Product(
	Name varchar(99) primary key,
	Price float,
	isCookie bit,
	isGlutenfree bit,
	isMulledWine bit,
	Alc float,
	Color varchar(99),
	isMeatball bit,
	hasMustard bit,
	isVeggie bit
)

create table Ingredient(
	Name varchar(99) primary key
)

create table Supplier(
	Name varchar(99) primary key
)

create table Car(
	Name varchar(99) primary key
)

create table Stall(
	Name varchar(99) primary key,
	EmployeeCount int,
	Car varchar(99) references Car(Name) not null
)

create table XmasMarket(
	Name varchar(99) primary key,
	StartDate date,
	EndDate date,
	Fee float
)

create table IngredientList(
	Product varchar(99) references Product(Name),
	Ingredient varchar(99) references Ingredient(Name),
	Quantity int,
	primary key(Product, Ingredient)
)

create table SupplyChain(
	Ingredient varchar(99) references Ingredient(Name),
	Supplier varchar(99) references Supplier(Name),
	primary key(Ingredient, Supplier)
)

create table Menu(
	Stall varchar(99) references Stall(Name),
	Product varchar(99) references Product(Name),
	primary key(Stall, Product)
)

create table StallOnMarket(
	Market varchar(99) references XmasMarket(Name),
	Stall varchar(99) references Stall(Name),
	MulledWineSold int,
	primary key(Market, Stall)
)

select * from Product
select * from Ingredient
select * from Supplier
select * from Car
select * from Stall
select * from XmasMarket
select * from IngredientList
select * from SupplyChain
select * from Menu
select * from StallOnMarket
drop table StallOnMarket, Menu, SupplyChain, IngredientList, XmasMarket, Stall, Car, Supplier, Ingredient, Product
