/*
 * 2.
 * How many litres of milk and kilograms of bread can be bought in the first and last comparable period in the available price and wage data?
*/

SELECT * FROM t_petr_bela_project_SQL_primary_final;

SELECT 
	in_year,
	food_categories,
	avg_price_of_food_in_czk,
	ROUND(AVG(avg_payroll_in_czk), 0) AS avg_payroll_across_all_industries,
	CONCAT(
	    ROUND(
	        price_value * (ROUND(AVG(avg_payroll_in_czk)) / avg_price_of_food_in_czk), 2),
	        ' ', price_unit
	) AS food_purchase
FROM t_petr_bela_project_SQL_primary_final
WHERE 
	in_year IN ('2006', '2018') -- first and last period
	AND food_categories IN ('114201 - Mléko polotučné pasterované', '111301 - Chléb konzumní kmínový')
GROUP BY
	in_year,
	food_categories
ORDER BY
	food_categories, 
	in_year;
