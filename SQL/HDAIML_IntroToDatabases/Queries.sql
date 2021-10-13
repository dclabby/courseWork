
USE ValData;
USE TestData;
/*NOTE: queries are not case sensitive in Windows but are case sensitive in linux!*/

/*
Error Code: 1055 incompatible with sql_mode=only_full_group_by
https://stackoverflow.com/questions/36207042/error-code-1055-incompatible-with-sql-mode-only-full-group-by
*/
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

/* ***************************************************************************** */
/* 1. Show all the details of the products that have a price greater than 100. */
SELECT * FROM Stock where Stock.UnitPrice > 100; 

/* ***************************************************************************** */
/* 2. Show all the products along with the supplier detail who supplied the products.*/
/* 2.1 ... for all products*/
SELECT 
Stock.StockID, Stock.UnitPrice, Stock.StockLevel,
Suppliers.SupplierID,Suppliers.Name as SupplierName, Suppliers.Address as SupplierAddress, Suppliers.Email as SupplierEmail, Suppliers.PhoneNo as SupplierPhoneNo
FROM Stock INNER JOIN Suppliers 
on Stock.SupplierID = Suppliers.SupplierID; 

/* 2.2 ... for all products that have a price greater than 100 */
SELECT 
Stock.StockID, Stock.UnitPrice, Stock.StockLevel,
Suppliers.SupplierID, Suppliers.Name as SupplierName, Suppliers.Address as SupplierAddress, Suppliers.Email as SupplierEmail, Suppliers.PhoneNo as SupplierPhoneNo
FROM Stock INNER JOIN Suppliers 
on Stock.SupplierID = Suppliers.SupplierID 
where Stock.UnitPrice > 100; 

/* ***************************************************************************** */
/* 3. Create a stored procedure that takes the start and end dates of the sales and display all the sales transactions between the start and the end dates.*/
drop procedure if exists getTransactions;
DELIMITER //
CREATE procedure getTransactions(IN startDate DATE, IN endDate DATE)
begin
	SELECT * FROM Orders where Orders.Orderdate >= startDate and Orders.Orderdate <= endDate;
END//
Call getTransactions('2020-08-01', '2020-08-31');

/* ***************************************************************************** */
/* 4. Create a view that shows the total number of items a customer buys from the business in October 2020 along with the total price (use group by) */

/* first create a view that shows the price of each order*/
drop view if exists orderPrice;
create view orderPrice as
SELECT Orders.OrderID, Orders.CustomerID, Orders.Orderdate, sum(UnitPrice*Quantity) as totalPrice FROM 
(Orders inner join OrderItems on Orders.OrderID = OrderItems.OrderID) 
inner join 
Stock on Stock.StockID = OrderItems.StockID
group by OrderID
order by OrderID;

/* next create a view that shows the total number of distinct items, and the total Quantity of items per order*/
drop view if exists totalNoItems;
create view totalNoItems as
SELECT Orders.OrderID, Orders.CustomerID, count(*) as NumItems, sum(Quantity) as totalQty
FROM Orders inner join OrderItems on Orders.OrderID = OrderItems.OrderID
group by Orders.OrderID; 

/* finally, create a view that shows the CustomerID, the number of distinct items ordered, the total Quantity of items ordered, and the value of their Orders for Orders from October 2020*/
drop view if exists customerOrdersOct;
create view customerOrdersOct as
SELECT orderPrice.Orderdate, orderPrice.CustomerID, totalNoItems.NumItems, totalNoItems.totalQty, orderPrice.totalPrice as totalPrice
from orderPrice inner join totalNoItems 
on orderPrice.CustomerID = totalNoItems.CustomerID
where orderPrice.Orderdate >= '2020-10-01' and orderPrice.Orderdate <= '2020-10-31'
group by orderPrice.CustomerID;

SELECT * FROM customerOrdersOct ORDER BY Orderdate;


/*create view customerOrdersAug as
SELECT orderPrice.CustomerID, sum(totalNoItems.NumItems), sum(totalNoItems.totalQty), sum(orderPrice.totalPrice) as totalPrice
from orderPrice inner join totalNoItems 
on orderPrice.OrderID = totalNoItems.OrderID
where orderPrice.Orderdate >= '2020-08-01' and orderPrice.Orderdate <= '2020-08-31'
group by orderPrice.CustomerID;*/

/* ***************************************************************************** */
/* 5. Create a trigger that adjusts the Stock level every time a product is sold.*/
drop trigger if exists updateStockLevel;
DELIMITER $$ 
CREATE TRIGGER updateStockLevel 
	AFTER INSERT ON OrderItems
    FOR EACH ROW
    BEGIN
		UPDATE Stock
		SET Stock.Stocklevel = Stock.Stocklevel - 
        (SELECT OrderItems.Quantity from OrderItems where OrderItems.ItemID = (SELECT max(OrderItems.ItemID) from OrderItems))
		WHERE
		Stock.StockID = any(
		SELECT * FROM(
		SELECT Stock.StockID
		from Stock inner join OrderItems
		on Stock.StockID = OrderItems.StockID 
		where OrderItems.ItemID = (SELECT max(OrderItems.ItemID) from OrderItems))
		as x);
END$$
DELIMITER ;

/*insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (51, 6, 19, 41);*/
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (1001, 6, 19, 41);


/* ***************************************************************************** */
/* 6. Create a report of the annual sales (2020) of the business showing the total number of products sold and the total price sold every month (use A group by with roll-up)*/
drop view if exists monthlysales;
create view monthlySales as
select coalesce(month(orderPrice.Orderdate), 'annualTotal') as monthNumber, 
sum(orderPrice.totalPrice) as totalSales,
sum(totalNoItems.totalQty) as totalQty
from orderPrice inner join totalNoItems on orderPrice.OrderID = totalNoItems.OrderID
group by month(orderPrice.Orderdate) with rollup;
SELECT * from monthlySales;

/* ***************************************************************************** */
/* 7. Display the growth in sales/services (as a percentage) for your business, from the 1st month of opening until now. */
SELECT thisMonth.monthNumber as this_month, 100*(thisMonth.totalSales - lastMonth.totalSales)/lastMonth.totalSales as perCent_sales_Growth
from monthlySales lastMonth
inner join 
monthlySales thisMonth 
on lastMonth.monthNumber + 1 = thisMonth.monthNumber
and thisMonth.monthNumber >= 2;

/* ***************************************************************************** */
/* 8. Delete all customers who never buy a product from the business.*/
DELETE FROM Customers where Customers.CustomerID=any(
SELECT * FROM
(SELECT Customers.CustomerID 
FROM (Customers left join Orders on Customers.CustomerID = Orders.CustomerID) 
WHERE Orders.CustomerID is null group by Customers.CustomerID)
as x )


SELECT * 
FROM (Customers left join Orders on Customers.CustomerID = Orders.CustomerID) 
WHERE Orders.CustomerID is null group by Customers.CustomerID;
