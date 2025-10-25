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


