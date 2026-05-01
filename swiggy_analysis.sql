-- ============================================
-- SWIGGY CUSTOMER BEHAVIOR ANALYSIS
-- ============================================
# Swiggy Data Analysis - A Food Delivery Company


## Overview

This project demonstrates my SQL problem-solving skills through the analysis of data for Swiggy, 
a popular food delivery company in India. The project involves setting up the Database, Importing data, 
Handling null values, and Solving a variety of business problems using complex SQL queries, Creating Stored 
Procedures, Query Optimization and generatiing Insights and Actionable recommendation.

## Project Structure

- **Database Setup:** Creation of the `Swiggy_db` database and the required tables.
- **Data Import:** Inserting sample data into the tables.
- **Data Cleaning:** Handling null values and ensuring data integrity.
- **Business Problems:** Solving 20 specific business problems using SQL queries.
- **Stored Procedure:** Creating Stored Procedures
- **Query Optimization:** Optimized the queries using index and best practices

-- 1. DATA CLEANING

SELECT * FROM swiggy_data

--data validation & cleaning
--NULL check
SELECT
     SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END ) AS null_state,
     SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END ) AS null_city,
     SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END )AS null_Order_date,
     SUM(CASE WHEN Restaurant_Name IS NULL THEN 1 ELSE 0 END)AS null_Restaurant_Name,
     SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS null_Location,
     SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS null_Category,
     SUM(CASE WHEN Dish_Name IS NULL THEN 1 ELSE 0 END)AS null_Dish_Name,
     SUM(CASE WHEN Price_INR IS NULL THEN 1 ELSE 0 END)AS null_Price_INR,
     SUM(CASE WHEN Rating IS NULL THEN 1 ELSE 0 END ) AS null_Rating,
     SUM(CASE WHEN Rating_Count IS NULL THEN 1 ELSE 0 END )AS null_Rating_Count
FROM swiggy_data;

SELECT * FROM swiggy_data
   WHERE State = '' OR State IS NULL
     OR City = ''OR City IS NULL
     OR Order_date IS NULL
     OR Restaurant_Name = '' OR Restaurant_Name IS NULL
     OR Location ='' OR Location IS NULL
     OR Category = '' OR Category IS NULL
     OR Dish_Name ='' OR Dish_Name IS NULL
     OR Price_INR IS NULL
     OR Rating IS NULL
     OR Rating_Count IS NULL;

-- REMOVE DUPLICATES
--duplicate detection

SELECT 
State ,City,Order_date,Restaurant_Name,Location,Category,Dish_Name,Price_INR,Rating,Rating_count, COUNT(*) AS CNT
FROM swiggy_data
GROUP BY
State ,City,Order_date,Restaurant_Name,Location,Category,Dish_Name,Price_INR,Rating,Rating_count
HAVING COUNT(*)>1;

WITH CTE AS(
SELECT * , ROW_NUMBER()Over
( PARTITION BY State ,City,Order_date,Restaurant_Name,Location,
Category,Dish_Name,Price_INR,Rating,Rating_count
ORDER BY (SELECT NULL) )as rn
FROM swiggy_data
)
DELETE FROM CTE WHERE rn >1;
--creating  schema
--------Star Schema(dimaensional modelling)
--DATE TABLE 

IF OBJECT_ID('dim_date','U') IS NOT NULL
DROP TABLE dim_date;


CREATE TABLE dim_date (
date_id  INT IDENTITY(1,1)  PRIMARY KEY ,
FULL_DATE DATE ,
YEAR INT,
MONTH INT,
Month_Name VARCHAR(20),
Quarter INT,
Day INT,
Week INT )

SELECT * FROM dim_date;

--dim_location
IF OBJECT_ID('dim_location','U') IS NOT NULL
DROP TABLE dim_location;

CREATE TABLE  dim_location (
 Location_id INT IDENTITY(1,1) PRIMARY KEY ,
 Sate VARCHAR(100) ,
 City VARCHAR(100),
 Location VARCHAR(200)
 )



 SELECT * FROM dim_location;

 --dim_restaurant
 IF OBJECT_ID('dim_restaurant','U') IS NOT NULL
DROP TABLE dim_restaurant; 

 CREATE TABLE  dim_restaurant(
  restaurant_id  INT IDENTITY(1,1) PRIMARY KEY,
  Restaurant_Name VARCHAR(300) 
  )

  SELECT* FROM dim_restaurant;
 
--dim_category
IF OBJECT_ID('dim_category','U') IS NOT NULL
DROP TABLE dim_category;
CREATE TABLE dim_category(
  category_id INT IDENTITY(1,1) PRIMARY KEY ,
  Category VARCHAR (200)
  )

  SELECT * FROM  dim_category;

--dim_dish
IF OBJECT_ID('dim_dish','U') IS NOT NULL
DROP TABLE dim_dish;
CREATE TABLE dim_dish(
 dish_id INT IDENTITY(1,1) PRIMARY KEY ,
 Dish_Name VARCHAR(500)
 )

 SELECT * FROM dim_dish;

SELECT * FROM swiggy_data;

--Create fact table

IF OBJECT_ID('fact_swigge_orders','U') IS NOT NULL
DROP TABLE fact_swigge_orders;

CREATE TABLE fact_swigge_orders(
order_id INT IDENTITY(1,1) PRIMARY KEY ,

date_id INT,
price_INR DECIMAL(10,2),
Rating DECIMAL(4,2),
Rating_count INT,

location_id INT,
restayrant_id INT,
category_id INT,
dish_id INT,

FOREIGN KEY (date_id) REFERENCES dim_date (date_id),
FOREIGN KEY ( restayrant_id ) REFERENCES dim_restaurant (restaurant_id),
FOREIGN KEY ( location_id) REFERENCES dim_location (location_id),
FOREIGN KEY (category_id) REFERENCES dim_category  (category_id),
FOREIGN KEY (dish_id) REFERENCES dim_dish(dish_id)
);


SELECT * FROM fact_swigge_orders;

--INSERT DATA THIS TABLE
--dim date  

INSERT INTO dim_date(full_Date, year , Month, Month_Name , Quarter , Day, Week)
SELECT DISTINCT 
    Order_Date,
    YEAR(Order_Date),
    MONTH(Order_Date),
    DATENAME(MONTH, Order_Date),
    DATEPART(QUARTER, Order_Date),
    DAY(Order_Date),
    DATEPART(WEEK, Order_Date)
FROM swiggy_data
WHERE Order_Date IS NOT NULL;


SELECT * FROM swiggy_data;

SELECT * FROM dim_date;

--dim_location

INSERT INTO dim_location (Sate,City,Location)
SELECT DISTINCT 
    State ,
    City,
    Location
FROM swiggy_data;
 
EXEC sp_rename 'dim_location.State', 'State', 'COLUMN';

--EXEC sp_rename 'dim_location.State', 'Sate', 'COLUMN';
 
SELECT * FROM dim_location;
 
 --dim_restaurant
INSERT INTO dim_restaurant ( restaurant_Name)
SELECT DISTINCT
   restaurant_Name
FROM swiggy_data;

SELECT * FROM dim_restaurant;

SELECT * FROM swiggy_data;

--dim_category
INSERT INTO dim_category(category)
SELECT DISTINCT 
   category
FROM swiggy_data;

SELECT * FROM swiggy_data;

SELECT * FROM dim_category;

--dim_dish
INSERT INTO dim_dish(Dish_Name)
SELECT DISTINCT 
   Dish_Name
FROM swiggy_data;

SELECT * FROM swiggy_data;

SELECT * FROM  dim_dish;

INSERT INTO dim_dish(Dish_Name)
SELECT DISTINCT 
   Dish_Name
FROM swiggy_data;

ALTER TABLE dim_dish
ALTER COLUMN Dish_Name VARCHAR(1000);

SELECT * FROM swiggy_data;
SELECT * FROM dim_dish;



SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_restaurant';


-- fact_table
INSERT INTO fact_swigge_orders(
date_id,
price_INR,
Rating,
Rating_Count,
restayrant_id,
Location_id,
category_id,
dish_id
)
SELECT 
  dd.date_id,
  s.price_INR,
  s.rating,
  s.rating_count,

  dr.restaurant_id,
  dl.location_id,
  dc.category_id,
  dsh.dish_id
FROM swiggy_data s

JOIN dim_date dd
 ON dd.full_Date=s.Order_Date

JOIN dim_location dl
 ON dl.City = s.City
 AND dl.state=s.state
 AND dl.location =s.Location

JOIN dim_restaurant dr
 ON dr.Restaurant_Name = s.Restaurant_Name
 

JOIN dim_category dc
 ON dc.Category = s.Category

JOIN dim_dish dsh
 ON dsh.Dish_Name=s.Dish_Name


SELECT COUNT(*) 
FROM fact_swigge_orders;

SELECT * FROM fact_swigge_orders;


--inner join using (alises)

SELECT * 
FROM fact_swigge_orders f
JOIN dim_date   d   ON f.date_id=d.date_id
JOIN dim_location  l ON f.location_id=l.location_id
JOIN dim_restaurant  r ON f.restayrant_id = r.restaurant_id
JOIN dim_category  c ON f.category_id = c.category_id
JOIN dim_dish   di  ON f.dish_id = di.dish_id


SELECT * FROM fact_swigge_orders;

--KPI'S 
--Total orders

SELECT COUNT(*) AS total_orders
FROM fact_swigge_orders;

--Total Revenue ( INR Million)
SELECT  SUM(price_INR)/1000000 AS total_revenue
FROM fact_swigge_orders ;

SELECT FORMAT(SUM(CONVERT(FLOAT,price_INR))/1000000,'N2') + 'INR Million' AS total_revenue
FROM fact_swigge_orders;

--Average dish price 
SELECT 
AVG(price_INR) AS Average_dish_price
FROM fact_swigge_orders;

SELECT FORMAT(AVG(CONVERT(FLOAT,price_INR)) ,'N2') + 'INR Million' AS total_revenue
FROM fact_swigge_orders;

--Average Rating 
SELECT  
AVG( Rating) AS Average_ranting
FROM fact_swigge_orders;


--Granular Requirments
--Deep Dive Business Analysis

--Monthly order

SELECT 
  d.YEAR,
  d.MONTH,
  d.month_name,
  count(*) as total_orders
  FROM fact_swigge_orders f
  JOIN dim_date d  ON f.date_id=d.date_Id
  GROUP BY d.YEAR,
  d.MONTH,
  d.month_name 
  ORDER BY COUNT(*) DESC; --ALL DATA IS DESC ORDER

  --Quertaerly Order
  
  SELECT 
  d.YEAR,
  d.quarter,
  COUNT(*) AS total_order
  FROM fact_swigge_orders f
  JOIN dim_date d ON f.date_id = d.date_id
  GROUP BY d.year , d.quarter
  ORDER BY d.year , d.quarter DESC;


--yearly 
  SELECT 
  d.YEAR,
  COUNT(*) AS total_order
  FROM fact_swigge_orders f
  JOIN dim_date d ON f.date_id = d.date_id
  GROUP BY d.YEAR;

  --order by day of week (mon-sun)
SELECT
    DATENAME (WEEKDAY, d.full_date) AS day_name ,
    COUNT(*) AS total_orders
FROM fact_swigge_orders f
JOIN dim_date d ON  f.date_id = d.date_id
GROUP BY DATENAME (WEEKDAY,d.FULL_DATE ),DATEPART (WEEKDAY,d.FULL_DATE)
ORDER BY DATEPART ( WEEKDAY,d.FULL_DATE);

--  BUSINESS ANALYSIS
----Location Based Analysis


--TOP 10 CITIES BY ORDER VOLUME (DESC)
SELECT TOP 10
l.city,
count(*) AS total_order
FROM fact_swigge_orders f
JOIN dim_location l ON l.location_id = f.location_id
GROUP BY l.city
ORDER BY COUNT(*) ASC;

SELECT TOP 10 
l.City,
COUNT(*) AS total_orders
FROM fact_swigge_orders f
JOIN dim_location l ON l.location_id = f.location_id
GROUP BY l.City
ORDER BY COUNT(*) DESC;


--top 10 restaurant by order

SELECT TOP 10
r.restaurant_name,
SUM(f.price_INR) AS total_revenue 
FROM fact_swigge_orders f
JOIN dim_restaurant r ON f.restayrant_id =r.restaurant_id
GROUP BY r.restaurant_name
ORDER BY SUM(f.price_INR) DESC;

--Top categories (Indian, Chinese, etc.)
SELECT 
     c.Category,
     COUNT(*) AS TOATL_ORDER
FROM fact_swigge_orders f
JOIN dim_category c ON f.category_id =c.category_id
GROUP BY c.Category
ORDER BY COUNT(*) DESC;

--

--	Most ordered dishes

SELECT 
 d.dish_name,
COUNT(*) AS total_order
FROM fact_swigge_orders f
JOIN dim_dish d ON f.dish_id = d.dish_id
GROUP BY  d.dish_name
ORDER BY  COUNT(*) DESC;

--Cuisine performance → Orders + Avg Rating
SELECT 
 c.category ,
   COUNT(*) AS total_order,
   AVG(f.rating) AS avg_rating
FROM fact_swigge_orders f
JOIN dim_category c ON f.category_id = c.category_id
GROUP BY c.category
ORDER BY total_order DESC;

-- Price Analysis
--Customer Spending Insights
SELECT 
  CASE  
     WHEN price_INR < 100 THEN 'Under100'
     WHEN price_INR BETWEEN 100 AND 199 THEN '100-199'
     WHEN price_INR BETWEEN 200 AND 299 THEN '200-299'
     WHEN price_INR BETWEEN 300 AND 399 THEN '300-399'
     WHEN price_INR BETWEEN 400 AND 499 THEN '400-499'
     ELSE '500+'
  END AS price_range,
  
  COUNT(*) AS total_order

FROM fact_swigge_orders

GROUP BY 
  CASE  
     WHEN price_INR < 100 THEN 'Under100'
     WHEN price_INR BETWEEN 100 AND 199 THEN '100-199'
     WHEN price_INR BETWEEN 200 AND 299 THEN '200-299'
     WHEN price_INR BETWEEN 300 AND 399 THEN '300-399'
     WHEN price_INR BETWEEN 400 AND 499 THEN '400-499'
     ELSE '500+'
  END

ORDER BY total_order DESC;


--Ratings Analysis


SELECT 
Rating,
COUNT(*) AS total_order
FROM fact_swigge_orders
GROUP BY  Rating
ORDER BY COUNT(*) DESC;

