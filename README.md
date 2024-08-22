Problem Statement
The aim of this case study is to perform a comprehensive analysis of credit card transaction data spanning from October 2013 to May 2015. The dataset includes various attributes such as City, Date, Card Type, Expense Type, Gender, and Amount. By applying advanced SQL techniques, the study seeks to derive actionable insights from the data. The analysis addresses the following key questions:

Top 5 Cities by Spending: Determine the top 5 cities based on total credit card spend and calculate their percentage contribution to the overall spending.

Month with Highest Spend by Card Type: Identify the month with the highest spending for each card type and the corresponding amount spent.

Transaction Details at $1,000,000 Spend Milestone: Retrieve all transaction details for each card type once the cumulative spend reaches $1,000,000.

City with Lowest Percentage Spend for Gold Cards: Find the city with the smallest percentage of total spending attributed to gold card transactions.

Cities with Highest and Lowest Expense Types: List cities along with their most and least frequent expense types (e.g., Delhi, bills, fuel).

Female Spending Contribution: Calculate the percentage contribution of female spending for each expense type.

Highest Month-over-Month Growth in January 2014: Identify which card and expense type combination experienced the greatest month-over-month growth in January 2014.

City with Highest Spend-to-Transaction Ratio on Weekends: Determine the city with the highest ratio of total spend to the number of transactions during weekends.

City with Fewest Days to 500th Transaction: Find the city that reached its 500th transaction in the shortest number of days following the initial transaction.

Key SQL Techniques Applied
Aggregate Functions: SUM, COUNT, MIN, MAX
Data Transformation: CAST, ROUND
Window Functions: SUM(), RANK(), DENSE_RANK(), ROW_NUMBER()
Subqueries
Date Functions
Multi-Table Joins
String Manipulation: CONCATENATE
Conditional Logic: CASE WHEN
Filtering: WHERE
Common Table Expressions (CTE)
Purpose
This case study utilizes a range of SQL functions and methods to explore and analyze credit card transaction data, providing valuable insights for decision-making and strategic planning.
