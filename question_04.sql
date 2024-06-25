/*
 * 4.
 * Is there a year in which the annual increase in food prices was significantly higher than the increase in wages (greater than 10%)?
*/

SELECT * FROM t_petr_bela_project_SQL_primary_final;

SELECT
	in_year,
    ROUND(AVG(avg_price_of_food_in_czk), 2) AS avg_food_price,
    ROUND(
    	((AVG(avg_price_of_food_in_czk) / LAG(AVG(avg_price_of_food_in_czk)) OVER (ORDER BY in_year)) - 1) * 100, 2
    ) AS food_price_increase_percent,
    ROUND(AVG(avg_payroll_in_czk),0) AS avg_payroll,
    ROUND(
    	((AVG(avg_payroll_in_czk) / LAG(AVG(avg_payroll_in_czk)) OVER (ORDER BY in_year)) - 1) * 100, 2
    ) AS payroll_increase_percent,
    ROUND(
    	(((AVG(avg_price_of_food_in_czk) / LAG(AVG(avg_price_of_food_in_czk)) OVER (ORDER BY in_year)) - 1) * 100) - (((AVG(avg_payroll_in_czk) / LAG(AVG(avg_payroll_in_czk)) OVER (ORDER BY in_year)) - 1) * 100),2
    ) AS percent_diff
FROM t_petr_bela_project_SQL_primary_final
WHERE 
	in_year BETWEEN '2006' AND '2018'
GROUP BY
	in_year
ORDER BY
	in_year;