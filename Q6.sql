-- Retrieve a list of customers in Austin, Texas (TX) who have purchased both Chanel and Armani perfumes/colognes. The result should include:
-- •	Customer ID
-- •	City
-- •	State
-- •	Zip Code
-- The query uses an INTERSECT operation to ensure only customers who have purchased perfumes/colognes from both Chanel and Armani are included. 
-- The results are sorted in ascending order by zip code.



SELECT
    C.CUST_ID AS CustomerID,
    C.CITY AS City,
    C.STATE AS State,
    C.ZIP_CODE AS Zipcode
FROM
    CUSTOMER C
JOIN
    TRANSACT T ON C.CUST_ID = T.CUST_ID
JOIN
    SKU SKU ON T.SKU = SKU.SKU
JOIN
    DEPARTMENT D ON SKU.DEPT = D.DEPT
WHERE
    C.CITY = 'AUSTIN'
    AND C.STATE = 'TX'
    AND T.TRAN_TYPE = 'P'
      AND SKU.CLASSIFICATION = 'Perfume/Cologne'
    AND D.DEPT_DESC LIKE '%CHANEL%'
INTERSECT
SELECT
    C.CUST_ID AS CustomerID,
    C.CITY AS City,
    C.STATE AS State,
    C.ZIP_CODE AS Zipcode
FROM
    CUSTOMER C
JOIN
    TRANSACT T ON C.CUST_ID = T.CUST_ID
JOIN
    SKU SKU ON T.SKU = SKU.SKU
JOIN
    DEPARTMENT D ON SKU.DEPT = D.DEPT
WHERE
    C.CITY = 'AUSTIN'
    AND C.STATE = 'TX'
    AND T.TRAN_TYPE = 'P'
      AND SKU.CLASSIFICATION = 'Perfume/Cologne'
    AND D.DEPT_DESC LIKE '%ARMANI%'
ORDER BY
    C.ZIP_CODE ASC;
