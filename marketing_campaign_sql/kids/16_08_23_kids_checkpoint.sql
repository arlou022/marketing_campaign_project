SELECT *
FROM public.campaign
INNER JOIN public.customer
ON public.campaign.id = public.customer.id


WITH full_table AS(
SELECT *
FROM public.campaign
INNER JOIN public.customer
ON public.campaign.id = public.customer.id
)
SELECT
    (kid_home + teen_home) AS total_kids_home,
	COUNT(*) AS number_of_customers,
	SUM(accepted_cmp_1) AS cmp_1_responses,
	SUM(accepted_cmp_2) AS cmp_2_responses,
	SUM(accepted_cmp_3) AS cmp_3_responses,
	SUM(accepted_cmp_4) AS cmp_4_responses,
	SUM(accepted_cmp_5) AS cmp_5_responses,
	SUM(response) AS cmp_last_responses,
	
	(SUM(accepted_cmp_1) + SUM(accepted_cmp_2)
	+ SUM(accepted_cmp_3) + SUM(accepted_cmp_4)
	+ SUM(accepted_cmp_5) + SUM(response)) AS total_response_all_cmp
FROM full_table
GROUP BY total_kids_home
ORDER BY total_kids_home



WITH kids_cmp_data AS(
WITH full_table AS(
SELECT *
FROM public.campaign
INNER JOIN public.customer
ON public.campaign.id = public.customer.id
)
SELECT
    (kid_home + teen_home) AS total_kids_home,
	COUNT(*) AS number_of_customers,
	SUM(accepted_cmp_1) AS cmp_1_responses,
	SUM(accepted_cmp_2) AS cmp_2_responses,
	SUM(accepted_cmp_3) AS cmp_3_responses,
	SUM(accepted_cmp_4) AS cmp_4_responses,
	SUM(accepted_cmp_5) AS cmp_5_responses,
	SUM(response) AS cmp_last_responses,
	
	(SUM(accepted_cmp_1) + SUM(accepted_cmp_2)
	+ SUM(accepted_cmp_3) + SUM(accepted_cmp_4)
	+ SUM(accepted_cmp_5) + SUM(response)) AS total_response_all_cmp
FROM full_table
GROUP BY total_kids_home
ORDER BY total_kids_home
)
SELECT   
    total_kids_home,
	number_of_customers,
	
	ROUND(
	(cmp_1_responses :: numeric / number_of_customers :: numeric) * 100 , 0)
	AS cmp_1_acceptance_rate,
	
	ROUND(
	(cmp_2_responses :: numeric / number_of_customers :: numeric) * 100 , 0)
	AS cmp_2_acceptance_rate,
	
	ROUND(
	(cmp_3_responses :: numeric / number_of_customers :: numeric) * 100 , 0)
	AS cmp_3_acceptance_rate,
	
	ROUND(
	(cmp_4_responses :: numeric / number_of_customers :: numeric) * 100 , 0)
	AS cmp_4_acceptance_rate,
	
	ROUND(
	(cmp_5_responses :: numeric / number_of_customers :: numeric) * 100 , 0)
	AS cmp_5_acceptance_rate,
	
	ROUND(
	(cmp_last_responses :: numeric / number_of_customers :: numeric) * 100 , 0)
	AS cmp_last_acceptance_rate,
	
	ROUND(
	(total_response_all_cmp :: numeric / 
	 (number_of_customers :: numeric * 6))  * 100 , 0)
	AS cmp_all_acceptance_rate
FROM kids_cmp_data


WITH full_table AS(
SELECT *
FROM public.campaign
INNER JOIN public.customer
ON public.campaign.id = public.customer.id
)
SELECT 
    (kid_home + teen_home) AS total_kids_home,
	SUM(COUNT(*)) OVER() AS total_number_of_customers,
	COUNT(*) AS number_of_customers,
	ROUND((COUNT(*)::numeric / SUM(COUNT(*)) OVER() ::numeric) * 100
		  , 0)
	AS percentage_of_customers,
	(SUM(accepted_cmp_1) + SUM(accepted_cmp_2)
	+ SUM(accepted_cmp_3) + SUM(accepted_cmp_4)
	+ SUM(accepted_cmp_5) + SUM(response)) AS total_responses,
	
	ROUND(
	( (SUM(accepted_cmp_1) + SUM(accepted_cmp_2)
	+ SUM(accepted_cmp_3) + SUM(accepted_cmp_4)
	+ SUM(accepted_cmp_5) + SUM(response))::numeric 
	 / (COUNT(*)::numeric * 6 ) ) * 100 , 0) AS acceptance_rate
FROM full_table
GROUP BY total_kids_home
ORDER BY total_kids_home

-- Those with 0 kids living with them 
-- are most likely to accept a campaign with a
-- 14% probabaility that they will accept a campaign.