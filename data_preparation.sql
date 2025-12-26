--DATA Preparation
SELECT purchase_time, signup_time
FROM data
LIMIT 10;

SELECT 
  signup_time,
  STR_TO_DATE(signup_time, '%d-%m-%Y %H:%i') AS signup_dt
FROM data
LIMIT 10;

SELECT 
  purchase_time,
  STR_TO_DATE(purchase_time, '%Y-%m-%d %H:%i:%s') AS purchase_dt
FROM data
LIMIT 10;

ALTER TABLE data
ADD COLUMN signup_time_dt DATETIME,
ADD COLUMN purchase_time_dt DATETIME;

UPDATE data
SET 
  signup_time_dt = STR_TO_DATE(signup_time, '%d-%m-%Y %H:%i'),
  purchase_time_dt = STR_TO_DATE(purchase_time, '%Y-%m-%d %H:%i:%s');

SELECT
  signup_time,
  signup_time_dt,
  purchase_time,
  purchase_time_dt
FROM data
LIMIT 10;

ALTER TABLE data
DROP COLUMN signup_time,
DROP COLUMN purchase_time;

ALTER TABLE data
CHANGE signup_time_dt signup_time DATETIME,
CHANGE purchase_time_dt purchase_time DATETIME;
