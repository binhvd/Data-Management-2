-- Dedupplication table is having only unique records

CREATE TABLE 
    data_management_2.demo3_dedupplication
AS SELECT DISTINCT
    Id, Title, FirstName, LastName, AddressId
FROM
    data_management_2.demo3_person
ORDER BY
    Id
	

-- Delete the record having NaN or Null Values for Address ID field in the Dedupplication table

DELETE FROM 
    data_management_2.demo3_dedupplication
WHERE
    AddressId IS NULL
	

-- 1) Join tables and populate into a new table with LEFT Join such that the Dedupplication (Person) table is on left and the Address table is on right
-- 2) Unselect the column 'Id' from the Address table as it dupplicates the AddressId of the Person table
-- 3) Rename the column 'Id' from the Dedupplication (Person) table with a relevant name i.e. Person Id
-- 4) Convert the First Name and Last Name columns into an Upper Case 
-- 5) Unselect records without an AddressId
-- 6) Only select records having Town as Heidelberg
-- 7) Filter records which are having firstname length greater than 5

CREATE TABLE
    data_management_2.demo3_output
AS SELECT 
    p.Id As PersonId, p.Title, UPPER(p.FirstName) as FirstName, UPPER(p.LastName) AS LastName, p.AddressId, a.Street, a.Town, a.Country, a.Postcode
FROM 
    `data_management_2.demo3_dedupplication` AS p
LEFT JOIN 
    `data_management_2.demo3_address` AS a
ON 
    p.AddressId = a.Id
WHERE 
    p.AddressId IS NOT NULL
AND
    a.Town = 'Heidelberg'
AND
   CHAR_LENGTH(p.FirstName) > 5 