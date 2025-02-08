-- Retrieve yearly sales data for stores in Texas (TX) for the years 2014 and 2015, specifically for purchase transactions ('P'). The results should include:
-- •	Store ID
-- •	State
-- •	City
-- •	Sales Year
-- •	Current Year Sales (formatted as currency)
-- •	Last Year Sales (formatted as currency, showing sales from the previous year for the same store, or 'NA' if not available)
-- •	Change in Total Yearly Sales (difference between current year and last year sales, formatted as currency, or 'NA' if previous year sales are not available)
-- The query uses LAG() to fetch the previous year's sales for comparison, and the results are grouped by store, city, and year, sorted in ascending order by store, city, and sales year.

SELECT
        S.STORE AS 'Stores',
        S.STATE AS 'States',
        S.CITY AS 'Cities',
        YEAR(T.TRAN_DATE) AS 'SalesYear',
        FORMAT(SUM(T.TRAN_AMT), 'C') AS 'CurrentYearSales',
        COALESCE(LAG(FORMAT(SUM(T.TRAN_AMT), 'C'),1,NULL) OVER (PARTITION BY S.STORE ORDER BY YEAR(T.TRAN_DATE)), 'NA') AS 'LastYearSales',
        COALESCE(FORMAT(SUM(T.TRAN_AMT)-LAG(SUM(T.TRAN_AMT),1,NULL) OVER (PARTITION BY S.STORE ORDER BY YEAR(T.TRAN_DATE)), 'C'), 'NA') AS 'ChangeInTotalYearlySales'
FROM TRANSACT T
JOIN STORE S ON T.STORE=S.STORE
WHERE
        YEAR(T.TRAN_DATE) IN (2014,2015)
        AND T.TRAN_TYPE = 'P'
        AND S.STATE = 'TX'
GROUP BY S.STORE, S.STATE, S.CITY, YEAR(T.TRAN_DATE)
ORDER BY S.STORE,S.CITY, YEAR(T.TRAN_DATE);
