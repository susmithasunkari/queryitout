-- Retrieve the total purchase amount (formatted as currency) for the year 2015 in stores located in Houston and Dallas, Texas (TX), for transactions of type 'P' (Purchases). 
-- The results should include:
-- •	City (or 'ALL' when aggregated for all cities)
-- •	Month (or 'ALL' when aggregated for all months)
-- •	Total purchase amount
-- The data is grouped using ROLLUP to provide both detailed and summary-level insights and is sorted in descending order by city and month.


SELECT
    'TX' AS States,
    CASE
        WHEN GROUPING(S.CITY) = 1 THEN 'ALL'
        ELSE S.CITY
    END AS Cities,
    CASE
        WHEN GROUPING(MONTH(T.TRAN_DATE)) = 1 THEN 'ALL'
        ELSE CAST(MONTH(T.TRAN_DATE) AS VARCHAR(2))
    END AS MonthYear,
    FORMAT(SUM(T.TRAN_AMT), 'C') AS TotalPurchaseAmount2015
FROM
    STORE S
JOIN
    TRANSACT T ON S.STORE = T.STORE
WHERE
    S.STATE = 'TX'
    AND S.CITY IN ('HOUSTON', 'DALLAS')
    AND YEAR(T.TRAN_DATE) = 2015
    AND T.TRAN_TYPE = 'P'
GROUP BY ROLLUP(S.CITY, MONTH(T.TRAN_DATE))
ORDER BY S.CITY DESC, MONTH(T.TRAN_DATE);
