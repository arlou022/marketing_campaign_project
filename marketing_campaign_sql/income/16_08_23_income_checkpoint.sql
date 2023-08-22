SELECT *
FROM public.campaign
INNER JOIN public.customer
ON public.campaign.id = public.customer.id

SELECT
    MAX(income),
	MIN(income)
FROM public.customer

SELECT
    COUNT(income)
FROM public.customer
WHERE income < 100000 AND income >=10000


-- Max income is 666666 and min income is 1730.
-- 2174/2240 = 97% of customers have 5 figure incomes and
-- 66/2240 = 3% of customers have incomes less than 5 figures 
-- or 6 figure incomes.


SELECT COUNT(income)
FROM public.customer
WHERE income >100000 AND income <=100050



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
GROUP BY lower, upper
ORDER BY lower


-- Inspection
SELECT 
    income,
    accepted_cmp_1,
	accepted_cmp_2,
	accepted_cmp_3,
	accepted_cmp_4,
	accepted_cmp_5,
	response
FROM public.campaign
INNER JOIN public.customer
ON public.campaign.id = public.customer.id
WHERE income > 77500 AND income < 100000





    