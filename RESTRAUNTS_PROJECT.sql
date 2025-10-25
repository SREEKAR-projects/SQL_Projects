/*
The first objective of the SQL project for the Taste of the World Cafe was to explore the menu items table (sometimes referred to as the items table) to thoroughly understand the offerings of the restaurant's new menu.
This objective was accomplished through several SQL analysis tasks:
1. Table Overview and Item Count: A query was executed to view the menu items table and determine the total number of items on the menu. The table was found to contain 32 rows.
2. Price Extremes: Queries were written to identify the least and most expensive items overall. The least expensive item was determined to be Edamame (5)**, and the most expensive item was **Shrimp Scampi (19.95).
3. Italian Dish Analysis: Specific investigation into the Italian dishes was performed, revealing there were nine Italian dishes on the menu. The least expensive Italian dish was Spaghetti ($4.50), and the most expensive Italian dish was Shrimp Scampi.
4. Category Pricing and Counts: The analysis determined how many dishes are in each category and calculated the average dish price within each category.
5. Key Insight: This analysis showed that Italian dishes were the most expensive category, while American dishes were the most affordable.
In summary, Objective 1 provided a clear understanding of the number of items, the different categories available, and the price distribution within the menu items table.
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


