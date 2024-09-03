-------------TABLE DESCRIPTION------------
-- The database have only table named uk_sales contain the data about the 
-- amazon sales. The data is collect via weekly basis
-- The database contain stores in which each store contains several department
-- The MAIN ideas behind this dataset is the weekly analysis of sales
-- The table contains the following column (I write it in UPPERCASE)
--------------------------------------------------------------------
-- DATE | STORE | DEPT | WEEKLY_SALES | TYPE | SIZE | TEMPERATURE | FUEL_PRICE | CPI(cusumer price index)
-- UNEMPLOYEMENT | ISHOLIDAY | YEAR | MONTH | WEEK | MAX | MIN | MEAN | STD(standard deviation)

---------HERE IS THE ANALYSIS-----------------


-- select the database for analysis
use uk_amazon_sales

------------------INSPECTION--------------------
--select all the data for inspection
select * from uk_sales;

------------------DATEA CLEARNING---------------
--clean the data
alter table uk_sales drop column Date2;

---------------DELETE THE UNSED COLUMN----------
-- now i use the cte to delete the null values. This dataset contains the records which in which there are
-- no sale these holidays
with null_date_cte as (
select * from uk_sales where [date] is null)
delete from null_date_cte

--- the markdown column have no use 
alter table uk_sales drop column total_markdown;

---------------SUMMARIZATION------------------
-- the summary of each store,deptt per week level
select [Week],store,dept,sum(weekly_sales) as total_weekly_sale
from uk_sales group by [week],store,dept order by [Week],store,dept;

-- summary of sales yearly wise
select distinct year,round(sum(Weekly_Sales),0) as total_yearly_sale
from uk_sales group by year order by total_yearly_sale desc;

-- comparsion temperature and fuel price 
select temperature ,fuel_price from uk_sales;
select distinct [date],temperature ,fuel_price from uk_sales order by [date];

-- maximum sales on store ,dept level
select distinct store,dept,[max] as max_sale from uk_sales order by store,Dept;

-- weekly minimum sale
select distinct store,dept,[min] from uk_sales order by store,Dept;

-- mean of sales on store ,dept level
select distinct [date],store,dept,mean from uk_sales order by store,Dept;

-----------------------TIMESERIES DATA ANALYSIS----------------------
-- timeseries date if we plot the data we can clearly see the time series bar
select [date],round(sum(weekly_sales),0) as total_weekly_sales
from uk_sales group by [date] order by [date] ;


