-- Retrieve a list of employees who held the title "Brand Associate" and were hired between January 1, 2005, and December 31, 2010. 
-- The result should include their full name (concatenated as "Last Name, First Name") and email address, sorted alphabetically by last name and first name.

SELECT
    CONCAT(EMP_FNAME, ', ', EMP_LNAME) AS Full_Name,
    EMP_EMAIL AS Email_Address
FROM
    LG EMPLOYEE
WHERE
    EMP_TITLE = 'Brand Associate'
    AND EMP_HireDate BETWEEN '2005-01-01' AND '2010-12-31'
ORDER BY
    EMP_LNAME, EMP_FNAME;
