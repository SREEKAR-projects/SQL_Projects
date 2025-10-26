/*
OBJECTIVE BRIEFING: EXPLORE THE MENU ITEMS TABLE (EXPLORATORY)

The objective for the Taste of the World Cafe project was to explore the `menu items` table (also referred to as the `items` table) to get an initial understanding of the restaurant's new menu offerings.
https://www.youtube.com/watch?v=JaUKDbCXMX4
1.  Table Overview and Item Count:
    *   View the items table.
    *   Write a query to find the total number of items on the menu.

2.  Overall Price Extremes:
    *   What are the least and most expensive items on the menu?

3.  Italian Dish Analysis:
    *   How many Italian dishes are on the menu?
    *   What are the **least and most expensive Italian dishes on the menu?

4.  Category Pricing and Counts:
    *   Take a look at how many **dishes are in each category.
    *   What is the average dish price within each category?

*/

select count(menu_item_id) as total_iteams
from menu_items;

SELECT item_name, price
FROM menu_items
WHERE price = (SELECT MIN(price) FROM menu_items)
   OR price = (SELECT MAX(price) FROM menu_items);

SELECT item_name,
       price,
       (SELECT COUNT(*) 
        FROM menu_items 
        WHERE category LIKE 'Italian') AS total_italian_dishes
FROM menu_items
WHERE category LIKE 'Italian'
AND (price = (SELECT MIN(price) FROM menu_items WHERE category LIKE 'Italian')
  OR price = (SELECT MAX(price) FROM menu_items WHERE category LIKE 'Italian'));


SELECT category, COUNT(menu_item_id) AS COUNT__
FROM menu_items
GROUP BY category;

SELECT category, concat("$.", " ", round(avg(price),2)) AS avg_price
FROM menu_items
GROUP BY category;

/*
Objective 2: Explore the Order Details Table
*/

SELECT COUNT( distinct order_id) AS count
FROM order_details
WHERE order_date BETWEEN
    (SELECT MIN(order_date) FROM order_details)
    AND
    (SELECT MAX(order_date) FROM order_details);

SELECT COUNT(*) AS count
FROM order_details;


select*
from order_details
order by order_id  desc
limit 1;

select order_id, count(item_id) as cntt
from order_details
group by order_id
order by cntt desc ;

WITH previous_query AS (
    SELECT order_id, COUNT(item_id) AS cntt
    FROM order_details
    GROUP BY order_id
)
SELECT COUNT(*) AS orders_more_than_12
FROM previous_query
WHERE cntt > 12;

/*
Objective 3: Analyze Customer Behavior
*/
create view total_data as
select*
from menu_items as mi
left join order_details as od
on mi.menu_item_id = od.order_details_id;

create view total_data2 as
select*
from menu_items as mi
left join order_details as od
on mi.menu_item_id = od.order_details_id;

select*
from total_data
order by order_id  desc
limit 1;

SELECT mi.item_name, count(od.order_details_id) as summ
from menu_items as mi
left join order_details as od
on mi.menu_item_id = od.order_details_id
group by mi.item_name;

SELECT 
    mi.item_name, 
    COUNT(od.order_details_id) AS num_purchases 
FROM order_details AS od                               /* Start with the transaction table */
LEFT JOIN menu_items AS mi 
ON od.item_id = mi.menu_item_id                      /* The crucial correction: joining Item ID to Menu Item ID */
GROUP BY mi.item_name                                      /* Group by the name to count purchases per item */
ORDER BY num_purchases DESC;                               /* Add ORDER BY and LIMIT to find most/least popular */

SELECT 
    item_name, 
    COUNT(order_details_id) AS num_purchases 
FROM total_data2                   /* The crucial correction: joining Item ID to Menu Item ID */
GROUP BY item_name                                      /* Group by the name to count purchases per item */
ORDER BY num_purchases DESC;

CREATE OR REPLACE VIEW total_data2 AS
SELECT *
FROM menu_items AS mi
LEFT JOIN order_details AS od
ON mi.menu_item_id = od.item_id;


SELECT 
    item_name, category ,
    COUNT(order_details_id) AS num_purchases
FROM total_data2
GROUP BY item_name , category
ORDER BY num_purchases DESC;

SELECT 
    order_id, sum(price) as priceee, category
FROM total_data2
GROUP BY order_id, category
ORDER BY priceee DESC
limit 5;

select category, count(item_id)
from total_data2
where order_id =440
group by category;

select category, count(item_id)
from total_data2
where order_id in ( 440, 
4232 ,
2547 , 
2075 ,
17 )
group by category
order by count(item_id) desc;

select item_id, category, count(item_id)
from total_data2
where order_id in ( 440, 
4232 ,
2547 , 
2075 ,
17 )
group by item_id, category
order by count(item_id) desc;






