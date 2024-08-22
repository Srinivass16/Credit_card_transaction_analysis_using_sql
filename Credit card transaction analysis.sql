	--1. write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 

	with Perentagecte as ( select distinct top 5 City,
						sum(CAST([Amount] as bigint)) OVER  (partition by city ) as city_wise_total ,
						sum(cast(amount as bigint)) over ( order by city rows between unbounded preceding and unbounded followiNg) as total 
						from [Credit card transactions]
						order by city desc)
	select city,city_wise_total , total ,100*city_wise_total/total perc from Perentagecte




	--2. write a query to print highest spend month and amount spent in that month for each card type

	select * from (
					select DATEPART( year , date ) as 'year',
						   datepart( month , date ) as 'month',
						   card_type, sum(cast(amount as bigint)) as total_amount,
						   rank() over ( partition by Card_Type order by  sum(cast(amount as bigint)) desc )rnk
						   from [Credit card transactions]
						   group by Card_Type,DATEPART( year , date ),datepart( month , date )) a 
						   where rnk = 1


	--3. write a query to print the transaction details(all columns from the table) for each card type when
	--it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)

	with C1 as (
				select * , sum(amount) over ( partition by card_type  order by date , amount ) as card_spend
				from [Credit card transactions]
				)
		 , C2 as (
				  select *, rank() over (partition by card_type order by card_spend) rnk 
				   from C1 
				   where card_spend >1000000
				   )
	select * from c2 where rnk = 1


	--4. write a query to find city which had lowest percentage spend for gold card type
	with C1 as (
				 select  distinct city, card_type ,
				 sum(amount) over ( partition by city , card_type) as amount_card,
				 sum(amount ) over (partition by city) as amount_city
				 from [Credit card transactions]
				 )

	select top 1 *, round(100*cast(amount_card as float)/cast(amount_city as float), 2) as percentage 
	from c1
	where card_type='gold'
	order by amount_card

	--5. write a query to print 3 columns: city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)

	with C1 as (
				 select city , exp_type, sum(amount) amount_by_type
				 from [Credit card transactions]
				 group by  city , exp_type
				 )
				,
	C2 as   (
			   select city , max(amount_by_type) as max_amount , min(amount_by_type) as min_amount
			   from c1 
			   group by city)

	select c1.city ,
	max(case when c1.amount_by_type = c2.max_amount then c1.exp_type end ) as highest_exp_type,
	max(case when c1.amount_by_type = c2.min_amount then c1.exp_type end ) as lowest_exp_type
	from c1 inner join c2 
	on 
	c1.city = c2.city 
	group by c1.city 
	order by c1.city asc


	--6. write a query to find percentage contribution of spends by females for each expense type

	with C1 as (
				 select exp_type, gender, sum(cast(amount as float)) amount_by_female
				 from [Credit card transactions]
				 where Gender = 'F'
				 group by Gender, Exp_Type
				 )
	,C2 as (
			 select exp_type, sum(cast(amount as float)) as total_exp_amount 
			 from [Credit card transactions] 
			 group by exp_type
			 )

	select C2.exp_type ,
		   c1.amount_by_female,
		   c2.total_exp_amount,
		   ROUND(100*c1.amount_by_female/c2.total_exp_amount,2) as percentage
		   from c1 join c2 
		   on  c1.exp_type = c2.exp_type


	--7. which card and expense type combination saw highest month over month growth in Jan-2014

	with c1 as (
				 select card_type,exp_type,
				 DATEPART(year,date) trans_year,
				 datepart(month, date ) tans_month,
				 sum(amount) as total_amount
				 from [Credit card transactions]
				 group by Card_Type ,Exp_Type, DATEPART(YEAR, Date), DATEPART(MONTH, Date) 
				 order by Card_Type
				 )
	, c2 as   (
				select *, lag(total_amount,1) over (partition by card_type , exp_type order by trans_year,tans_month) as per_month  
				from c1)

	select top 1 * , 100*CAST((total_amount - per_month ) as float ) / cast(per_month as float) as  percentages
	from c2
			where trans_year= 2014 and tans_month= 1
			order by percentages





	--8. during weekends which city has highest total spend to total no of transcations ratio 

	select top 1 city ,
			   sum(amount) as amount_city ,
			   count(1) as no_of_trans,
			   sum(amount)/count(1) as ratio 
			   from [Credit card transactions]
			   where DATEPART(WEEKDAY , date ) in (7,1)
			   group by city 
			   order by ratio desc

	--9. which city took least number of days to reach its 500th transaction after first transaction in that city

	with c1 as (
				select City, Date, ROW_NUMBER() over(partition by city order by date) trans_no
				from [Credit card transactions]
				)
		,c2 as (
				select *
				,LEAD(Date,1) over(order by city) day500
				,datediff(day,  date, LEAD(Date,1) over(order by city)) days_taken
				from c1
				where City in (select city from c1	where trans_no =500)
				and trans_no in (1,500)
				)
	select  top 1 * from c2
	where trans_no = 1
	order by days_taken






























	         

			
	          











					