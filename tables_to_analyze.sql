/*
 * 1. Wage and food price data for the Czech Republic / table: t_petr_bela_project_SQL_primary_final table
 */

CREATE OR REPLACE TABLE t_petr_bela_project_SQL_primary_final AS
WITH czechia_price_data AS (
    SELECT
        YEAR(date_from) AS price_year,
        value,
        category_code
    FROM 
        czechia_price
),
summary_data AS (
    SELECT 
        cpay.payroll_year AS in_year,
        CONCAT(cpay.industry_branch_code, ' - ', cpib.name) AS types_of_industry,
        ROUND(AVG(cpay.value), 0) AS avg_payroll_in_czk,
        CONCAT(cprice.category_code, ' - ', cpricec.name) AS food_categories,
        cpricec.price_value,
        cpricec.price_unit,
        ROUND(AVG(cprice.value), 1) AS avg_price_of_food_in_czk
    FROM 
        czechia_payroll AS cpay 
    LEFT JOIN
        czechia_payroll_industry_branch AS cpib ON cpib.code = cpay.industry_branch_code 
    LEFT JOIN
        czechia_price_data AS cprice ON cprice.price_year = cpay.payroll_year
    LEFT JOIN 
        czechia_price_category AS cpricec ON cpricec.code = cprice.category_code
    WHERE
        cpay.industry_branch_code IS NOT NULL
        AND cpay.value_type_code = 5958 -- average gross wage
        AND cpay.unit_code = 200 -- wage IN CZK
        AND cpay.calculation_code = 200 -- calculated full-time wage
    GROUP BY
        cpay.industry_branch_code,
        cpay.payroll_year,
        cprice.category_code
)
SELECT * FROM summary_data;

SELECT * FROM t_petr_bela_project_SQL_primary_final;

-- finding the time period for the payment of wages -> 2000 - 2021
SELECT
	MIN(payroll_year) AS start_period,
	MAX(payroll_year) AS end_period
FROM czechia_payroll;

-- finding the time period for food category prices -> 2006 - 2018
SELECT 
	MIN(YEAR(date_from)) AS start_date_from,
	MIN(YEAR(date_to)) AS start_date_to,
	MAX(YEAR(date_from)) AS end_date_from,
	MAX(YEAR(date_to)) AS end_date_to
FROM czechia_price;

--  creating an index to speed up the query, but unfortunately even after adding these additional indexes the query did not speed up after adding the JOIN czechia_price, is there any way to speed it up?
-- localhost - 23sec
CREATE INDEX idx_date_from ON czechia_price (date_from);
CREATE INDEX idx_value ON czechia_price (value);

SHOW INDEXES FROM czechia_price;
