SELECT * FROM pizza_sales;
SELECT DAYNAME(order_date) AS Order_day,COUNT(DISTINCT order_id) AS Order_number
FROM pizza_sales
GROUP BY DAYNAME(order_date);
-- UNSORTED DAYS
SELECT DAYNAME(STR_TO_DATE(order_date, '%Y-%m-%d')) AS Order_day,
 COUNT(DISTINCT order_id) AS Order_number FROM pizza_sales
 GROUP BY Order_day;
-- TIME IN HOURS
SELECT HOUR(order_time) as Hourly,COUNT(DISTINCT order_id) as Orders
FROM pizza_sales
GROUP BY HOUR(order_time);

-- Percentage of Pizza Category
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2))AS Total_Sales,
CAST(sum(total_price)*100/ (SELECT SUM(total_price)
FROM pizza_sales WHERE QUARTER(STR_TO_DATE(order_date, '%Y-%m-%d'))=1)  AS DECIMAL (10,2) )AS PCT
FROM pizza_sales
WHERE QUARTER(STR_TO_DATE(order_date, '%Y-%m-%d'))=1
GROUP BY pizza_size
ORDER BY PCT;

-- Total Pizza Sold By Pizza Category
SELECT pizza_category,sum(quantity) from pizza_sales
GROUP BY pizza_category;

-- TOP 5 Best Sellers BY Total Prize Sold
SELECT  pizza_name, sum(quantity) AS Total_Pizza_Sold from pizza_sales
WHERE MONTH(str_to_date(order_date,"%Y-%m-%d"))=1
GROUP BY pizza_name
order by Total_Pizza_Sold DESC
limit 5;
-- “Which pizza sizes and categories contribute most to revenue at different times of day,
-- and how can we optimize pricing or promotions to maximize sales?”
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








