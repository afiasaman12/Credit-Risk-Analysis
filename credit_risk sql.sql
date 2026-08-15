CREATE DATABASE credit_risk;
USE credit_risk;

CREATE TABLE credit_risk_data(
	customer_id INT auto_increment PRIMARY KEY,
    person_age INT,
    person_income INT,
    person_home_ownership VARCHAR(20),
    person_emp_length INT,
    loan_intent VARCHAR(30),
    loan_grade VARCHAR(5),
    loan_amnt INT,
    loan_int_rate DECIMAL(5,2),
    loan_status INT,
    loan_percent_income DECIMAL(5,2),
    cb_person_default_on_file VARCHAR(5),
    cb_person_cred_hist_length INT
);
    
SHOW databases;
USE credit_risk;

SELECT COUNT(*) AS rows_imported
FROM credit_risk_data;

SHOW VARIABLES LIKE 'local_infile';


SET GLOBAL local_infile = 1;
 DESCRIBE credit_risk_data;
 
 USE credit_risk;

LOAD DATA LOCAL INFILE 'C:/Users/Masood/Downloads/archive (32)/credit_risk_dataset.csv'
INTO TABLE credit_risk_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    person_age,
    person_income,
    person_home_ownership,
    person_emp_length,
    loan_intent,
    loan_grade,
    loan_amnt,
    loan_int_rate,
    loan_status,
    loan_percent_income,
    cb_person_default_on_file,
    cb_person_cred_hist_length
);

SELECT *
FROM credit_risk_data
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    SUM(person_age IS NULL) AS missing_age,
    SUM(person_income IS NULL) AS missing_income,
    SUM(person_home_ownership IS NULL) AS missing_home_ownership,
    SUM(person_emp_length IS NULL) AS missing_emp_length,
    SUM(loan_intent IS NULL) AS missing_loan_intent,
    SUM(loan_grade IS NULL) AS missing_loan_grade,
    SUM(loan_amnt IS NULL) AS missing_loan_amount,
    SUM(loan_int_rate IS NULL) AS missing_interest_rate,
    SUM(loan_status IS NULL) AS missing_loan_status,
    SUM(loan_percent_income IS NULL) AS missing_loan_percent_income,
    SUM(cb_person_default_on_file IS NULL) AS missing_previous_default,
    SUM(cb_person_cred_hist_length IS NULL) AS missing_credit_history
FROM credit_risk_data;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT 
        CONCAT(
            person_age, '|',
            person_income, '|',
            person_home_ownership, '|',
            person_emp_length, '|',
            loan_intent, '|',
            loan_grade, '|',
            loan_amnt, '|',
            loan_int_rate, '|',
            loan_status, '|',
            loan_percent_income, '|',
            cb_person_default_on_file, '|',
            cb_person_cred_hist_length
        )
    ) AS unique_records
FROM credit_risk_data;

SELECT 
    person_age,
    person_income,
    person_home_ownership,
    person_emp_length,
    loan_intent,
    loan_grade,
    loan_amnt,
    loan_int_rate,
    loan_status,
    loan_percent_income,
    cb_person_default_on_file,
    cb_person_cred_hist_length,
    COUNT(*) AS duplicate_count
FROM credit_risk_data
GROUP BY 
    person_age,
    person_income,
    person_home_ownership,
    person_emp_length,
    loan_intent,
    loan_grade,
    loan_amnt,
    loan_int_rate,
    loan_status,
    loan_percent_income,
    cb_person_default_on_file,
    cb_person_cred_hist_length
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

CREATE TABLE credit_risk_clean LIKE credit_risk_data;
INSERT INTO credit_risk_clean (
    person_age,
    person_income,
    person_home_ownership,
    person_emp_length,
    loan_intent,
    loan_grade,
    loan_amnt,
    loan_int_rate,
    loan_status,
    loan_percent_income,
    cb_person_default_on_file,
    cb_person_cred_hist_length
)
SELECT DISTINCT
    person_age,
    person_income,
    person_home_ownership,
    person_emp_length,
    loan_intent,
    loan_grade,
    loan_amnt,
    loan_int_rate,
    loan_status,
    loan_percent_income,
    cb_person_default_on_file,
    cb_person_cred_hist_length
FROM credit_risk_data;

SELECT COUNT(*) AS clean_rows
FROM credit_risk_clean;

SELECT 
    MIN(person_emp_length) AS minimum_emp_length,
    MAX(person_emp_length) AS maximum_emp_length
FROM credit_risk_clean;
SELECT 
    person_emp_length,
    COUNT(*) AS number_of_records
FROM credit_risk_clean
GROUP BY person_emp_length
ORDER BY person_emp_length;

SELECT 
    person_emp_length,
    COUNT(*) AS number_of_records
FROM credit_risk_clean
WHERE person_emp_length > 10
GROUP BY person_emp_length
ORDER BY person_emp_length;

SELECT 
    person_emp_length,
    COUNT(*) AS number_of_records
FROM credit_risk_clean
WHERE person_emp_length > 27
GROUP BY person_emp_length
ORDER BY person_emp_length;

SELECT COUNT(*) AS suspicious_records
FROM credit_risk_clean
WHERE person_emp_length > person_age;

SELECT 
    MIN(person_age) AS minimum_age,
    MAX(person_age) AS maximum_age,
    MIN(person_emp_length) AS minimum_emp_length,
    MAX(person_emp_length) AS maximum_emp_length
FROM credit_risk_clean;

SELECT
    person_age,
    COUNT(*) AS number_of_records
FROM credit_risk_clean
WHERE person_age > 100
GROUP BY person_age
ORDER BY person_age;

SELECT
    person_age,
    person_emp_length,
    COUNT(*) AS number_of_records
FROM credit_risk_clean
WHERE person_emp_length > 40
GROUP BY person_age, person_emp_length
ORDER BY person_emp_length DESC;

SELECT
    person_age,
    COUNT(*) AS number_of_records
FROM credit_risk_clean
WHERE person_age > 100
GROUP BY person_age
ORDER BY person_age;

UPDATE credit_risk_clean
SET person_age = NULL
WHERE person_age > 100;

SET SQL_SAFE_UPDATES = 0;

UPDATE your_table
SET column_name = value;

SELECT DATABASE();
USE credit_risk;

SHOW TABLES;

SELECT COUNT(*) AS total_rows
FROM credit_risk_data;

SELECT *
FROM credit_risk_data
LIMIT 10;
SHOW TABLES;
DESCRIBE credit_risk_data;
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN person_age IS NULL THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN person_income IS NULL THEN 1 ELSE 0 END) AS null_income,
    SUM(CASE WHEN credit_score IS NULL THEN 1 ELSE 0 END) AS null_credit_score
FROM credit_risk_data;

SELECT
    COUNT(*) AS total_records,
    SUM(person_income IS NULL) AS null_income,
    SUM(person_home_ownership IS NULL) AS null_home_ownership,
    SUM(person_emp_length IS NULL) AS null_emp_length,
    SUM(person_age IS NULL) AS null_age,
    SUM(loan_status IS NULL) AS null_loan_status,
    SUM(loan_percent_income IS NULL) AS null_percent_income,
    SUM(loan_intent IS NULL) AS null_loan_intent,
    SUM(loan_int_rate IS NULL) AS null_interest_rate,
    SUM(loan_grade IS NULL) AS null_loan_grade,
    SUM(loan_amnt IS NULL) AS null_loan_amount,
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(cb_person_default_on_file IS NULL) AS null_default,
    SUM(cb_person_cred_hist_length IS NULL) AS null_credit_history
FROM credit_risk_data;

SELECT customer_id, COUNT(*)
FROM credit_risk_data
GROUP BY customer_id
HAVING COUNT(*)>1;

SELECT loan_status, COUNT(*)
FROM credit_risk_data
GROUP BY loan_status;

SELECT
COUNT(*) AS total_loans,
SUM(CASE WHEN loan_status=1 THEN 1 ELSE 0 END) AS defaulted_loans,
ROUND(
	SUM(CASE WHEN loan_status=1 THEN 1 ELSE 0 END)/ COUNT(*)*100,2) AS percent_loans

FROM credit_risk_data;

SELECT loan_grade, COUNT(*) AS count_grade,
SUM(CASE WHEN loan_status=1 THEN 1 ELSE 0 END) AS defaulted_loan
FROM credit_risk_data
GROUP BY loan_grade;

SELECT
    loan_grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS default_rate
FROM credit_risk_data
GROUP BY loan_grade;

SELECT loan_intent, COUNT(*) AS total_loans,
SUM(CASE WHEN loan_status=1 THEN 1 ELSE 0 END) AS defaulted_loans,
ROUND(
	SUM(CASE WHEN loan_status=1 THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS defaulted_rate
FROM credit_risk_data
GROUP BY loan_intent;

SELECT loan_amnt,
CASE
	WHEN loan_amnt<5000 THEN 'BELOW 5K'
    WHEN loan_amnt >= 5000 AND loan_amnt < 10000 THEN '5K-10K'
    WHEN loan_amnt >= 10000 AND loan_amnt < 15000 THEN '10K-15K'
    WHEN loan_amnt >= 15000 AND loan_amnt < 20000 THEN '15K-20K'
    ELSE '20K+'
    END AS loan_category
FROM credit_risk_data;

SELECT
    CASE
        WHEN loan_amnt < 5000 THEN 'BELOW 5K'
        WHEN loan_amnt >= 5000 AND loan_amnt < 10000 THEN '5K-10K'
        WHEN loan_amnt >= 10000 AND loan_amnt < 15000 THEN '10K-15K'
        WHEN loan_amnt >= 15000 AND loan_amnt < 20000 THEN '15K-20K'
        ELSE '20K+'
    END AS loan_category,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status=1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
		SUM(CASE WHEN loan_status=1 THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS defaulted_rate
FROM credit_risk_data
GROUP BY loan_category;

SELECT
    CASE
        WHEN loan_percent_income < 0.10 THEN 'Below 10%'
        WHEN loan_percent_income < 0.20 THEN '10%-20%'
        WHEN loan_percent_income < 0.30 THEN '20%-30%'
        WHEN loan_percent_income < 0.40 THEN '30%-40%'
        ELSE '40%+'
    END AS income_burden,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS default_rate
FROM credit_risk_data
GROUP BY income_burden
ORDER BY default_rate DESC;

SELECT
    CASE
        WHEN loan_int_rate < 8 THEN 'Below 8%'
        WHEN loan_int_rate < 12 THEN '8%-12%'
        WHEN loan_int_rate < 16 THEN '12%-16%'
        WHEN loan_int_rate < 20 THEN '16%-20%'
        ELSE '20%+'
    END AS interest_category,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS default_rate
FROM credit_risk_data
GROUP BY interest_category
ORDER BY default_rate DESC;

SELECT
    person_home_ownership,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS default_rate
FROM credit_risk_data
GROUP BY person_home_ownership
ORDER BY default_rate DESC;

SELECT
    CASE
        WHEN person_emp_length < 3 THEN '0-2 years'
        WHEN person_emp_length < 6 THEN '3-5 years'
        WHEN person_emp_length < 11 THEN '6-10 years'
        ELSE '10+ years'
    END AS employment_category,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS default_rate
FROM credit_risk_data
GROUP BY employment_category
ORDER BY default_rate DESC;

SELECT
    CASE
        WHEN cb_person_cred_hist_length < 3 THEN 'Below 3 years'
        WHEN cb_person_cred_hist_length < 6 THEN '3-5 years'
        WHEN cb_person_cred_hist_length < 11 THEN '6-10 years'
        WHEN cb_person_cred_hist_length < 16 THEN '10-15 years'
        ELSE '15+ years'
    END AS credit_history_category,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS default_rate
FROM credit_risk_data
GROUP BY credit_history_category
ORDER BY default_rate DESC;

SELECT
    CASE
        WHEN person_income < 25000 THEN 'Below 25K'
        WHEN person_income < 50000 THEN '25K-50K'
        WHEN person_income < 75000 THEN '50K-75K'
        WHEN person_income < 100000 THEN '75K-100K'
        ELSE '100K+'
    END AS income_category,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS default_rate
FROM credit_risk_data
GROUP BY income_category
ORDER BY default_rate DESC;

SELECT customer_id, loan_percent_income, loan_status
FROM credit_risk_data
WHERE loan_status = 1
AND loan_percent_income > (
    SELECT AVG(loan_percent_income)
    FROM credit_risk_data
);

SELECT
    customer_id,
    loan_percent_income,
    loan_int_rate,
    loan_status
FROM credit_risk_data
WHERE loan_status = 1
AND loan_percent_income > (
    SELECT AVG(loan_percent_income)
    FROM credit_risk_data
)
AND loan_int_rate > (
    SELECT AVG(loan_int_rate)
    FROM credit_risk_data
);

WITH high_risk AS (
    SELECT
        customer_id,
        loan_percent_income,
        loan_int_rate
    FROM credit_risk_data
    WHERE loan_status = 1
)
SELECT
    COUNT(*) AS defaulted_customers,
    ROUND(AVG(loan_percent_income), 2) AS avg_loan_burden,
    ROUND(AVG(loan_int_rate), 2) AS avg_interest_rate
FROM high_risk;

SELECT customer_id, loan_amnt,loan_status,
ROW_NUMBER() OVER (ORDER BY loan_amnt DESC) AS loan_rank
FROM credit_risk_data;

WITH ranked_customers AS (
    SELECT
        customer_id,
        loan_amnt,
        loan_percent_income,
        loan_int_rate,
        loan_status,
        ROW_NUMBER() OVER (ORDER BY loan_amnt DESC) AS loan_rank
    FROM credit_risk_data
)
SELECT
    customer_id,
    loan_amnt,
    loan_percent_income,
    loan_int_rate,
    loan_status,
    loan_rank
FROM ranked_customers
WHERE loan_status = 1
  AND loan_rank <= 10;
  
  SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN loan_status IS NULL THEN 1 ELSE 0 END) AS missing_loan_status,
    SUM(CASE WHEN loan_amnt IS NULL THEN 1 ELSE 0 END) AS missing_loan_amount,
    SUM(CASE WHEN person_income IS NULL THEN 1 ELSE 0 END) AS missing_income
FROM credit_risk_data;