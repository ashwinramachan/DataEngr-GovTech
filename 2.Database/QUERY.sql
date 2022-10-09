-- 1. I want to know the list of our customers and their spending.

SELECT A.customerID, B.customer_name, SUM(sales_price) TOTAL_SPENDING
FROM CarSales.dbo.sale_transaction A
INNER JOIN CarSales.dbo.customer B ON B.customerID = A.customerID
GROUP BY A.customerID,B.customer_name

--2. I want to find out the top 3 car manufacturers that customers bought by sales (quantity) 
--		and the sales number for it in the current month.
SELECT TOT.manufacturerID, M.manufacturer, TOT.sales_Qty, TOT.ROWNUM
FROM (
	SELECT manufacturerID, sum(sales_Qty)sales_Qty, RANK() OVER (ORDER BY sum(sales_Qty) DESC) ROWNUM
	FROM (SELECT *, RANK() OVER (PARTITION BY salesID ORDER BY salesID ) sales_Qty
	FROM CarSales.dbo.sale_transaction
	--WHERE LEFT(CONVERT(VARCHAR,SaleDateTime,112),6) = LEFT(CONVERT(VARCHAR,GETDATE(),112),6)
	WHERE DATEPART (YEAR, SaleDateTime)  = DATEPART (YEAR, GETDATE()) 
	AND DATEPART (MONTH, SaleDateTime)  = DATEPART (MONTH, GETDATE()) 
	)A
	GROUP BY manufacturerID
)TOT 
INNER JOIN  car_manufacturer M ON (M.manufacturerID = TOT.manufacturerID)
WHERE ROWNUM <= 3 
