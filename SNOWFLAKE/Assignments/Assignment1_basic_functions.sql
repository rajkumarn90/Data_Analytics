
--1. Load the given dataset into snowflake with a primary key to Order Date column.

use database DEMODATABASE;

create or replace table RJ_SALES_DATA 
(
order_id varchar(20),
order_date DATE primary key,
ship_date DATE,
ship_mode varchar(20),
customer_name varchar(30),
segment varchar(20),
state varchar(100),
country varchar(50),
market varchar(10),
region varchar(20),
product_id varchar(20),
category varchar(20),
sub_category varchar (20),
product_name varchar(200),
sales int,
quantity int,
discount float,
profit float,
shipping_cost float,
order_priority varchar(10),
year int
);

desc table RJ_SALES_DATA;

select * from RJ_SALES_DATA;

--2. Change the Primary key to Order Id Column.

alter table RJ_SALES_DATA drop primary key;
alter table RJ_SALES_DATA add primary key(order_id);


--3. Check the data type for Order date and Ship date and mention in what data type it should be?

--order_date and Ship_date were alreday taken as DATE datatype

--4. Create a new column called order_extract and extract the number after the last‘–‘from Order ID column.
create or replace table RJ_SALES_DATA as 
select *,split_part(order_id,'-',3) as order_extract from RJ_SALES_DATA;

--5. Create a new column called Discount Flag and categorize it based on discount.Use ‘Yes’ if the discount is greater than zero else ‘No’.

create or replace table RJ_SALES_DATA as 
select * ,
case 
    when DISCOUNT > 0 then 'yes'
    else 'No'
end as DISCOUNT_FLAG from RJ_SALES_DATA;

--6. Create a new column called process days and calculate how many days it takes for each order id to process from the order to its shipment.

create or replace table RJ_SALES_DATA as 
select *,DATEDIFF(Days,ORDER_DATE,SHIP_DATE) as PROCESS_DAYS FROM RJ_SALES_DATA ;

/*
7. Create a new column called Rating and then based on the Process dates give
rating like given below.
a. If process days less than or equal to 3days then rating should be 5
b. If process days are greater than 3 and less than or equal to 6 then rating
should be 4
c. If process days are greater than 6 and less than or equal to 10 then rating
should be 3
d. If process days are greater than 10 then the rating should be 2.
*/

create or replace table RJ_SALES_DATA as 
select *, 
    CASE 
        when PROCESS_DAYS <=3 then 5
        when PROCESS_DAYS BETWEEN 4 AND 6 THEN 4
        when PROCESS_DAYS BETWEEN 7 AND 10 THEN 3
    else 2
    end as RATING from RJ_SALES_DATA;
