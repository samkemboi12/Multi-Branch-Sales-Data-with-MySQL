# Multi-Branch-Sales-Data-with-MySQL
This project performs a comprehensive analysis of multi-branch retail (12 branches for a Pizza Business) sales data using MySQL to uncover actionable business insights and support data-driven decision-making.
## Project Dashboard
You can view the interactive dashboard here to explore the business performance, including sales trends, peak hours and days, and product performance.: [View Dashboard](https://1drv.ms/x/c/f78bfa6ecf60e134/IQAFP85212zTR7sC5OYQQ84HAeypXQ_qAXXugh4vQaOYibE?e=EVvErH)

## Project Overview
This project analyzes pizza sales data from 12 branches of Naks_Vegas Inn to uncover actionable business insights and support data-driven decision-making. Using MySQL, the project demonstrates data cleaning, aggregation, and advanced analytics with SQL features 
Aggregated data from MySQL was exported to Excel and connected directly via ODBC, enabling dynamic dashboards, interactive charts, and easy exploration of business metrics for stakeholders. The repository contains well-organized SQL scripts demonstrating best practices for querying, aggregation, and reporting, making the workflow reusable for operational and strategic analysis.
## Project Objective

The objective of this project is to analyze pizza sales data to understand customer purchasing behavior, sales performance, and product profitability, in order to support data-driven business decisions that improve revenue, optimize menu offerings, and enhance operational efficiency.

More specifically, the project aims to:
- Identify top-selling and low-performing pizzas
- Understand sales trends over time (daily, monthly, peak hours)
- Analyze customer order patterns and preferences
- Evaluate revenue contribution by pizza size and category
- Provide actionable insights for pricing, promotions, and inventory planning
 ## Explanatory Data Analysis
 1. **How is the orders distributed in the days of the week**
    ```sql
    SELECT
           DAYNAME(STR_TO_DATE(order_date, '%Y-%m-%d')) AS Order_day,
           COUNT(DISTINCT order_id) AS Order_number
           FROM pizza_sales
    GROUP BY Order_day;
 2. **What are the peak hours of the day**
    ```sql
    SELECT
          HOUR(order_time) as Hourly,
          COUNT(DISTINCT order_id) as Orders
          FROM pizza_sales
    GROUP BY HOUR(order_time);
 3. **Write an sql query that answers; <br>In the first quarter (Q1), how much total sales did each pizza size generate, and what percentage of total Q1 sales does each pizza size contribute?**
    ```sql
    SELECT
        pizza_size,
        CAST(SUM(total_price) AS DECIMAL(10,2))AS Total_Sales,
        CAST(sum(total_price)*100/ (SELECT SUM(total_price)
        FROM pizza_sales
    WHERE QUARTER(STR_TO_DATE(order_date, '%Y-%m-%d'))=1)  AS DECIMAL (10,2) )AS PCT
    FROM pizza_sales
    WHERE QUARTER(STR_TO_DATE(order_date, '%Y-%m-%d'))=1
    GROUP BY pizza_size
    ORDER BY PCT;
4. **What is the Total Pizza Sold By Pizza Category**
   ```sql
   SELECT
         pizza_category,
         sum(quantity)
         FROM pizza_sales
    GROUP BY pizza_category;
6. **Write a query that identifies the 5 top-selling pizza types in January based on total units sold.**
   ```sql
   SELECT
         pizza_name,
         sum(quantity) AS Total_Pizza_Sold
   FROM pizza_sales
   WHERE MONTH(str_to_date(order_date,"%Y-%m-%d"))=1
   GROUP BY pizza_name
   ORDER BY Total_Pizza_Sold DESC
   LIMIT 5;

7. **Write a query identifies the bottom 5 least-selling pizza types in April based on total units sold.**
   ```sql
    SELECT
         pizza_name,
         sum(quantity) AS Total_Pizza_Sold
   FROM pizza_sales
   WHERE MONTH(str_to_date(order_date,"%Y-%m-%d"))=4
   GROUP BY pizza_name
   ORDER BY Total_Pizza_Sold
   LIMIT 5;

8. **Which pizza sizes and categories contribute most to revenue at different times of day, and how can we optimize pricing or promotions to maximize sales?**
   ```sql
   SELECT
    pizza_size,
    pizza_category,
    CASE
        WHEN HOUR(STR_TO_DATE(order_time, '%H:%i:%s')) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(STR_TO_DATE(order_time, '%H:%i:%s')) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN HOUR(STR_TO_DATE(order_time, '%H:%i:%s')) BETWEEN 17 AND 21 THEN 'Evening'
        ELSE 'Night'
    END AS Time_of_Day,
    SUM(total_price) AS Total_Revenue,
    SUM(quantity) AS Total_Quantity
   FROM pizza_sales
   GROUP BY pizza_size, pizza_category, Time_of_Day
   ORDER BY Time_of_Day, Total_Revenue DESC;
 
## Business Insights and Business Recommendations
1. **Sales Trend based on Time of the day and Day of the week.**<br>
   From the Analysis, Monday dorminates the total orders, followed by Tuesday with Friday being the least.<br> Peak hours is from 12 noon to 1pm and 5pm to 6pm.<br>The business should optimize staffing and inventory to match demand patterns.Scheduling more staff during these periods will improve service speed and customer satisfaction. <br>Conversely, Fridays have the lowest orders, so staffing and inventory can be reduced to save costs.
2. **Top performing Pizza Sizes**<br>
Large (L) pizzas are the top revenue drivers in Q1, contributing 46.37% of total sales, followed by Medium (M) at 29.78%.
Small (S) pizzas also have a decent share (22.10%), but XL and XXL contribute very little ,1.6% and 0.14% respectively.<br>
**The business should focus** marketing campaigns and combo deals around Large and Medium pizzas, since they drive the majority of revenue.<br>
It should consider whether XL and XXL pizzas should be repriced, bundled, or promoted differently to increase their sales, or possibly reduce inventory for them to avoid waste.<br>
Finally, it should stock more on the Large and medium pizza ingredients to meet the demand
3. **The Top Performing Pizza Category**<br>
Classic pizzas are the most popular, with 14,888 orders, followed by Supreme -11,987 and Veggie -11,649. Chicken pizzas have the lowest orders at 11,050.
<br>The business should;
- Highlight Classic and Supreme pizzas in combo deals or loyalty offers since they drive the most sales.
- Consider marketing strategies, discounts, or meal bundles to increase sales of Chicken pizzas, which are lagging.
- Ensure ingredients for Classic and Supreme pizzas are always in stock to meet high demand, especially during peak hours.
   ## Conclusion
  The findings from this project provide valuable insights into sales patterns, peak hours, and product performance. Stakeholders can use this information to make informed business decisions, such as optimizing staffing during peak hours, managing inventory efficiently, and targeting promotions for low-selling pizza sizes or categories. By understanding which pizza sizes and categories contribute most to revenue and which customers drive the highest sales, managers can ensure popular products are always available, improve marketing strategies, and enhance overall customer satisfaction.
  ## Quick Start Guide
- Clone the Repository: Clone this project repository from GitHub.
- Run the Queries: Use the SQL queries provided in the business_analysis.sql file to perform your analysis.
- Explore and Modify: Update SQL queries or charts to analyze and answer additional business questions.

    
