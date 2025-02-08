-- Retrieve the total purchase amount (in dollars) per year for stores located in the state of Texas (TX). 
-- The results should include the state, year of transaction, and total purchase amount, considering only transactions of type 'P' (Purchase). 
-- The data should be grouped by state and year and ordered chronologically by year.

SELECT
    S.State,
    YEAR(T.TRAN_DATE) AS Year,
    SUM(T.TRAN_AMT) AS TotalPurchaseAmountIn$
FROM
    STORE S
JOIN
    TRANSACT T ON S.STORE = T.STORE
WHERE
    S.STATE = 'TX'
    AND T.TRAN_TYPE = 'P'
GROUP BY
    S.STATE,
    YEAR(T.TRAN_DATE)
ORDER BY
    YEAR(T.TRAN_DATE);
