-- Objective 2 Explore the Orders Table
-- 1. View the order_details table.

Select *
from order_details;

-- 2. What is the date range of the table?

Select min(order_date), max(order_date)
from order_details;

-- 3. How many orders were made within this date range?

Select count(distinct order_id)
from order_details;

-- 4. How many items were ordered within this date range?

Select count(*)
from order_details;

-- 5. Which orders had the most number of items?

Select order_id, count(item_id) as num_items
From order_details
group by order_id
order by num_items desc;

-- 6. How many orders had more than 12 items?

Select Count(*) From
(Select order_id, count(item_id) as num_items
From order_details
group by order_id
having num_items > 12) as num_orders;
