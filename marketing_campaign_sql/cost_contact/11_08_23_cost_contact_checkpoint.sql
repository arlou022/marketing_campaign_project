-- The average acceptance rate of a campaign is 7%.
-- I.e, on average, for any given campaign, 7% of the customers
-- in the database will accept the campaign.

-- Therefore if we assume our next campaign to have a 7%
-- acceptance rate, let us calculate 
-- the cost per contact in order to break even.

SELECT
    COUNT(id) AS num_customers,
	ROUND(COUNT(id)::numeric * 0.07,0) AS num_accepted_customers,
	ROUND(COUNT(id)::numeric * 0.07,2) * 11 AS total_revenue,
	ROUND(
		 (ROUND(COUNT(id)::numeric * 0.07,2) * 11 / COUNT(id)::numeric )
		, 2) AS break_even_cost_contact
FROM public.campaign

-- So in the case of the average 7% acceptance rate,
-- we need a cost contact of 0.77 in order to break even.
-- This is a 74% reduction in the cost contact already of 3 already in place.

-- Now let us calculate the cost per contact if we want to achieve
-- a ROI of 400%, i.e. if we want to achieve £5 for every £1.

-- Assuming a 7% acceptance rate, and a revenue of 11 for each
-- customer that accepts a campaign, we can calculate the cost contact
-- required in order to achieve a ROI of 400%.

SELECT
    COUNT(id) AS num_customers,
	ROUND(COUNT(id)::numeric * 0.07,0) 
	AS num_accepted_customers,
	ROUND(COUNT(id)::numeric * 0.07,2) * 11 AS total_revenue,
	ROUND( ( (COUNT(id)::numeric * 0.07 * 11) / 4 ), 2)
	AS required_total_cmp_cost_for_400_percent_ROI,
	ROUND( ( (COUNT(id)::numeric * 0.07 * 11) / 4 ) / COUNT(id) , 2 )
	AS required_cost_conatct_for_400_percent_ROI
FROM public.campaign

-- So, in order to achieve a 400% ROI, given the same customers, 
-- a 7% acceptance rate of a campaign and given that the revenue
-- per customer accepting a campaign is 11, we need a cost per contact
-- of 0.19.
-- This is a 94% reduction in the cost per contact of 3 already in place.

-- This is an incredibly significant reduction and may not be practical.
-- Therefore, in order to achieve our goal of increasing marketing ROI without
-- having to make this significant of a reduction in cost per contact,
-- we need to identify ways in order to increase our revenue.




	