-- Visualization Queries 

-- Sales by month
SELECT  DISTINCT(dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0)) AS Month, 
	SUM([Total Excluding Tax]) OVER (PARTITION BY dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0)) AS [sales]
FROM WideWorldImportersDW.Fact.Sale
ORDER BY 1


--Avg sales per customer by month 
WITH Customer_Monthly_Sales (Month, Customer, Sales) AS 
(SELECT DISTINCT(dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0)) AS Month,
	[Customer Key],
	SUM([Total Excluding Tax]) OVER (PARTITION BY [Customer Key],dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0)) AS [sales]
FROM WideWorldImportersDW.Fact.sale	
)

SELECT Month, 
	AVG(Sales)
FROM Customer_Monthly_Sales
GROUP BY Month
ORDER BY 1,2

-- CREATE CATEGORIES
-- Create item category using CASE => use as filter, color, tooltip in viz 
--CREATE VIEW Item_Categories AS
(SELECT DISTINCT([Stock Item Key]),
	Description,
	CASE 
	WHEN [Total Chiller Items] > 0 THEN 'chiller' 
	WHEN Description LIKE '%slipper%' THEN 'slippers'
	WHEN Description LIKE '%jacket%' THEN 'jacket'
	WHEN Description LIKE '%hoodie%' THEN 'hoodie'
	WHEN Description LIKE '%marker%' THEN 'marker'
	WHEN Description LIKE '%sock%' THEN 'socks'
	WHEN Description LIKE '%shirt%' THEN 'shirt'
	WHEN Description LIKE '%action%' THEN 'action figure'
	WHEN Description LIKE '%mask%' THEN 'novelty mask'
	WHEN Description LIKE '%truck%' THEN 'toy car'
	WHEN Description LIKE '%car%' THEN 'toy car'
	WHEN Description LIKE '%coupe%' THEN 'toy car'
	WHEN Description LIKE '%periscope%' THEN 'periscope'
	WHEN Description LIKE '%usb%' THEN 'usb'
	WHEN Description LIKE '%mug%' THEN 'mug'
	WHEN Description LIKE '%void%' THEN 'packaging'
	WHEN Description LIKE '%film%' THEN 'packaging'
	WHEN Description LIKE '%blade%' THEN 'packaging'
	WHEN Description LIKE '%post%' THEN 'packaging'
	WHEN Description LIKE '%tape%' THEN 'packaging'
	WHEN Description LIKE '%shipping%' THEN 'packaging'
	WHEN Description LIKE '%bubble%' THEN 'packaging'
	WHEN Description LIKE '%machine%' THEN 'air cushion machine'
	ELSE NULL
	END AS Category
FROM WideWorldImportersDW.Fact.Sale);
SELECT *
FROM WideWorldImportersDW.Dimension.[Stock Item]

-- PROFIT QUERIES 

-- Sum profit by year 
SELECT  DISTINCT(DATEPART(year, [Invoice Date Key])) AS Year, 
	SUM(Profit) OVER (PARTITION BY  DATEPART(year, [Invoice Date Key])) AS Profit,
	SUM(Quantity) OVER (PARTITION BY  DATEPART(year, [Invoice Date Key])) AS [Units Sold]
FROM WideWorldImportersDW.Fact.Sale
ORDER BY 1


-- Sum profit by month
SELECT  DISTINCT(dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0)) AS Month, 
	SUM(profit) OVER (PARTITION BY dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0)) AS Profit,
	SUM(Quantity) OVER (PARTITION BY dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0)) AS [Units Sold]
FROM WideWorldImportersDW.Fact.Sale
ORDER BY 1

--Sum profit by item (all time) 
-- including packaging items ** add filter to viz to remove packaging items: bubble, air, void, tape
SELECT [Stock Item Key], [Description], SUM(profit) AS [Sum Profit], SUM(Quantity) AS [Sum Units Sold]
FROM WideWorldImportersDW.Fact.Sale
GROUP BY [Stock Item Key], [Description]
ORDER BY 1

-- Sum profit by year and item 
SELECT DISTINCT([Stock Item Key]), [Description], DATEPART(year, [Invoice Date Key]) AS Year,
	SUM(profit) OVER (PARTITION BY [Stock Item Key] ORDER BY [Stock Item Key], DATEPART(year, [Invoice Date Key])) AS [Profit],
	SUM(Quantity) OVER (PARTITION BY [Stock Item Key] ORDER BY [Stock Item Key], DATEPART(year, [Invoice Date Key])) AS [Units Sold]
FROM WideWorldImportersDW.Fact.Sale
ORDER BY 1 


-- CUSTOMER QUERIES

-- Top Customers by profit, qty items sold, and count of sales 
SELECT 
	DATEPART(year, [Invoice Date Key]) AS Year,
	c.customer AS Customer,
	c.[Buying Group],
	SUM(s.profit) AS Profit,
	SUM([Total Excluding Tax]) AS Sales,
	SUM(Quantity) AS Quantity,
	COUNT(([Sale Key])) AS [Count of Sales]
FROM TestWideWorldImportersDW.Fact.Sale AS s
JOIN TestWideWorldImportersDW.Dimension.Customer AS c
	ON s.[Customer Key] = c.[Customer Key]
GROUP BY DATEPART(year, [Invoice Date Key]), Customer, [Buying Group]
ORDER BY 4 DESC

-- Top customers by year 
-- ** decision on unknown customer issue: filter out here or filter out in viz? 
-- filter out would mean the profit would have huge mismatch
--2016
SELECT c.customer AS Customer,
	c.[Buying Group],
	SUM(s.profit) AS Profit,
	SUM(Quantity) AS Quantity,
	COUNT(([Sale Key])) AS Sales
FROM WideWorldImportersDW.Fact.Sale AS s
JOIN WideWorldImportersDW.Dimension.Customer AS c
	ON s.[Customer Key] = c.[Customer Key]
WHERE DATEPART(YEAR, [Invoice Date Key]) = 2016
GROUP BY Customer, [Buying Group]
ORDER BY 3

--2015
SELECT c.customer AS Customer,
	c.[Buying Group],
	SUM(s.profit) AS Profit,
	SUM(Quantity) AS Quantity,
	COUNT(([Sale Key])) AS Sales
FROM WideWorldImportersDW.Fact.Sale AS s
JOIN WideWorldImportersDW.Dimension.Customer AS c
	ON s.[Customer Key] = c.[Customer Key]
WHERE DATEPART(YEAR, [Invoice Date Key]) = 2015
GROUP BY Customer, [Buying Group]
ORDER BY 3

--2014
SELECT c.customer AS Customer,
	c.[Buying Group],
	SUM(s.profit) AS Profit,
	SUM(Quantity) AS Quantity,
	COUNT(([Sale Key])) AS Sales
FROM WideWorldImportersDW.Fact.Sale AS s
JOIN WideWorldImportersDW.Dimension.Customer AS c
	ON s.[Customer Key] = c.[Customer Key]
WHERE DATEPART(YEAR, [Invoice Date Key]) = 2014
GROUP BY Customer, [Buying Group]
ORDER BY 3 DESC 

--2013
SELECT c.customer AS Customer,
	c.[Buying Group],
	SUM(s.profit) AS Profit,
	SUM(Quantity) AS Quantity,
	COUNT(([Sale Key])) AS Sales
FROM WideWorldImportersDW.Fact.Sale AS s
JOIN WideWorldImportersDW.Dimension.Customer AS c
	ON s.[Customer Key] = c.[Customer Key]
WHERE DATEPART(YEAR, [Invoice Date Key]) = 2013
GROUP BY Customer, [Buying Group]
ORDER BY 3 DESC



-- CHILLER QUERIES

-- Chiller v Dry CTEs
-- Note: in viz, add calc field: percent of profit for dry and chiller (i.e. c4/c4+c5)
-- months with chiller: 2016 1,2,3,4,5 
-- line, perhaps filter only 2016 
WITH chiller ([Sale Key], Profit, [Total Chiller Items]) AS (
SELECT [Sale Key], Profit, [Total Chiller Items]
FROM WideWorldImportersDW.Fact.Sale
WHERE [Total Chiller Items] > 0
),

dry ([Sale Key], Profit, [Total Dry Items]) AS (
SELECT [Sale Key], Profit, [Total Dry Items]
FROM WideWorldImportersDW.Fact.Sale
WHERE [Total Dry Items] > 0
)

SELECT DISTINCT(dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0))
	,SUM(sale.[Total Chiller Items]) OVER (PARTITION BY dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0) ORDER BY dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0)) AS [Chiller Items]
	,SUM(sale.[Total Dry Items]) OVER (PARTITION BY dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0) ORDER BY dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0)) AS [Dry Items]
	,SUM(dry.Profit) OVER (PARTITION BY dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0) ORDER BY dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0)) AS [Dry Profit]
	,SUM(chiller.Profit) OVER (PARTITION BY dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0) ORDER BY dateadd(MONTH, datediff(MONTH, 0, [Invoice Date Key]), 0)) AS [Chiller Profit]
FROM WideWorldImportersDW.Fact.Sale AS sale
LEFT JOIN dry ON dry.[Sale Key] = sale.[Sale Key]
LEFT JOIN chiller ON chiller.[Sale Key] = sale.[Sale Key]
ORDER BY 1


-- Chiller top products
-- pie or bars 
SELECT 
	[Stock Item Key],
	[description],
	SUM(profit) AS Profit,
	SUM(Quantity) AS Quantity,
	COUNT([Sale Key]) AS Sales
FROM TestWideWorldImportersDW.Fact.Sale 
WHERE [Total Chiller Items] > 0
GROUP BY [Stock Item Key], Description
ORDER BY 2 DESC

-- Dry top products 
-- pie or bars 
SELECT 
	[Stock Item Key],
	[description],
	SUM(profit) AS Profit,
	SUM(Quantity) AS Quantity,
	COUNT([Sale Key]) AS Sales
FROM TestWideWorldImportersDW.Fact.Sale 
WHERE [Total Dry Items] > 0
GROUP BY [Stock Item Key], Description
ORDER BY 2 DESC


-- are all sales either dry or chiller? => yes confirmed 
SELECT *
FROM WideWorldImportersDW.Fact.Sale
WHERE [Total Dry Items] = 0 AND [Total Chiller Items] = 0