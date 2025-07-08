CREATE DATABASE churn_db;
USE churn_db;

CREATE TABLE customers (
    RowNumber INT,
    CustomerId INT PRIMARY KEY,
    Surname VARCHAR(50),
    CreditScore INT,
    Geography VARCHAR(50),
    Gender VARCHAR(10),
    Age FLOAT,
    Tenure INT,
    Balance FLOAT,
    NumOfProducts INT,
    HasCrCard FLOAT,
    IsActiveMember FLOAT,
    EstimatedSalary FLOAT,
    Exited INT 
);


SELECT * FROM customers LIMIT 10;


-- Total Customers and Churned Customers
SELECT 
   COUNT(*) AS total_customers,
   SUM(Exited) AS total_churned
FROM customers;
/* This query counts the total number of customers and how many of them have churned (Exited = 1) */


-- Churn Rate by Country
SELECT Geography,
       COUNT(*) AS total,
       SUM(Exited) AS churned,
       ROUND(SUM(Exited)/COUNT(*)*100, 2) AS churn_rate
FROM customers
GROUP BY Geography;
/*  Calculates the churn rate (percentage) for each country by dividing churned customers by total customers per country  */


-- Churn Rate by Gender
SELECT Gender, COUNT(*) AS total, SUM(Exited) AS churned,
       ROUND(SUM(Exited)/COUNT(*)*100, 2) AS churn_rate
FROM customers
GROUP BY Gender;
 /*  Calculates the churn rate separtely for male and female customers to check if gender impacts churn */  


-- Churn Rate by Age Group    
SELECT
  CASE
     WHEN Age < 30 THEN 'Under 30'
     WHEN Age BETWEEN 30 AND 50 THEN '30-50'
     ELSE 'Over 50'
  END AS age_group,
  COUNT(*) AS total,
  SUM(Exited) AS churned,
  ROUND(SUM(Exited)/COUNT(*)*100, 2) AS churn_rate
FROM customers
GROUP BY age_group;
/*  Groups customers into three age categories (under30, 30-50, over 50) and shows the churn rate for each */


-- Churn Rate by Account Balance
SELECT 
  CASE
    WHEN Balance = 0 THEN 'Zero'
    WHEN Balance BETWEEN 1 AND 50000 THEN 'Low'
    WHEN Balance BETWEEN 50001 AND 100000 THEN 'Medium'
     ELSE 'High'
  END AS balance_group,
  COUNT(*) AS total,
  SUM(Exited) AS churned,
  ROUND(SUM(Exited)/COUNT(*)*100, 2) AS churn_rate
FROM customers
GROUP BY balance_group;
/* Groups customers by their balance level (Zero, Low, Medium, High) and shows the churn rate per group */


-- Churn Rate by Active Status
SELECT IsActiveMember,
       COUNT(*) AS churned,
       SUM(Exited) AS churned,
       ROUND(SUM(Exited)/COUNT(*)*100, 2) as churn_rate
FROM customers
GROUP BY IsActiveMember;
/* Shows churn rate based on whether customers are active or not (IsActiveMember = 1 or 0) */


-- Churn Rate by Number of Products
SELECT NumOfProducts,
       COUNT(*) AS total,
       SUM(Exited) AS churned,
       ROUND(SUM(Exited)/COUNT(*)*100, 2) AS churn_rate
FROM customers
GROUP BY NumOfProducts;
/*  Calculates churn rate based on how many products the customer has with the bank */


-- Correlation btw age & balance for churned customers
SELECT Age, Balance
FROM customers
WHERE Exited = 1;
/* Displays age and balance only for churned customers (Exited = 1) to check if there's a pattern or relationship */


-- Churn rate trend by customer tenure
SELECT Tenure, ROUND(SUM(Exited)/COUNT(*)*100, 2) AS churn_rate
FROM customers
GROUP BY Tenure
ORDER BY Tenure;
/* Shows how churn rate changes with customer tenture (number of years with the bank)  */


/* Displays age and credit score of churned customers to explore if churn is linked with these features */
-- Age vs credit score for churned customers
SELECT Age, CreditScore
FROM customers
WHERE Exited = 1;




