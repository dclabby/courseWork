
USE ValData;
USE TestData;
/*NOTE: queries are not case sensitive in Windows but are case sensitive in linux!*/

/*
Error Code: 1055 incompatible with sql_mode=only_full_group_by
https://stackoverflow.com/questions/36207042/error-code-1055-incompatible-with-sql-mode-only-full-group-by
*/
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SET SQL_SAFE_UPDATES = 0;

/* ***************************************************************************** */
/* 1. Show all the details of the products that have a price greater than 100. */
SELECT * FROM Stock where Stock.UnitPrice > 100; 

SELECT * FROM Stock where Stock.UnitPrice <= 100; 

/* ***************************************************************************** */
/* 2. Show all the products along with the supplier detail for all products that have a price greater than 100 */
SELECT Stock.StockID, Stock.UnitPrice, Suppliers.SupplierID,Suppliers.Name as SupplierName
FROM Stock INNER JOIN Suppliers 
on Stock.SupplierID = Suppliers.SupplierID 
where Stock.UnitPrice > 100; 

/* ***************************************************************************** */
/* 3. Create a stored procedure that takes the start and end dates of the sales and display all the sales transactions between the start and the end dates.*/
drop procedure if exists getTransactions;
DELIMITER //
CREATE procedure getTransactions(IN startDate DATE, IN endDate DATE)
begin
	/*SELECT * FROM Orders where Orders.Orderdate >= startDate and Orders.Orderdate <= endDate;*/
	SELECT * FROM Orders where Orders.Orderdate between startDate and endDate;
END//

Call getTransactions('2020-08-01', '2020-08-31');
SELECT * FROM Orders

/* ***************************************************************************** */
/* 4. Create a view that shows the total number of items a customer buys from the business in October 2020 along with the total price (use group by) */
drop view if exists customerOrders;
create view customerOrders as
SELECT Orders.OrderID, Orders.CustomerID, Orders.Orderdate, 
sum(UnitPrice*Quantity) as totalPrice,
count(*) as NumItems,
sum(Quantity) as totalQty FROM
(Orders inner join OrderItems on Orders.OrderID = OrderItems.OrderID) 
inner join 
Stock on Stock.StockID = OrderItems.StockID
where Orders.Orderdate between '2020-10-01' and '2020-12-31'
group by CustomerID
order by OrderID;

SELECT CustomerID, NumItems, totalQty, totalPrice FROM customerOrders;

SELECT CustomerID, OrderDate, UnitPrice, Quantity FROM
(Orders inner join OrderItems on Orders.OrderID = OrderItems.OrderID) 
inner join 
Stock on Stock.StockID = OrderItems.StockID
WHERE CustomerID = 1;

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
        (SELECT Quantity from OrderItems ORDER BY ItemID DESC LIMIT 1)
		WHERE
		Stock.StockID = (SELECT StockID FROM OrderItems ORDER BY ItemID DESC LIMIT 1);
END$$
DELIMITER ;

SELECT * FROM OrderItems ORDER BY ItemID DESC;
DELETE FROM OrderItems WHERE ItemID = 51;
SELECT * FROM Stock WHERE StockID Between 1 and 3;
insert into OrderItems (ItemID, StockID, OrderID, Quantity) values (51, 2, 21, 11);

/* ***************************************************************************** */
/* 6. Create a report of the annual sales (2020) of the business showing the total number of products sold and the total price sold every month (use A group by with roll-up)*/

drop view if exists monthlySales;
create view monthlySales as
SELECT coalesce(month(x.OrderDate), 'annualTotal') as monthNumber, 
sum(x.totalPrice) as totalSales,
sum(x.totalQty) as totalQty
FROM

(SELECT Orders.OrderID, Orders.OrderDate, 
sum(UnitPrice*Quantity) as totalPrice,
sum(Quantity) as totalQty
FROM
(Orders inner join OrderItems on Orders.OrderID = OrderItems.OrderID) 
inner join 
Stock on Stock.StockID = OrderItems.StockID
group by OrderID) as x

group by month(x.OrderDate) with rollup;

SELECT * from monthlySales;
SELECT * FROM orderValue ORDER BY OrderDate;

/* ***************************************************************************** */
/* 7. Display the growth in sales/services (as a percentage) for your business, from the 1st month of opening until now. */
SELECT thisMonth.monthNumber as this_month, 100*(thisMonth.totalSales - lastMonth.totalSales)/lastMonth.totalSales as perCent_sales_Growth
from monthlySales lastMonth
inner join 
monthlySales thisMonth 
ON lastMonth.monthNumber + 1 = thisMonth.monthNumber
and thisMonth.monthNumber >= 2;

/* ***************************************************************************** */
/* 8. Delete all customers who never buy a product from the business.*/
DELETE FROM Customers
WHERE Customers.CustomerID NOT IN 
(SELECT Orders.CustomerID FROM Orders)

