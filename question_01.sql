-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

WITH ranked_data AS(
	SELECT 
		in_year,
		types_of_industry,
		avg_payroll_in_czk,
		LAG(avg_payroll_in_czk) OVER (PARTITION BY types_of_industry ORDER BY in_year) AS prev_avg_payroll_in_czk
	FROM t_petr_bela_project_SQL_primary_final
)
SELECT 
	in_year,
	types_of_industry,
	avg_payroll_in_czk,
	ROUND(((avg_payroll_in_czk - prev_avg_payroll_in_czk) / prev_avg_payroll_in_czk) * 100, 1) AS percent_change
FROM ranked_data
WHERE 
	prev_avg_payroll_in_czk IS NOT NULL
GROUP BY 
	types_of_industry,
	in_year
ORDER BY 
	types_of_industry,
	in_year;
	
