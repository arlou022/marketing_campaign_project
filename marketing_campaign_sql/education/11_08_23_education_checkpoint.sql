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
	COUNT(*) AS number_of_customers,
    SUM(accepted_cmp_1) AS cmp_1_responses,
	SUM(accepted_cmp_2) AS cmp_2_responses,
    SUM(accepted_cmp_3) AS cmp_3_responses,
	SUM(accepted_cmp_4) AS cmp_4_responses,
	SUM(accepted_cmp_5) AS cmp_5_responses,
	SUM(response) AS cmp_last_responses
FROM full_table
GROUP BY education

-- From inspecting the results table, we can see those with Basic education 
-- responded to cmp_3 or the last campaign 
-- with 80% of the respondants responding to cmp_3.

-- With this insight, we can maximise our budget 
-- by only pushing cmp_3 to those customers with Basic education level,
-- saving us money on 5 campaign contacts.
-- We can also study more about cmp_3 and Basic education level customers,
-- find out what makes it succesful and further implement the tactic.

-- Can also see cmp_2 did not stand out to any education level 
-- while the fifth and last campaigns were consistently successful,
-- relative the the other campaigns.

-- From this table alone, we can't see a 
-- strong indication that another given education level
-- tended more towards a specific campaign.
-- For example, there's no strong indication that those with Masters
-- tended more towards cmp_1 or those with a PhD tended more towards
-- cmp_4.

-- Therefore, from this table, we cannot conclude to 
-- push a specific campaign to a specific education level,
-- other than cmp_3 to Basic customers.
 


