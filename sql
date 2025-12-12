-- Data Analysis
SELECT *
FROM dataset;

--Monthly fraud/legit counts (by purchase month)
SELECT
	month(purchase_time) AS month,
    COUNT(CASE WHEN class = '0' THEN 1 ELSE NULL END) 'LEGIT',
    COUNT(CASE WHEN class = '1' THEN 1 ELSE NULL END) 'FRAUD'
FROM dataset
GROUP BY month(purchase_time)
ORDER BY month ASC;

--Daily signup fraud/legit counts (by day of month)
SELECT
    day(signup_time) AS day,
    COUNT(CASE WHEN class = '0' THEN 1 ELSE NULL END) 'LEGIT',
    COUNT(CASE WHEN class = '1' THEN 1 ELSE NULL END) 'FRAUD'
FROM dataset
GROUP BY day(signup_time)
ORDER BY day ASC;

--Distribution of days between signup and purchase
SELECT 
      DATEDIFF(purchase_time, signup_time) AS day_diff,
      COUNT(CASE WHEN class = '0' THEN 1 ELSE NULL END) 'LEGIT',
	  COUNT(CASE WHEN class = '1' THEN 1 ELSE NULL END) 'FRAUD'
FROM dataset
GROUP BY DATEDIFF(purchase_time, signup_time)
ORDER BY day_diff ASC;

--Min & Max purchase value
SELECT MIN(purchase_value), MAX(purchase_value)
FROM dataset;

--Purchase value buckets (CTE) — fraud by bucket
WITH CTE AS (
    SELECT
        CASE 
            WHEN purchase_value >= 9  AND purchase_value <= 10  THEN '9-10'
            WHEN purchase_value > 10  AND purchase_value <= 20  THEN '11-20'
            WHEN purchase_value > 20  AND purchase_value <= 30  THEN '21-30'
            WHEN purchase_value > 30  AND purchase_value <= 40  THEN '31-40'
            WHEN purchase_value > 40  AND purchase_value <= 50  THEN '41-50'
            WHEN purchase_value > 50  AND purchase_value <= 60  THEN '51-60'
            WHEN purchase_value > 60  AND purchase_value <= 70  THEN '61-70'
            WHEN purchase_value > 70  AND purchase_value <= 80  THEN '71-80'
            WHEN purchase_value > 80  AND purchase_value <= 90  THEN '81-90'
            WHEN purchase_value > 90  AND purchase_value <= 100 THEN '91-100'
            WHEN purchase_value > 100 AND purchase_value <= 110 THEN '101-110'
            WHEN purchase_value > 110 AND purchase_value <= 120 THEN '111-120'
            WHEN purchase_value > 120 AND purchase_value <= 130 THEN '121-130'
            WHEN purchase_value > 130 AND purchase_value <= 140 THEN '131-140'
            WHEN purchase_value > 140 AND purchase_value <= 150 THEN '141-150'
            WHEN purchase_value > 150 AND purchase_value <= 160 THEN '151-160'
            ELSE NULL
        END AS purchase_value_group, class
    FROM dataset
)
SELECT 
      purchase_value_group,
      COUNT(CASE WHEN class = '0' THEN 1 ELSE NULL END) AS 'LEGIT',
      COUNT(CASE WHEN class = '1' THEN 1 ELSE NULL END) AS 'FRAUD'
FROM CTE
GROUP BY purchase_value_group
ORDER BY FRAUD DESC; 

--Check minimum and maximum age
SELECT MIN(age), MAX(age)
FROM dataset;

--Age buckets (CTE) — fraud by age group
WITH CTE AS (
     SELECT 
		CASE 
            WHEN age >=18 AND age <=25 THEN '18-25'
            WHEN age > 25 AND age <=30 THEN '26-30'
            WHEN age > 30 AND age <=35 THEN '31-35'
            WHEN age > 35 AND age <=40 THEN '36-40'
            WHEN age > 40 AND age <=45 THEN '41-45'
            WHEN age > 45 AND age <=50 THEN '46-50'
            WHEN age > 50 AND age <=55 THEN '51-55'
            WHEN age > 55 AND age <=60 THEN '56-60'
            WHEN age > 60 AND age <=65 THEN '61-65'
            WHEN age > 65 AND age <=70 THEN '66-70'
            WHEN age > 70 AND age <=75 THEN '71-75'
            WHEN age > 75 AND age <=80 THEN '76-80'
	  ELSE NULL END AS age_group, class
	FROM dataset
)
SELECT 
     age_group,
     COUNT(CASE WHEN class = '0' THEN 1 ELSE NULL END) AS 'LEGIT',
     COUNT(CASE WHEN class = '1' THEN 1 ELSE NULL END) AS 'FRAUD'
FROM CTE
GROUP BY age_group
ORDER BY FRAUD DESC;

--Fraud percent by source
SELECT 
	 source,
	 COUNT(CASE WHEN class = '1' THEN 1 ELSE NULL END)*1.0/COUNT(*) AS fraudulent_transaction_percent
FROM dataset
GROUP BY source;

--Fraud/legit counts by gender
SELECT 
     sex,
     COUNT(CASE WHEN class = '0' THEN 1 ELSE NULL END) AS 'LEGIT',
     COUNT(CASE WHEN class = '1' THEN 1 ELSE NULL END) AS 'FRAUD'
FROM dataset
GROUP BY sex;

-- Final test — recent signup to purchase (DIRECT source) fraud percent
SELECT 
      month(signup_time) AS month,
      source,
       COUNT(CASE WHEN class = '0' THEN 1 ELSE NULL END) AS legit_transaction,
       COUNT(CASE WHEN class = '1' THEN 1 ELSE NULL END) AS fraudulent_transaction,
       ROUND(SUM(CASE WHEN class = '1' THEN 1 ELSE NULL END)*1.0/COUNT(*)*100,2) AS fraudulent_transaction_percent
FROM dataset
WHERE datediff(signup_time, purchase_time) <1
AND source = 'DIRECT' AND month(signup_time) <2
GROUP BY month(signup_time),source
ORDER BY month ASC;
