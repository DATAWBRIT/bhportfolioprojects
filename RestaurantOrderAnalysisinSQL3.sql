-- Objective 3: Analyze Customer Behavior
-- 1. Combine the menu_items and order_details tables into a single table

Select *
from menu_items;

Select * 
from order_details;

Select *
From order_details od left join menu_items mi
	On od.item_id = mi.menu_item_id;
    
-- 2. What were the least and most ordered items? What categories were they in?

Select item_name, Count(order_details_id) as num_purchases
From order_details od left join menu_items mi
	On od.item_id = mi.menu_item_id
Group by item_name;

Select item_name, category, Count(order_details_id) as num_purchases
From order_details od left join menu_items mi
	On od.item_id = mi.menu_item_id
Group by item_name, category
order by num_purchases;

Select item_name, category, Count(order_details_id) as num_purchases
From order_details od left join menu_items mi
	On od.item_id = mi.menu_item_id
Group by item_name, category
order by num_purchases desc;

-- 3. What were the top 5 orders that spent the most money?

Select order_id, Sum(price) as total_spent
From order_details od left join menu_items mi
	On od.item_id = mi.menu_item_id
group by order_id
order by total_spent desc
Limit 5;

-- 4. View the details of the highest spend order. What insights can you gather from the results?

Select category, count(item_id) as num_items
From order_details od left join menu_items mi
	On od.item_id = mi.menu_item_id
where order_id = 440
Group by category;

-- 5. View the details of the top 5 highest spend orders. What insights can you gather from the results.

Select order_id, category, Count(item_id) as num_items
From order_details od left join menu_items mi
	On od.item_id = mi.menu_item_id
where order_id IN (440, 2075, 1957, 330, 2675)
Group by order_id, category;
