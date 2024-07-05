/*
 * 5.
 * Does the level of GDP affect changes in wages and food prices? Or, if GDP rises more significantly in one year,
 * does this translate into a more significant rise in food prices or wages in the same or subsequent year?
*/

SELECT * FROM t_petr_bela_project_SQL_primary_final;

WITH payroll_food_data AS(
	SELECT 
		in_year AS year,
		ROUND(AVG(avg_payroll_in_czk), 0) AS average_payroll, -- across all industries
		ROUND(AVG(avg_price_of_food_in_czk), 2) AS average_food_price -- across all food categories
	FROM t_petr_bela_project_SQL_primary_final
	GROUP BY
		in_year
),
gdp_data AS(
	SELECT 
		country,
		`year`,
		GDP_in_billion,
		gini,
		population_in_million
	FROM t_petr_bela_project_SQL_secondary_final
	WHERE 
		country = 'Czech Republic'
),
combined_data AS (
	SELECT 
		pfd.year,
		pfd.average_payroll,
		pfd.average_food_price,
		gd.GDP_in_billion,
		gd.gini,
		gd.population_in_million
	FROM payroll_food_data AS pfd
	LEFT JOIN
		gdp_data AS gd ON pfd.YEAR = gd.YEAR
	ORDER BY 
		pfd.YEAR
),
percent_changes AS(
	SELECT
		year,
		average_payroll,
		LAG(average_payroll) OVER (ORDER BY year) AS prev_average_payroll,
		average_food_price,
		LAG(average_food_price) OVER (ORDER BY year) AS prev_average_food_price,
		GDP_in_billion,
		LAG(GDP_in_billion) OVER (ORDER BY year) AS prev_GDP_in_billion,
		gini,
		population_in_million,
		(average_payroll - LAG(average_payroll) OVER (ORDER BY year)) / LAG(average_payroll) OVER (ORDER BY year) * 100 AS percent_change_payroll,
		(average_food_price - LAG(average_food_price) OVER (ORDER BY year)) / LAG(average_food_price) OVER (ORDER BY year) * 100 AS percent_change_food_price,
		(GDP_in_billion - LAG(GDP_in_billion) OVER (ORDER BY year)) / LAG(GDP_in_billion) OVER (ORDER BY year) * 100 AS percent_change_GDP
	FROM combined_data
)
SELECT 
	year,
	average_payroll,
	average_food_price,
	GDP_in_billion,
	ROUND(percent_change_payroll, 2) AS percent_change_payroll,
	ROUND(percent_change_food_price, 2) AS percent_change_food_price,
	ROUND(percent_change_GDP, 2) AS percent_change_GDP,
	gini,
	population_in_million
FROM percent_changes
ORDER BY year;