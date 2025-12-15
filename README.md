# Multi-Branch-Sales-Data-with-MySQL
This project performs a comprehensive analysis of multi-branch retail sales data using MySQL to uncover actionable business insights and support data-driven decision-making.
## Project Dashboard
You can view the interactive dashboard here: [View Dashboard](https://1drv.ms/x/c/f78bfa6ecf60e134/IQAFP85212zTR7sC5OYQQ84HAeypXQ_qAXXugh4vQaOYibE?e=EVvErH)

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
   LIMIT 5

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

    
