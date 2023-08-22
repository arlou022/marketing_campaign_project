SELECT *
FROM public.campaign

-- Let's calculate the returns on each campaign

-- Given z_cost_contact is the cost to 
-- contact a customer for a given campaign
-- & z_revenue is the revenue after client accepts campaign
-- Then the return on a campaign is 
-- (total_cmp_responses * z_revenue) - (total_contacts * z_cost_contact)

-- From queies below, we'll find z_revenue is always 11 
-- & z_cost_contact always 3
-- SELECT 
--     DISTINCT(z_revenue)
-- FROM public.campaign

-- SELECT 
--     DISTINCT(z_cost_contact)
-- FROM public.campaign

SELECT
    ( (SUM(accepted_cmp_1) * 11) - COUNT(*) * 3 )
	AS cmp_1_return,
	( (SUM(accepted_cmp_2) * 11) - COUNT(*) * 3 )
	AS cmp_2_return,
	( (SUM(accepted_cmp_3) * 11) - COUNT(*) * 3 )
	AS cmp_3_return,
	( (SUM(accepted_cmp_4) * 11) - COUNT(*) * 3 )
	AS cmp_4_return,
	( (SUM(accepted_cmp_5) * 11) - COUNT(*) * 3 )
	AS cmp_5_return,
	( (SUM(response) * 11) - COUNT(*) * 3 )
	AS response_return
FROM public.campaign

-- Query explanation:
--  -- No NULL's in ID, 
	-- therefore total_contacts = all records = COUNT(*)
	-- z_revenue = 11
	-- z_cost_contact = 3


-- Some customers responded to more than 1 campaign,
-- hence worth seeing the campaign performance results as a whole

WITH revenue AS(
SELECT
    ( SUM(accepted_cmp_1) + SUM(accepted_cmp_2)
	+ SUM(accepted_cmp_3) + SUM(accepted_cmp_4)
	+ SUM(accepted_cmp_5) + SUM(response) ) * 11 AS total_revenue
FROM public.campaign
),
cost AS(
SELECT 	
    SUM(z_cost_contact) * 6 AS total_cost_all_cmp
	-- 6 as there are 6 campaigns in total
FROM public.campaign
)

SELECT 
    revenue.total_revenue,
	cost.total_cost_all_cmp,
	( revenue.total_revenue - cost.total_cost_all_cmp )
	AS total_marketing_return,
	ROUND( ( revenue.total_revenue - cost.total_cost_all_cmp )::numeric /
	cost.total_cost_all_cmp::numeric * 100 , 0) 
	AS total_marketing_ROI
FROM revenue, cost
	
-- As we can see, the total marketing campaign had a -73% ROI.
-- Initial ideas to improve ROI:

-- We can start by studying the 
-- campaign data alongside the customer data. 

-- For instance, if a particular group of customers tended to respond more
-- towards a specific campaign, then we can stop contacting that group
-- of customer with the other campaigns and just contact them with the ones
-- we know are effective to them.
