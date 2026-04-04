--Data Exploration
SELECT * FROM customer_churn LIMIT 10;

--Total customers
SELECT COUNT(*) AS Total_customers 
FROM customer_churn;

--Overall Churn Rate
SELECT 
ROUND(COUNT(CASE WHEN churn='Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn;

--Churn Distribution 
SELECT churn, Count(*) AS total_customers
FROm customer_churn
Group by churn
ORDER BY total_customers DESC;

-- Churn Rate by Contract Type
SELECT contract, COUNT(*) AS total_customers, 
COUNT(CASE WHEN churn='Yes' THEN 1 END) AS churned_customers, 
ROUND(COUNT(CASE WHEN churn='Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS churn_rate 
FROM customer_churn GROUP BY contract 
ORDER BY churn_rate DESC;

-- Churn rate by InternetService
SELECT internetservice,
ROUND(COUNT(CASE WHEN churn='Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn
GROUP BY internetservice
ORDER BY churn_rate DESC;

-- Churn rate by PaymentMethod
SELECT 
paymentmethod,
ROUND(COUNT(CASE WHEN churn='Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn
GROUP BY paymentmethod
ORDER BY churn_rate DESC;

--Top 5 tenure groups with Highest churn

SELECT 
CASE
WHEN tenure <= 12 THEN '0-12 Months'
WHEN tenure <= 24 THEN '13-24 Months'
WHEN tenure <= 48 THEN '25-48 Months'
ELSE '49+ Months'
END AS tenure_group,
COUNT(*) AS total_customers,
ROUND(COUNT(CASE WHEN churn='Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn
GROUP BY tenure_group
ORDER BY churn_rate DESC;

-- Total Revenue Lost Due To Churn
SELECT 
ROUND(SUM(CASE WHEN churn='Yes' THEN monthlycharges END),2) AS revenue_lost
FROM customer_churn;

-- Average Tenure of Churned vs Retained Customers
SELECT churn,
ROUND(AVG(tenure),2) As average_tenure
FROM customer_churn
GROUP by churn;

-- Premium Customers
SELECT customerid, monthlycharges
FROM customer_churn
ORDER BY monthlycharges DESC
LIMIT 10;

--Services that reduce churn
SELECT techsupport,
ROUND(COUNT(CASE WHEN churn='Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn
GROUP BY techsupport;

-- Churn by Monthly Charges
SELECT 
CASE
WHEN monthlycharges < 40 THEN 'Low Cost'
WHEN monthlycharges < 80 THEN 'Medium Cost'
ELSE 'High Cost'
END AS price_category,
ROUND(COUNT(CASE WHEN churn='Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn
GROUP BY price_category
ORDER BY churn_rate DESC;

-- Churn by Multiple Factors
SELECT contract, internetservice,
ROUND(COUNT(CASE WHEN churn='Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn
GROUP BY contract, internetservice
ORDER BY churn_rate DESC;

-- Customer Segmentation
SELECT gender, seniorcitizen,
ROUND(COUNT(CASE WHEN churn='Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS churn_rate
FROM customer_churn
GROUP BY gender, seniorcitizen;

--High Risk Customers
SELECT customerid, tenure, monthlycharges
FROM customer_churn
WHERE churn='Yes'
AND tenure < 12
ORDER BY monthlycharges DESC;

