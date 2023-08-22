-- Let us calculate the current acceptance rate
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

-- Given the customers in the database
-- the number of customers required to accept a campaign
-- in order to achieve an even ROI is 610.
-- And with a database of 2240 customers, this is 27%
-- I.e. 27% of your customers are required to respond 
-- in order to break even on a campaign.


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

