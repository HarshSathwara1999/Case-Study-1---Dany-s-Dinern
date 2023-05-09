---Which item was the most popular for each customer?

Select customer_id, product_name , count(s.product_id) as Item_ordered 
from sales s join menu m on s.product_id = m.product_id 
group by product_name , customer_id
having count(s.product_id) >= 2
order by Item_ordered desc
 
 ---OR----

With A as
(select  s.customer_id, m.product_name ,Count(S.product_id) as Item_ordered,
       Dense_rank()  Over (Partition by S.Customer_ID order by Count(S.product_id) DESC ) as Rank
          from sales s join menu m on s.product_id = m.product_id 
		      group by S.customer_id, M.product_name,S.product_id )
Select Customer_id, product_name,Item_ordered
From A 
where RANK = 1
order by Item_ordered desc

