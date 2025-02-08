-- Retrieve a distinct list of customers who purchased products from the brand "Foresters Best" in the "Primer" 
-- category between July 15, 2017, and July 31, 2017. The results should include the 
-- customer's first name, last name, street address, city, state, and ZIP code, sorted by state, last name, and first name.

SELECT DISTINCT
    C.CUST_FNAME AS FirstName,
    C.CUST_LNAME AS LastName,
    C.CUST_STREET AS Street,
    C.CUST_CITY AS City,
    C.CUST_STATE AS State,
    C.CUST_ZIP AS ZipCode
FROM
    LGCUSTOMER AS C
INNER JOIN
    LGINVOICE AS I ON C.CUST_CODE = I.CUST_CODE
INNER JOIN
    LGLINE AS L ON I.INV_NUM = L.INV_NUM
INNER JOIN
    LGPRODUCT AS P ON L.PROD_SKU = P.PROD_SKU
INNER JOIN
    LGBRAND AS B ON P.BRAND_ID = B.BRAND_ID
WHERE
    B.BRAND_NAME = 'Foresters Best'
    AND P.PROD_CATEGORY = 'Primer'
    AND I.INV_DATE BETWEEN '2017-07-15' AND '2017-07-31'
ORDER BY
    C.CUST_STATE, C.CUST_LNAME, C.CUST_FNAME;
