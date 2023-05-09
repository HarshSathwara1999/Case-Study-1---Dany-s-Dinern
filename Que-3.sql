----What was the first item from the menu purchased by each customer?

With A as
(select  s.customer_id, m.product_name , s.order_date ,
        DENSE_RANK() OVER (PARTITION BY S.Customer_ID Order by S.order_date) as RANK
          from sales s join menu m on s.product_id = m.product_id 
		      group by S.customer_id, M.product_name,S.order_date )
Select Customer_id, product_name,order_date
From A
where RANK = 1
