---What is the total items and amount spent for each member before they became a member?

select Mem.customer_id,
       Count(M1.product_name) Total_items ,
       sum(M1.price) as Amount 
	    from sales s
	   join members Mem 
	   on s.customer_id = mem.customer_id
	   join menu M1 on M1.product_id=s.product_id
	   Where s.order_date <= Mem.join_date
group by   Mem.customer_id