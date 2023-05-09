---What is the most purchased item on the menu and how many times was it purchased by all customers?

Select customer_id, product_name , count(order_date) as Item_ordered 
from sales s join menu m on s.product_id = m.product_id 
group by product_name , customer_id
order by Item_ordered desc