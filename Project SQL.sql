Create Database Games;
Use Games;

SET SQL_SAFE_UPDATES=0;

-- Adding First_Availibility from consoledates in date format --

Alter table consoledates
add column First_Availibility date;


Update consoledates
Set First_Availibility = str_to_date(FirstRetailAvailability,"%Y-%m-%e");

-- Adding Discontinued_Date from consoledates in date format --

Alter table consoledates
add column Discontinued_Date date;

UPDATE consoledates
SET Discontinued_Date = IF(LENGTH(Discontinued) > 0, STR_TO_DATE(Discontinued, '%Y-%m-%e'), NULL);


Describe consoledates;

Select *
From consoledates;

-- Calculate what % of global sales were made in north america--

      
SELECT (NorthAmericaSales.total_NA_sales / GlobalSales.Total_Sales) * 100 AS percentage
FROM
  (SELECT SUM(NA_Sales) AS total_NA_sales FROM consolegames) AS NorthAmericaSales,
  (SELECT SUM(EU_Sales + NA_Sales + JP_Sales + Other_Sales) AS Total_Sales FROM consolegames) AS GlobalSales;
  
  SELECT SUM(NA_Sales) AS total_NA_sales FROM consolegames;
  
  SELECT SUM(EU_Sales + NA_Sales + JP_Sales + Other_Sales) AS Total_Sales FROM consolegames;

  

  
  
  -- Extract a view of console games titles orderd by platfom name in ascendng order and  --
  -- year of release in desc order --
  
Select name, Platform, Year
From consolegames
order by Platform asc, Year desc;
  
  -- for each game title extract the first four letter of the publiser name--
  
SELECT Name, Publisher, LEFT(Publisher, 4) AS extracted_Publisher
FROM consolegames;
  
-- Display all control platforms which were released  --
--  on christmas eve on any year --

SELECT *
FROM consoledates
WHERE Day(First_Availibility) = 24
  AND MONTH(First_Availibility) = 12;
  
  -- Order the platform by longetivity by asc order- 
  
Select Platform, DATEDIFF(Discontinued_Date,First_Availibility) AS num_days
From consoledates
Order by num_days;

-- Demonstrate how to deal with the Game_Year Column if the client wants 
-- to convert to a different data type

ALTER TABLE consolegames
MODIFY COLUMN Year new_data_type;




-- Provide recommendation on how to deal with missing data in the file--

-- Assigning default values: If the missing data is expected to have a specific default value, 
-- we can use the COALESCE() function or the IFNULL() function to replace the missing values with a default date. 
-- For example:

SELECT COALESCE(Discontinued_Date, '2023-01-01') AS modified_date
FROM consoledates;








  


  
  










