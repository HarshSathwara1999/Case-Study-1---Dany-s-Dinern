select customer_id , sum(price) as total_amount  
from sales s join menu m on s.product_id = m.product_id 
group by customer_id