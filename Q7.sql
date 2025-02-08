-- Retrieve monthly sales data for Nike products in Texas (TX) for the year 2015, specifically for purchase transactions ('P'). The results should include:
-- •	State (TX)
-- •	Sales Year
-- •	Sales Month
-- •	Nike Monthly Sales (formatted as currency)
-- •	Nike Cumulative Monthly Sales (running total across months)
-- The sales are grouped by month and sorted by year and month in ascending order. 
-- The cumulative sales column provides a progressive total of Nike sales over the months.


SELECT DISTINCT
        S.STATE,
        YEAR(T.TRAN_DATE) AS 'SalesYear',
        MONTH(T.TRAN_DATE) AS 'SalesMonth',
        FORMAT(SUM(T.TRAN_AMT) OVER (PARTITION BY MONTH(T.TRAN_DATE)), 'C') AS 'NikeMonthlySales',
        FORMAT(SUM(T.TRAN_AMT) OVER (ORDER BY MONTH(T.TRAN_DATE)), 'C') AS 'NikeCummulativeMonthlySales'
FROM
        TRANSACT T
JOIN
        SKU SK ON SK.SKU=T.SKU
JOIN
        DEPARTMENT D ON D.DEPT = SK.DEPT
JOIN
        STORE S ON S.STORE = T.STORE
WHERE
        S.STATE = 'TX'
        AND (D.DEPT_DESC LIKE 'NIKE%' OR LEFT(LTRIM(D.DEPT_DESC),4) = 'NIKE')
        AND YEAR(T.TRAN_DATE) = 2015
        AND T.TRAN_TYPE = 'P'
ORDER BY YEAR(T.TRAN_DATE), MONTH(T.TRAN_DATE);
