-- Replace invalid value present in the columns with Null values

UPDATE
    data_management_2.demo5_movie_details
SET
    Occupation = null
WHERE
    Occupation = "11413";

UPDATE
    data_management_2.demo5_movie_details
SET
    Title = null
WHERE
    Title = "1682";

UPDATE
    data_management_2.demo5_movie_details
SET
    Genres = null
WHERE
    Genres = "1523648" OR Genres = "1 - 000 - 000 Duck (1971)";

UPDATE
    data_management_2.demo5_movie_details
SET
    Ratings = null
WHERE
    Ratings = "Super";
	
	
-- Select records without empty or null values for any of the column from the source tables and populate into a new table 

CREATE TABLE 
    data_management_2.demo5_preprocessed
AS SELECT
    *
FROM
    data_management_2.demo5_movie_details
WHERE
    User_ID IS NOT NULL AND
    Gender != '' AND
    Zip_Code IS NOT NULL AND		
    Occupation != '' AND
    Age_Min_Value IS NOT NULL AND	
    Age_Max_Value IS NOT NULL AND		
    Movie_ID IS NOT NULL AND
    Title != '' AND
    Ratings != '' AND
    TimeStamp != '' AND
    Genres != ''
	
	
-- Select columns which are relevant to user information from the Preprocessed table and populate it into a new table

CREATE TABLE 
    data_management_2.demo5_users
AS SELECT DISTINCT
    User_ID,
    Gender,
    Zip_Code,
    Occupation,
    Age_Min_Value,
    Age_Max_Value
FROM
    data_management_2.demo5_preprocessed
ORDER BY
    User_ID
	
	
-- Select columns which are relevant to user information from the Preprocessed table and populate it into a new table

CREATE TABLE 
    data_management_2.demo5_movies
AS SELECT DISTINCT
    Movie_ID,
    Title,
    Genres
FROM
    data_management_2.demo5_preprocessed
ORDER BY
    Movie_ID

	
-- Select columns which are relevant to user information from the Preprocessed table and populate it into a new table
-- This will fail because there are still String values in Timestamp

CREATE TABLE 
    data_management_2.demo5_ratings
AS SELECT DISTINCT
    User_ID
    Movie_ID,
    CAST(Ratings AS INT64) AS Ratings,
    CAST(TimeStamp AS INT64) AS TimeStamp
FROM
    data_management_2.demo5_preprocessed
ORDER BY
    User_ID, Movie_ID
	

-- Find records that have a Timestamp longer than it should be

SELECT 
    *
FROM
    data_management_2.demo5_preprocessed
WHERE
    LENGTH(TimeStamp) > 10
	
	
-- Delete records with dirty Timestamps

DELETE FROM
    data_management_2.demo5_preprocessed
WHERE
    LENGTH(TimeStamp) > 10
	
	
