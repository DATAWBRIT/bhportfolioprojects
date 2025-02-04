Use restaurant_db;

-- Objective 1: Explore the Menu Items Table
-- 1. View the menu_items table.

Select * 
from menu_items;

-- 2. Find The number of items on the menu

Select count(item_name)
from menu_items;

-- 3. What are the least and most expensive items on the menu?

Select min(price), max(price)
from menu_items;

Select * from menu_items
order by price;

Select * from menu_items
order by price desc;

-- 4. How many Italian dishes are on the menu?

Select count(*) 
from menu_items
where category = 'Italian';

-- 5. What are the least and most expensive Italian dishes on the menu?

Select *
From menu_items
where category = 'Italian'
order by price;

-- 6. How many dishes are in each category?

Select category, count(menu_item_id) as num_dishes
From menu_items
group by category;

-- 7. What is the Average dish price within each category?

Select category, avg(price) as avg_price
from menu_items
group by category;