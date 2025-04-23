DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
      (
        transactions_id INT,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(50),
		age	INT,
		category VARCHAR(50),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT

      );

select * from retail_sales

select * from retail_sales
where
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 customer_id is null
	 or 
	 gender is null
	 or 
	 category is null 
	 or 
	 quantiy is null
	 or
	 price_per_unit	is null 
	 or
	 cogs is null
	 or
	 total_sale is null
-- NUMBER OF VALUES IN THE TABLE--
select count(*) from retail_sales

-- DATA CLEANING --
delete from retail_sales
where
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 customer_id is null
	 or 
	 gender is null
	 or 
	 category is null 
	 or 
	 quantiy is null
	 or
	 price_per_unit	is null 
	 or
	 cogs is null
	 or
	 total_sale is null

-- DATA EXPLORATION --
-- HOW MANY SALES WE HAVE?
select count(*) from retail_sales

-- HOW MANY UNIQUE CUSTOMES WE HAVE?
select count( distinct customer_id) from retail_sales

-- HOW MANY UNIQUE CATEGORY
select distinct category from retail_sales

--1 write a sql query to retreive all colums of the sales made on 2022-11-05

select *
from retail_sales
where sale_date = '2022-11-05'

--2 write a sql query to retreive all transaction wjere the category is clothing and the quantity sold is more than 10 in the month of nov 2022
select *
from retail_sales
where category = 'Clothing'
and
to_char(sale_date, 'yyyy-mm')= '2022-11'
and 
quantiy >=4

--3 write sql query to calculate total sales(total_sale) for each category
select sum(total_sale), category
from retail_sales
group by category

--4 write sql query to find the average age of customer who purchased items from beauty category
select round(avg(age),2) as avg_age
from retail_sales
where category='Beauty'

--5 write a sql query to find all transactions where total sale is greater than 1000
select * from retail_sales
where total_sale>1000

--6 write a sql query to find the total number of transaction made my each gender in each category
select category, gender, count(*) 
from retail_sales
group 
     by 
	 category,
	 gender

--7 write a sql query to calculate the average sales of each month. find out the best selling month in each year

select 
       year,
	   month,
	   avg_sales
from
(
select
      extract(year from sale_date) as year,
	  extract(month from sale_date) as month,
	  avg(total_sale) as avg_sales,
	  rank() over(partition by extract(year from sale_date)order by avg(total_sale)desc) as rank
from retail_sales
group by 1,2
) as t1
where rank=1

--8 write a sql query to find out the top 5 customers based on the highest total sales

select customer_id, sum(total_sale) as highest_sales
from retail_sales
group by 1
order by 2 desc
limit 5

--9 write a sql query to find the number of unique customers who purchased items from each category

select count(distinct(customer_id)), category
from retail_sales
group by category


--10 write a sql query to find each shift and numbers of orders take in that shift(<12 'morning', between 12 & 17 'afternoon', >17 'evening')
with shift_sales
as
(
select *, 
       case
	   when extract (hour from sale_time) < 12 then 'Morning'
	   when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
	   else 'Evening'
	   end as shift
from retail_sales
)
select
       shift,
	   count(*) as total_sales
from shift_sales
group by shift 


--End of project















