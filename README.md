# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_p1`

## Project Overview: 
This project is designed to showcase essential SQL skills commonly used by data analysts to explore, clean, and derive insights from retail sales data. The aim is to help beginners in data analysis build a strong foundation in SQL through practical tasks such as database setup, exploratory data analysis, and solving real-world business queries.

## Objectives
**1.Database Initialization**: Establish and populate a retail sales database using the provided dataset.

**2.Data Cleaning**: Detect and eliminate any entries that contain missing or null values.

**3.Exploratory Data Analysis (EDA)**: Conduct initial analysis to understand the overall structure and trends within the dataset.

**4.Business Insights**: Write SQL queries to answer targeted business questions and extract meaningful insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: Begin by setting up a new SQL database named .
- **Table Creation**: Create a table called retail_sales to hold the sales data. This table includes fields such as transaction ID, sale date and time, customer ID, gender, age, product category, quantity sold, unit price, cost of goods sold (COGS), and total sale amount.
```sql
CREATE DATABASE sql_project_p1;
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Count how many total records are in the dataset..
- **Customer Count**: Find the number of unique customers.
- **Category Count**: List all the unique product categories available.
- **Null Value Check**: Look for any null values in the data set and delete those records.

```sql
select count(*) from retail_sales;
select count( distinct customer_id) from retail_sales;
select distinct category from retail_sales;

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
	 age is null
	 or 
	 category is null 
	 or 
	 quantiy is null
	 or
	 price_per_unit	is null 
	 or
	 cogs is null
	 or
	 total_sale is null;

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
	 age is null
	 or 
	 category is null 
	 or 
	 quantiy is null
	 or
	 price_per_unit	is null 
	 or
	 cogs is null
	 or
	 total_sale is null;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select *
from retail_sales
where sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022**:
```sql
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select sum(total_sale), category
from retail_sales
group by category
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select round(avg(age),2) as avg_age
from retail_sales
where category='Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select * from retail_sales
where total_sale>1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select category, gender, count(*) 
from retail_sales
group 
     by 
	 category,
	 gender
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
select customer_id, sum(total_sale) as highest_sales
from retail_sales
group by 1
order by 2 desc
limit 5
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select count(distinct(customer_id)), category
from retail_sales
group by category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The data includes customers of different age groups. Sales are spread across categories like Clothing and Beauty.
- **High-Value Transactions**: Some sales were over 1000, showing that some customers made big purchases.
- **Sales Trends**: Monthly analysis shows changes in sales, helping to spot high and low sales seasons.
- **Customer Insights**: We found out who the top-spending customers are and which products are the most popular.

## Reports

- **Sales Summary**: A report that shows total sales, customer age/gender breakdown, and product category performance.
- **Trend Analysis**: Sales patterns across months and working shifts.
- **Customer Insights**: Lists of top customers and the number of unique buyers per product category.

## Conclusion

This project is a great hands-on way to learn SQL for data analysis. It covers everything from setting up a database to cleaning data, exploring it, and answering real business questions using SQL. The insights from this project can help businesses understand how customers behave and which products perform best.

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!
