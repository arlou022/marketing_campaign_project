SELECT *
FROM public.campaign

SELECT *
FROM public.customer

-- First let's see which campagin had the most responses

SELECT 
    SUM(accepted_cmp_1) AS cmp_1_responses,
	SUM(accepted_cmp_2) AS cmp_2_responses,
    SUM(accepted_cmp_3) AS cmp_3_responses,
	SUM(accepted_cmp_4) AS cmp_4_responses,
	SUM(accepted_cmp_5) AS cmp_5_responses,
	SUM(response) AS cmp_last_responses
FROM public.campaign

-- Can see cmp_2 had least responses with 30
-- And last campaign had most responses with 334

-- Important to also note that the cmp_2 had significanly 
-- less responses than the 2nd least reponded campaign 
-- with 79% less responses.

-- Also, the last campaign had significantly more responses
-- than the 2nd most responded campaign 
--- with 105% more responses.


-- Now, let's inspect the effect of education on 
-- campaign response 

WITH full_table AS(SELECT *
FROM public.customer
INNER JOIN public.campaign
ON public.customer.id = public.campaign.id
)

SELECT
    education,
    SUM(accepted_cmp_1) AS cmp_1_responses,
	SUM(accepted_cmp_2) AS cmp_2_responses,
    SUM(accepted_cmp_3) AS cmp_3_responses,
	SUM(accepted_cmp_4) AS cmp_4_responses,
	SUM(accepted_cmp_5) AS cmp_5_responses,
	SUM(response) AS cmp_last_responses
FROM full_table
GROUP BY education

-- Can see those with Basic education 
-- responded to cmp_3 or the last campaign 
-- with 80% responding to cmp_3
-- while those with Graduation level education
-- were the ones most likely to respond to any given campaign.

-- With this insight, we can maximise our budget 
-- by only pushing cmp_3 to those customers with Basic education level,
-- saving us money on 4 campaign pushes.
-- We can also study more about cmp_3 and Basic education level customers,
-- find out what makes it succesful and further implement the tactic.

-- Can also see cmp_2 did not stand out to any education level 
-- while the fifth and last campaigns were consistently successful,
-- relative the the other campaigns.

-- Theres no strong indication that another given education level
-- tended more towards a specific campaign.
-- For example, there's no strong indication that those with Masters
-- tended more towards cmp_1 or those with a PhD tended more towards
-- cmp_4.

-- Therefore, other than cmp_3 to Basic customers,
-- not enough evidence to push another specific campaign 
-- to a specific education level. 

-- However even if we did just push cmp_3
-- to Basic education customers, is it enough to turn the ROI positive?
-- I.e, will the marketing campaign make money if we did this?

-- Given the customers in the database
-- the number of customers required to accept a campaign
-- in order to achieve an even ROI is 610.
-- And with a database of 2240 customers, this is 27%
-- I.e. 27% of your customers are required to respond 
-- in order to break even on a campaign.

WITH even_ROI AS(
SELECT 
    SUM(z_cost_contact) / 11 AS customers_required_for_even_ROI
FROM public.campaign
),
customers AS(
SELECT
    COUNT(id) AS no_customers
FROM public.campaign
)
SELECT 
    customers_required_for_even_ROI,
	no_customers,
    ROUND( (even_ROI.customers_required_for_even_ROI ::numeric 
	 / customers.no_customers ::numeric) * 100 , 0)
	AS percentage_of_customers_required_for_even_ROI
FROM customers, even_ROI


-- With this said, let's look at the
-- acceptance of each campaign with respect to the total customers

SELECT 
    ROUND(
	( SUM(accepted_cmp_1) ::numeric / COUNT(id) ::numeric ) * 100 , 0)
	AS cmp_1_acceptance_rate,
	ROUND(
	( SUM(accepted_cmp_2) ::numeric / COUNT(id) ::numeric ) * 100 , 0)
	AS cmp_2_acceptance_rate,
	ROUND(
	( SUM(accepted_cmp_3) ::numeric / COUNT(id) ::numeric ) * 100 , 0)
	AS cmp_3_acceptance_rate,
	ROUND(
	( SUM(accepted_cmp_4) ::numeric / COUNT(id) ::numeric ) * 100 , 0)
	AS cmp_4_acceptance_rate,
	ROUND(
	( SUM(accepted_cmp_5) ::numeric / COUNT(id) ::numeric ) * 100 , 0)
	AS cmp_5_acceptance_rate,
	ROUND(
	( SUM(response) ::numeric / COUNT(id) ::numeric ) * 100 , 0)
	AS cmp_last_acceptance_rate
FROM public.campaign

-- As we can see, even the most accepted campaign 
-- has an acceptance rate of 15%. 
-- This is 44% less than required to even break even on a campaign.
-- This is strong indication to reduce the cost of contact per customer.
-- So now we ask, what is a good cost of contact per customer?

-- We start with calculating the average of the acceptance rates.

WITH acceptance_rates AS(
SELECT 
    ROUND(
	( SUM(accepted_cmp_1) ::numeric / COUNT(id) ::numeric ) * 100 , 0)
	AS cmp_1_acceptance_rate,
	ROUND(
	( SUM(accepted_cmp_2) ::numeric / COUNT(id) ::numeric ) * 100 , 0)
	AS cmp_2_acceptance_rate,
	ROUND(
	( SUM(accepted_cmp_3) ::numeric / COUNT(id) ::numeric ) * 100 , 0)
	AS cmp_3_acceptance_rate,
	ROUND(
	( SUM(accepted_cmp_4) ::numeric / COUNT(id) ::numeric ) * 100 , 0)
	AS cmp_4_acceptance_rate,
	ROUND(
	( SUM(accepted_cmp_5) ::numeric / COUNT(id) ::numeric ) * 100 , 0)
	AS cmp_5_acceptance_rate,
	ROUND(
	( SUM(response) ::numeric / COUNT(id) ::numeric ) * 100 , 0)
	AS cmp_last_acceptance_rate
FROM public.campaign
)
SELECT 
    ROUND( (cmp_1_acceptance_rate + cmp_2_acceptance_rate
	   + cmp_3_acceptance_rate + cmp_4_acceptance_rate
	   + cmp_5_acceptance_rate + cmp_last_acceptance_rate) / 6 , 0)
	   AS avg_acceptance_rate
FROM acceptance_rates

-- The average acceptance rate of a campaign is 7%.
-- I.e, on average, for any given campaign, 7% of the customers
-- in the database will accept the campaign.

-- Therefore if we assume our next campaign to have a 7%
-- acceptance rate, given the same revenue of 11 per campaign acceptance
-- and the same customers, we can expect ___ revenue.

SELECT
    COUNT(id) AS num_customers,
	ROUND(COUNT(id)::numeric * 0.07,0) AS num_accepted_customers,
	ROUND(COUNT(id)::numeric * 0.07,2) * 11 AS total_revenue,
	ROUND(
		 (ROUND(COUNT(id)::numeric * 0.07,2) * 11 / COUNT(id)::numeric )
		, 2) AS break_even_cost_contact
FROM public.campaign

-- So in the case of the average 7% acceptance rate,
-- we need a cost contact of 0.77.
-- This is a 74% reduction in the cost contact already of 3 already in place.

