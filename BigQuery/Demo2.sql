-- Extract duplicate records from the Masters table into a new table

CREATE TABLE 
    data_management_2.demo2_dupplication
AS SELECT
    *
FROM
    data_management_2.demo2_masters
GROUP BY
    ID, Lname, Fname, Name
HAVING 
    COUNT(*) > 1


-- Remove duplicate records based on ID from the Masters table keeping only the records with the smallest ID

DELETE FROM 
    data_management_2.demo2_masters
WHERE ID NOT IN (
    SELECT MIN(ID) FROM
        data_management_2.demo2_masters
    GROUP BY
        ID, Lname, Fname, Name
)


-- Dedupplication table is having only unique records

CREATE TABLE 
    data_management_2.demo2_dedupplication
AS SELECT DISTINCT
    ID, Lname, Fname, Name
FROM
    data_management_2.demo2_masters
	
	
-- Join tables with RIGHT Join such that Master table is on left and Country Code table is on right

SELECT 
    * 
FROM 
    data_management_2.demo2_masters AS m
RIGHT JOIN 
    data_management_2.demo2_country_code AS c
ON 
    m.ID = c.ID
	
	
-- Join tables with LEFT Join such that Master table is on left and Country Code table is on right	

SELECT 
    * 
FROM 
    data_management_2.demo2_masters AS m
LEFT JOIN 
    data_management_2.demo2_country_code AS c
ON 
    m.ID = c.ID
	
	
-- Join tables and populate into a new table with LEFT Join such that Master table is on left and Country Code table is on right

CREATE TABLE 
    data_management_2.demo2_output
AS SELECT 
    m.ID, Lname, Fname, Country 
FROM 
    data_management_2.demo2_masters AS m
LEFT JOIN 
    data_management_2.demo2_country_code AS c
ON 
    m.ID = c.ID
