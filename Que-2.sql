---How many days has each customer visited the restaurant?

select customer_id , count(order_date) as visited_days 
from sales group by customer_id