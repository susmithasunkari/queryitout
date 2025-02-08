-- Retrieve a distinct list of sweaters that match the following criteria:
-- •	Classification: 'SWEATER'
-- •	Color: 'NAVY'
-- •	Department Description: 'JONES SIGNATURE' or 'DANIEL CREMIEUX'
-- •	Department Detailed Description: 'CAREER'
-- •	Retail Price: ≤ $100
-- The result should include SKU, department description, department detailed description, color, retail price, and size. 
-- The output is sorted in descending order by department description and retail price.

SELECT
    SKU,
    DEPARTMENT_DESCRIPTION,
    DEPTDEC_DESC,
    COLOR,
    RETAIL_PRICE,
    SIZE
FROM (
    SELECT DISTINCT
        S.SKU,
        D.DEPT_DESC AS DEPARTMENT_DESCRIPTION,
        D.DEPTDEC_DESC,
        SK.COLOR,
        S.RETAIL AS RETAIL_PRICE,
        SK.SKU_SIZE AS SIZE
    FROM
        SKU_STORE S
    JOIN
        SKU SK ON S.SKU = SK.SKU
    JOIN
        DEPARTMENT D ON SK.DEPT = D.DEPT
    WHERE
        SK.CLASSIFICATION = 'SWEATER'
        AND SK.COLOR = 'NAVY'
        AND D.DEPTDEC_DESC = 'CAREER'
        AND S.RETAIL <= 100
        AND D.DEPT_DESC IN ('JONES SIGNATURE','DANIEL CREMIEUX')
) AS SUBQUERY
ORDER BY DEPARTMENT_DESCRIPTION DESC, RETAIL_PRICE DESC;
