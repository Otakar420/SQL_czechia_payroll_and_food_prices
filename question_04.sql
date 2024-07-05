/*
 * 4.
 * Is there a year in which the annual increase in food prices was significantly higher than the increase in wages (greater than 10%)?
*/

SELECT * FROM t_petr_bela_project_SQL_primary_final;

WITH yearly_stats AS (
    SELECT
        in_year,
        ROUND(
        	AVG(avg_price_of_food_in_czk), 2
        ) AS avg_price_of_food_in_czk,
        ROUND(
        	AVG(avg_payroll_in_czk), 0
        ) AS avg_payroll_in_czk,
        LAG(AVG(avg_price_of_food_in_czk)) OVER (ORDER BY in_year) AS prev_avg_food_price,
        LAG(AVG(avg_payroll_in_czk)) OVER (ORDER BY in_year) AS prev_avg_payroll
    FROM t_petr_bela_project_SQL_primary_final
    WHERE in_year BETWEEN '2006' AND '2018'
    GROUP BY in_year
)
SELECT
    in_year,
    avg_price_of_food_in_czk AS avg_food_price,
    avg_payroll_in_czk AS avg_payroll,
    ROUND(
    	((avg_price_of_food_in_czk / prev_avg_food_price) - 1) * 100, 2
    ) AS food_price_increase_percent,
    ROUND(
    	((avg_payroll_in_czk / prev_avg_payroll) - 1) * 100, 2
    ) AS payroll_increase_percent,
    ROUND(
	    ABS(
	    	((avg_payroll_in_czk / prev_avg_payroll) - 1) * 100
	    ) - ABS(
	    	((avg_price_of_food_in_czk / prev_avg_food_price) - 1
	    ) * 100), 2
	) AS percent_diff
FROM yearly_stats
ORDER BY in_year;