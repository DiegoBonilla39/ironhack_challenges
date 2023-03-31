--[azure-sql]
--Lab 02: Probar diferentes tipos de Join

-- Inner Join
SELECT *
FROM Customers INNER JOIN Invoices ON Customers.ID = Invoices.Customer

-- Full join
SELECT *
FROM Customers FULL JOIN Invoices ON Customers.ID = Invoices.Customer

-- Left join
SELECT *
FROM Customers LEFT JOIN Invoices ON Customers.ID = Invoices.Customer
	
-- Right join
SELECT *
FROM Customers RIGHT JOIN Invoices ON Customers.ID = Invoices.Customer

-- Exclusive left join
SELECT *
FROM Customers LEFT JOIN Invoices ON Customers.ID = Invoices.Customer
WHERE Invoices.Customer IS NULL

-- Exclusive right join
SELECT *
FROM Customers RIGHT JOIN Invoices ON Customers.ID = Invoices.Customer
WHERE Customers.ID IS NULL

-- Exclusive full join
SELECT *
FROM Customers FULL JOIN Invoices ON Customers.ID = Invoices.Customer
WHERE Customers.ID IS NULL OR Invoices.Customer IS NULL

-- Cross join
SELECT *
FROM Customers CROSS JOIN Invoices

--Lab 03

--Que productos ha comprado cada cliente
SELECT c.FirstName + ' ' + c.LastName AS [Customer Fullname], p.Name AS [Product Name]
FROM SalesLT.Customer AS c
INNER JOIN SalesLT.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
INNER JOIN SalesLT.SalesOrderDetail AS shd ON soh.SalesOrderID = shd.SalesOrderID
INNER JOIN SalesLT.Product AS p ON shd.ProductID = p.ProductID
ORDER BY [Customer Fullname], [Product Name]

--Descripcion de productos en arabe
SELECT pm.Name AS 'Product Model', pd.[Description]
FROM SalesLT.ProductModel AS pm
INNER JOIN SalesLT.ProductModelProductDescription AS pmpd ON pm.ProductModelID = pmpd.ProductModelID
INNER JOIN SalesLT.ProductDescription AS pd on PD.ProductDescriptionID = pmpd.ProductDescriptionID
INNER JOIN SalesLT.Product AS p ON p.ProductModelID = pm.ProductModelID
WHERE pmpd.Culture = 'ar' AND p.ProductID = 710;

--Todas las ventas por producto (ordenados decrecientemente)
SELECT p.name, COUNT(*) AS 'Total Orders'
FROM SalesLT.Product AS p
INNER JOIN SalesLT.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
GROUP BY p.Name
ORDER BY 'Total Orders' DESC

--Lab 04
--Que producto ha sido el mas vendido

SELECT p.Name As 'Product', COUNT(*) AS 'Total'
FROM SalesLT.SalesOrderHeader AS soh
INNER JOIN SalesLT.SalesOrderDetail AS shd ON soh.SalesOrderID = shd.SalesOrderID
INNER JOIN SalesLT.Product AS p ON shd.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY 2 DESC

--¿Cuántas unidades han sido vendidas por categoría y producto? (ordenado por categoría y producto)
SELECT pc.Name AS 'Category', p.name AS Product, SUM(sod.OrderQty) AS 'Total Qty'
FROM SalesLT.Product AS p
INNER JOIN SalesLT.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
INNER JOIN SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name, p.Name
ORDER BY 1, 2

--¿Cuántas unidades han sido vendidas por categoría, y por categoría-producto?
SELECT pc.Name AS 'Category', p.Name As 'Product', SUM(shd.OrderQty) AS 'Total Qty'
FROM SalesLT.SalesOrderHeader AS soh
INNER JOIN SalesLT.SalesOrderDetail AS shd ON soh.SalesOrderID = shd.SalesOrderID
INNER JOIN SalesLT.Product AS p ON shd.ProductID = p.ProductID
INNER JOIN SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY GROUPING SETS ((pc.Name), (pc.Name, p.Name))
ORDER BY 1, 2

--De la consulta anterior, descarta los grupos que tengan menos de 8 tickets de venta
SELECT pc.Name AS 'Category', p.Name As 'Product', SUM(shd.OrderQty) AS 'Total Qty'
FROM SalesLT.SalesOrderHeader AS soh
INNER JOIN SalesLT.SalesOrderDetail AS shd ON soh.SalesOrderID = shd.SalesOrderID
INNER JOIN SalesLT.Product AS p ON shd.ProductID = p.ProductID
INNER JOIN SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY GROUPING SETS ((pc.Name), (pc.Name, p.Name))
HAVING COUNT(DISTINCT soh.SalesOrderID) >= 8
ORDER BY 1, 2

--Lab 05
--ejemplos de funciones de ventana

SELECT p.ProductID, pc.Name AS 'Category', p.Name AS 'Product', p.[Size]

--ranking
, ROW_NUMBER() OVER (PARTITION BY p.ProductCategoryID ORDER BY p.Size) AS 'Row Number Per Category & Size'
, RANK() OVER (PARTITION BY p.ProductCategoryID ORDER BY p.Size) AS 'Rank Per Category & Size'
, DENSE_RANK() OVER (PARTITION BY p.ProductCategoryID ORDER BY p.Size) AS 'Dense Rank Per Category & Size'
, NTILE(2) OVER (PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'NTile Per Category & Name'

--aggregate
, SUM(p.StandardCost) OVER() AS 'Standard Cost Grand Total'
, SUM(p.StandardCost) OVER(PARTITION BY p.ProductCategoryID) AS 'Standard Cost Per Category'

--analytical
, LAG(p.Name, 1, '-- NOT FOUND --') OVER(PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'Previous Product Per Category'
, LEAD(p.Name, 1, '-- NOT FOUND --') OVER(PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'Next Product Per Category'
, FIRST_VALUE(p.Name) OVER(PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'First Product Per Category'
, LAST_VALUE(p.Name) OVER(PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'Last Product Per Category'
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
ORDER BY pc.Name, p.Name