
DROP DATABASE IF EXISTS ValData;
CREATE DATABASE ValData;
USE ValData;

create table Customers (
	CustomerID INT,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	BillingAddress VARCHAR(50),
	DeliveryAddress VARCHAR(50),
	Email VARCHAR(50),
	PhoneNo VARCHAR(50),
	PRIMARY KEY (CustomerID)
);
insert into Customers (CustomerID, FirstName, LastName, BillingAddress, DeliveryAddress, Email, PhoneNo) values (1, 'Arlee', 'Mapplethorpe', '681 Bartillon Center', '35 Dovetail Circle', 'amapplethorpe0@spotify.com', '944-451-0032');
insert into Customers (CustomerID, FirstName, LastName, BillingAddress, DeliveryAddress, Email, PhoneNo) values (2, 'Ogdan', 'Gorgl', '0 Caliangt Drive', '062 Loomis Court', 'ogorgl1@cafepress.com', '138-695-5053');
insert into Customers (CustomerID, FirstName, LastName, BillingAddress, DeliveryAddress, Email, PhoneNo) values (3, 'Joby', 'Fenge', '535 Chive Way', '94589 Dapin Plaza', 'jfenge2@facebook.com', '996-363-7157');
insert into Customers (CustomerID, FirstName, LastName, BillingAddress, DeliveryAddress, Email, PhoneNo) values (4, 'Amory', 'Lawerence', '2467 Kensington Place', '1624 Crowley Street', 'alawerence3@t.co', '460-710-4764');
insert into Customers (CustomerID, FirstName, LastName, BillingAddress, DeliveryAddress, Email, PhoneNo) values (5, 'Tony', 'Woodrow', '9633 Washington Point', '39 Beilfuss Avenue', 'twoodrow4@globo.com', '243-771-3026');
insert into Customers (CustomerID, FirstName, LastName, BillingAddress, DeliveryAddress, Email, PhoneNo) values (6, 'Homer', 'Simpson', '742 Evergreen Terrace', '742 Evergreen Terrace', 'homer@gmail.com', '243-771-3026');
insert into Customers (CustomerID, FirstName, LastName, BillingAddress, DeliveryAddress, Email, PhoneNo) values (7, 'Ned', 'Flanders', '743 Evergreen Terrace', '743 Evergreen Terrace', 'flanders@gmail.com', '243-771-3026');
insert into Customers (CustomerID, FirstName, LastName, BillingAddress, DeliveryAddress, Email, PhoneNo) values (8, 'Barney', 'Gumble', 'Moes Tavern', 'Moes Tavern', 'barney@gmail.com', '243-771-3026');

create table Staff (
	StaffID INT,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Address VARCHAR(50),
	Email VARCHAR(50),
	PhoneNo VARCHAR(50),
	DoB DATE,
	Salary INT,
	PRIMARY KEY (StaffID)
);
insert into Staff (StaffID, FirstName, LastName, Address, Email, PhoneNo, DoB, Salary) values (1, 'Harwilll', 'Giannoni', '86868 Logan Pass', 'hgiannoni0@wordpress.com', '663-613-0946', '1963/06/06', 83000);
insert into Staff (StaffID, FirstName, LastName, Address, Email, PhoneNo, DoB, Salary) values (2, 'Galina', 'Woodger', '34 Forest Run Street', 'gwoodger1@webmd.com', '421-503-0070', '1995/09/16', 64000);
insert into Staff (StaffID, FirstName, LastName, Address, Email, PhoneNo, DoB, Salary) values (3, 'Dianemarie', 'Choldcroft', '9 Dovetail Court', 'dcholdcroft2@domainmarket.com', '466-137-5267', '1962/04/02', 32000);
insert into Staff (StaffID, FirstName, LastName, Address, Email, PhoneNo, DoB, Salary) values (4, 'Adina', 'Spinola', '1 Kedzie Trail', 'aspinola3@aboutads.info', '313-145-4342', '1985/06/17', 47000);
insert into Staff (StaffID, FirstName, LastName, Address, Email, PhoneNo, DoB, Salary) values (5, 'Serene', 'Skae', '42328 Fuller Parkway', 'sskae4@gizmodo.com', '421-855-8556', '1998/07/30', 60000);

create table Suppliers (
	SupplierID INT,
	Name VARCHAR(50),
	Address VARCHAR(50),
	Email VARCHAR(50),
	PhoneNo VARCHAR(50),
	PRIMARY KEY (SupplierID)
);
insert into Suppliers (SupplierID, Name, Address, Email, PhoneNo) values (1, 'Mudo', '8 Schmedeman Lane', 'olenox0@fema.gov', '632-373-9306');
insert into Suppliers (SupplierID, Name, Address, Email, PhoneNo) values (2, 'Oyoloo', '563 Sloan Park', 'bkacheler1@boston.com', '379-981-4192');
insert into Suppliers (SupplierID, Name, Address, Email, PhoneNo) values (3, 'Livetube', '84026 Upham Crossing', 'scalderwood2@paypal.com', '524-579-5319');
insert into Suppliers (SupplierID, Name, Address, Email, PhoneNo) values (4, 'Vinder', '6945 Hagan Center', 'deynon3@example.com', '880-531-2930');
insert into Suppliers (SupplierID, Name, Address, Email, PhoneNo) values (5, 'Cogilith', '042 Hintze Road', 'wcornil4@msn.com', '534-686-4991');

create table Orders (
	OrderID INT,
	CustomerID INT,
	StaffID INT,
	OrderDate DATE,
	PRIMARY KEY (OrderID)
);
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (1, 2, 1, '2020/08/14');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (2, 5, 5, '2020/03/15');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (3, 3, 2, '2020/06/23');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (4, 5, 3, '2020/08/27');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (5, 1, 1, '2020/12/21');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (6, 3, 1, '2020/11/23');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (7, 5, 1, '2020/07/22');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (8, 3, 4, '2020/02/25');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (9, 3, 4, '2020/04/16');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (10, 1, 1, '2020/01/10');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (11, 3, 3, '2020/09/23');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (12, 4, 4, '2020/12/26');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (13, 4, 2, '2020/10/01');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (14, 5, 5, '2020/08/09');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (15, 1, 4, '2020/01/08');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (16, 3, 1, '2020/08/14');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (17, 3, 2, '2020/05/28');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (18, 4, 2, '2020/11/16');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (19, 1, 5, '2020/09/23');
insert into Orders (OrderID, CustomerID, StaffID, OrderDate) values (20, 2, 5, '2020/07/11');

create table OrderItems (
	ItemID INT,
	StockID INT,
	OrderID INT,
	Quantity INT,
	PRIMARY KEY (ItemID)
);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (1, 10, 17, 9);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (2, 5, 7, 3);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (3, 10, 6, 2);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (4, 8, 15, 2);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (5, 4, 1, 3);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (6, 5, 19, 9);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (7, 5, 10, 10);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (8, 9, 13, 5);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (9, 10, 10, 10);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (10, 8, 14, 6);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (11, 1, 16, 5);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (12, 7, 8, 3);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (13, 7, 5, 10);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (14, 3, 8, 1);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (15, 3, 20, 8);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (16, 8, 9, 7);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (17, 9, 8, 1);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (18, 2, 5, 1);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (19, 4, 17, 5);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (20, 7, 14, 7);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (21, 9, 18, 6);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (22, 4, 10, 10);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (23, 2, 12, 9);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (24, 9, 2, 2);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (25, 1, 19, 3);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (26, 7, 15, 1);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (27, 2, 5, 7);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (28, 8, 11, 4);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (29, 5, 18, 5);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (30, 4, 16, 2);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (31, 5, 8, 7);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (32, 7, 16, 8);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (33, 10, 15, 3);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (34, 4, 10, 7);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (35, 5, 8, 5);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (36, 1, 4, 7);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (37, 7, 2, 7);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (38, 5, 1, 4);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (39, 7, 11, 10);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (40, 2, 13, 4);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (41, 7, 19, 6);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (42, 4, 11, 10);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (43, 9, 20, 4);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (44, 5, 2, 7);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (45, 7, 1, 4);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (46, 2, 13, 2);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (47, 8, 3, 10);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (48, 7, 15, 10);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (49, 4, 13, 6);
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (50, 2, 19, 4);

create table Stock (
	StockID INT,
	SupplierID INT,
	UnitPrice INT,
	StockLevel INT,
	PRIMARY KEY (StockID)
);
insert into Stock (StockID, SupplierID, UnitPrice, StockLevel) values (1, 3, 140, 98);
insert into Stock (StockID, SupplierID, UnitPrice, StockLevel) values (2, 1, 65, 61);
insert into Stock (StockID, SupplierID, UnitPrice, StockLevel) values (3, 5, 35, 27);
insert into Stock (StockID, SupplierID, UnitPrice, StockLevel) values (4, 3, 150, 7);
insert into Stock (StockID, SupplierID, UnitPrice, StockLevel) values (5, 1, 155, 45);
insert into Stock (StockID, SupplierID, UnitPrice, StockLevel) values (6, 1, 105, 80);
insert into Stock (StockID, SupplierID, UnitPrice, StockLevel) values (7, 2, 60, 57);
insert into Stock (StockID, SupplierID, UnitPrice, StockLevel) values (8, 5, 170, 19);
insert into Stock (StockID, SupplierID, UnitPrice, StockLevel) values (9, 4, 110, 63);
insert into Stock (StockID, SupplierID, UnitPrice, StockLevel) values (10, 2, 95, 88);



