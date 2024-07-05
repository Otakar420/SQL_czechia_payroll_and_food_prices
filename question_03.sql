/*
 * 3.
 * Which food category is becoming more expensive at the slowest rate (has the lowest annual percentage increase)?
*/

SELECT * FROM t_petr_bela_project_SQL_primary_final;

WITH price_changes AS (
    SELECT
        in_year,
        food_categories,
        avg_price_of_food_in_czk,
        LAG(avg_price_of_food_in_czk) OVER(PARTITION BY food_categories ORDER BY in_year) AS prev_avg_price_of_food_in_czk
    FROM t_petr_bela_project_SQL_primary_final
    WHERE 
        in_year BETWEEN '2006' AND '2018'
        AND food_categories != '212101 - Jakostní víno bílé' -- without this, because wine has data only for the period 2015 to 2018
), price_changes_with_percent AS (
	SELECT 
		in_year,
	    food_categories,
	    avg_price_of_food_in_czk,
	    prev_avg_price_of_food_in_czk,
	    (avg_price_of_food_in_czk - prev_avg_price_of_food_in_czk) / prev_avg_price_of_food_in_czk * 100 AS price_change_percent
	FROM price_changes
)
SELECT 
    food_categories,
    ROUND(AVG(price_change_percent), 2) AS avg_percent_change
FROM price_changes_with_percent
GROUP BY 
    food_categories
ORDER BY
    avg_percent_change;

