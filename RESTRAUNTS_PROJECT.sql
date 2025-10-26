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
GROUP BY category


