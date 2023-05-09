---Which item was purchased first by the customer after they became a member?
		 
With A as
(
Select  S.customer_id,
        M.product_name,
		S.Order_date,
	Dense_rank() OVER (Partition by S.Customer_id Order by S.Order_date) as RANK
From Sales S
Join Menu M
ON m.product_id = s.product_id
JOIN Members Mem
ON Mem.Customer_id = S.customer_id
Where S.order_date >= Mem.join_date  
)
Select *
From A
Where RANK = 1