--1. What is the total amount each customer spent at the restaurant?
select customer_id , sum(price) as total_amount  
from sales s join menu m on s.product_id = m.product_id 
group by customer_id


--2.  How many days has each customer visited the restaurant?
select customer_id , count(order_date) as visited_days 
from sales group by customer_id


--3.  What was the first item from the menu purchased by each customer?
With A as
(select  s.customer_id, m.product_name , s.order_date ,
        DENSE_RANK() OVER (PARTITION BY S.Customer_ID Order by S.order_date) as RANK
          from sales s join menu m on s.product_id = m.product_id 
		      group by S.customer_id, M.product_name,S.order_date )
Select Customer_id, product_name,order_date
From A
where RANK = 1


--4.  What is the most purchased item on the menu and how many times was it purchased by all customers?

Select customer_id, product_name , count(order_date) as Item_ordered 
from sales s join menu m on s.product_id = m.product_id 
group by product_name , customer_id
order by Item_ordered desc


--5.  Which item was the most popular for each customer?

With A as
(select  s.customer_id, m.product_name ,Count(S.product_id) as Item_ordered,
       Dense_rank()  Over (Partition by S.Customer_ID order by Count(S.product_id) DESC ) as Rank
          from sales s join menu m on s.product_id = m.product_id 
		      group by S.customer_id, M.product_name,S.product_id )
Select Customer_id, product_name,Item_ordered
From A 
where RANK = 1
order by Item_ordered desc


--6.  Which item was purchased first by the customer after they became a member?
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


--7.  Which item was purchased just before the customer became a member?
With A as
(
Select  S.customer_id,M.product_name,S.Order_date,
	Dense_rank() OVER (Partition by S.Customer_id Order by S.Order_date) as RANK
From Sales S Join Menu M ON m.product_id = s.product_id JOIN Members Mem
ON Mem.Customer_id = S.customer_id
Where S.order_date <= Mem.join_date  
)
Select *
From A
Where RANK = 1


--8.  What is the total items and amount spent for each member before they became a member?
select Mem.customer_id,
       Count(M1.product_name) Total_items ,
       sum(M1.price) as Amount 
	    from sales s
	   join members Mem 
	   on s.customer_id = mem.customer_id
	   join menu M1 on M1.product_id=s.product_id
	   Where s.order_date <= Mem.join_date
group by   Mem.customer_id