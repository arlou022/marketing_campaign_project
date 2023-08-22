WITH incomes AS(
SELECT *
FROM public.customer
INNER JOIN public.campaign
ON public.customer.id = public.campaign.id
WHERE income < 100000 AND income >=10000
),
bins AS(
SELECT
    generate_series(10000, 77500, 22500) AS lower,
	generate_series(32500, 100000, 22500) AS upper
)
SELECT 
    lower AS lower_income_range,
	upper AS upper_income_range,
	(kid_home + teen_home) AS total_kids_home,
	COUNT(income) AS number_of_customers,
	SUM(COUNT(income)) OVER() AS total_number_of_customers,
	ROUND((COUNT(income)::numeric / SUM(COUNT(income)) OVER() ::numeric) * 100
		  , 0)
	AS percentage_of_customers,
	COUNT(income)::numeric * 6 AS total_number_of_cmp,
	
	(SUM(accepted_cmp_1) + SUM(accepted_cmp_2)
	+ SUM(accepted_cmp_3) + SUM(accepted_cmp_4)
	+ SUM(accepted_cmp_5) + SUM(response)) AS total_responses,
	
	ROUND(
	( (SUM(accepted_cmp_1) + SUM(accepted_cmp_2)
	+ SUM(accepted_cmp_3) + SUM(accepted_cmp_4)
	+ SUM(accepted_cmp_5) + SUM(response))::numeric 
	 / (COUNT(*)::numeric * 6) ) * 100 , 0) AS acceptance_rate
	
FROM bins
LEFT JOIN incomes
ON income >= lower
    AND income < upper
GROUP BY lower, upper, total_kids_home
ORDER BY lower, total_kids_home