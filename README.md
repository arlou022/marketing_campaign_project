# marketing_campaign_project

## Introduction

The main goal was to use SQL to query the data to measure campaign performance and gather actionable insights towards improving future campaigns and increasing business 
profits.

The project essentially consisted of:
- EDA - Mainly looked for anything that may impact analysis on the data such as missing values or outliers.
- Creating Database - Ensured data inputs and types were correct.
- Queired the data to calculate KPI’s such as ROI and acceptance rates.
- Further explored the data to gather actionable insights such as determining factors to campaign success and discussed possible actions to take

The original dataset and explanation of the variables can be found from Kaggle at this link: https://www.kaggle.com/datasets/rodsaldanha/arketing-campaign 


## Insights & Solutions

- The total marketing campaign had a -73% ROI.
- With the current database of 2240 customers, where the cost to contact each customer is £3 and the revenue obtained from each customer accepting a campaign is £11, this means that 27% of customers are required to accept a campaign in order to break even.
- The average acceptance rate of a campaign from this company is 7%.
- With a 7% acceptance rate and the database variables, cost to contact, and acceptance revenue the same, the cost of contact needs to be reduced to 0.77 to break even from a campaign. This is a 74% reduction to the cost of contact already in place.
- To achieve a 400% ROI, given the same database of customers and revenue of £11 per customer accepting a campaign, then the cost of contact needs to be reduced to 0.19. 

  This is a 94% reduction to the cost of contact in place. This is an incredibly significant reduction and may not be practical.  Hence, it is essential to identify ways to increase revenue. 

  We can increase revenue either by increasing the revenue obtained per campaign accepted and/or by increasing the acceptance rate. 

  We can begin to come up with ideas on increasing the acceptance rate by exploring the campaign data alongside the customer data. 

  One way we can begin exploration is by probing whether a particular group of customers tended to respond more towards a specific campaign. 

  With this insight, we can study that particular and campaign and identify exactly what made it successful to that group and ensure to implement that tactic. 

  Furthermore, if we can identify that a particular group of customer tended more towards a specific campaign, then we can save costs by no longer contacting that group of customer with other campaigns and just contact them with the one they’re most likely to respond to.


- The customers without kids living with them are most likely to accept a campaign with a 14% probability that they will accept a campaign. 

  We can also observe that the more kids a customer has living with them, the less likely they are to accept a campaign.

  We also observe that 79% of our customers have either 0 or 1 kid living with them.

  Hence one improvement we can make in future campaigns is to focus our marketing efforts on those with either 0 or 1 kid. This way we can save cost and maximise our budget by only contacting those who are likely to accept a campaign.


- The customers within the income range of 77500 – 100000 are most likely to accept a campaign with an acceptance rate of 24% and make up 13% of our customer database.

  We can also observe that the greater the income, the more likely a customer is to accept a campaign.

  Hence one improvement we can make in future campaigns is to focus our marketing efforts on those with income greater than 77500.

- The customers within the income range of 77500 – 100000 and do not have kids have an acceptance rate of 24% and make up 10% of our customer database.

  Hence one improvement we can make in future campaigns is to focus our marketing efforts on the customers within this group.


- Began to explore campaign acceptance as a factor of education.


## Closing

Much more analysis could be carried out and many more insights can be gathered from this data set. The code quality can also be improved however the main emphasis for this project was to gather real actionable insights towards improving future campaigns.
