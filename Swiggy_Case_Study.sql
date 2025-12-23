use swiggy;

show tables;

-- delivery_partner
-- food
-- menu
-- order_details
-- orders
-- restaurants
-- users

-- Create table

CREATE TABLE RESTAURANTS (
    R_ID INT PRIMARY KEY,
    R_NAME VARCHAR(50) NOT NULL,
    CUISINE VARCHAR(50) NOT NULL
);

-- Insert data
INSERT INTO RESTAURANTS (R_ID, R_NAME, CUISINE) VALUES
(1, 'Dominos', 'Italian'),
(2, 'KFC', 'American'),
(3, 'Box8', 'North Indian'),
(4, 'Dosa Plaza', 'South Indian'),
(5, 'China Town', 'Chinese');


-- Create USERS table
CREATE TABLE USERS (
    USER_ID INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    EMAIL VARCHAR(100) NOT NULL,
    PASSWORD VARCHAR(50) NOT NULL
);

-- Insert data into USERS table
INSERT INTO USERS (USER_ID, NAME, EMAIL, PASSWORD) VALUES
(1, 'Nitish', 'nitish@gmail.com', 'p252h'),
(2, 'Khushboo', 'khushboo@gmail.com', 'hxn9b'),
(3, 'Vartika', 'vartika@gmail.com', '9hu7j'),
(4, 'Ankit', 'ankit@gmail.com', 'lkko3'),
(5, 'Neha', 'neha@gmail.com', '3i7qm'),
(6, 'Anupama', 'anupama@gmail.com', '46rdw2'),
(7, 'Rishabh', 'rishabh@gmail.com', '4sw123');


-- Create FOOD table
CREATE TABLE FOOD (
    F_ID INT PRIMARY KEY,
    F_NAME VARCHAR(50) NOT NULL,
    TYPE VARCHAR(20) NOT NULL
);

-- Insert data into FOOD table
INSERT INTO FOOD (F_ID, F_NAME, TYPE) VALUES
(1, 'Non-veg Pizza', 'Non-veg'),
(2, 'Veg Pizza', 'Veg'),
(3, 'Choco Lava cake', 'Veg'),
(4, 'Chicken Wings', 'Non-veg'),
(5, 'Chicken Popcorn', 'Non-veg'),
(6, 'Rice Meal', 'Veg'),
(7, 'Roti meal', 'Veg'),
(8, 'Masala Dosa', 'Veg'),
(9, 'Rava Idli', 'Veg'),
(10, 'Schezwan Noodles', 'Veg'),
(11, 'Veg Manchurian', 'Veg');


-- Create MENU table
CREATE TABLE MENU (
    MENU_ID INT PRIMARY KEY,
    R_ID INT NOT NULL,
    F_ID INT NOT NULL,
    PRICE INT NOT NULL,
    FOREIGN KEY (R_ID) REFERENCES RESTAURANTS(R_ID),
    FOREIGN KEY (F_ID) REFERENCES FOOD(F_ID)
);

-- Insert data into MENU table
INSERT INTO MENU (MENU_ID, R_ID, F_ID, PRICE) VALUES
(1, 1, 1, 450),
(2, 1, 2, 400),
(3, 1, 3, 100),
(4, 2, 3, 115),
(5, 2, 4, 230),
(6, 2, 5, 300),
(7, 3, 3, 80),
(8, 3, 6, 160),
(9, 3, 7, 140),
(10, 4, 6, 230),
(11, 4, 8, 180),
(12, 4, 9, 120),
(13, 5, 6, 250),
(14, 5, 10, 220),
(15, 5, 11, 180);


-- Create ORDERS table
CREATE TABLE ORDERS (
    ORDER_ID INT PRIMARY KEY,
    USER_ID INT NOT NULL,
    R_ID INT NOT NULL,
    AMOUNT INT NOT NULL,
    DATE DATE NOT NULL,
    PARTNER_ID INT NOT NULL,
    DELIVERY_TIME INT NOT NULL,
    DELIVERY_RATING INT,
    RESTAURANT_RATING INT,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (R_ID) REFERENCES RESTAURANTS(R_ID)
);

-- Insert data into ORDERS table
INSERT INTO ORDERS (
    ORDER_ID, USER_ID, R_ID, AMOUNT, DATE, PARTNER_ID,
    DELIVERY_TIME, DELIVERY_RATING, RESTAURANT_RATING
) VALUES
(1001, 1, 1, 550, '2022-05-10', 1, 25, 5, 3),
(1002, 1, 2, 415, '2022-05-26', 1, 19, 5, 2),
(1003, 1, 3, 240, '2022-06-15', 5, 29, 4, NULL),
(1004, 1, 3, 240, '2022-06-29', 4, 42, 3, 5),
(1005, 1, 3, 220, '2022-07-10', 1, 58, 1, 4),
(1006, 2, 1, 950, '2022-06-10', 2, 16, 5, NULL),
(1007, 2, 2, 530, '2022-06-23', 3, 60, 1, 5),
(1008, 2, 3, 240, '2022-07-07', 5, 33, 4, 5),
(1009, 2, 4, 300, '2022-07-17', 4, 41, 1, NULL),
(1010, 2, 5, 650, '2022-07-31', 1, 67, 1, 4),
(1011, 3, 1, 450, '2022-05-10', 2, 25, 3, 1),
(1012, 3, 4, 180, '2022-05-20', 5, 33, 4, 1),
(1013, 3, 2, 230, '2022-05-30', 4, 45, 3, NULL),
(1014, 3, 2, 230, '2022-06-11', 2, 55, 1, 2),
(1015, 3, 2, 230, '2022-06-22', 3, 21, 5, NULL),
(1016, 4, 4, 300, '2022-05-15', 3, 31, 5, 5),
(1017, 4, 4, 300, '2022-05-30', 1, 50, 1, NULL),
(1018, 4, 4, 400, '2022-06-15', 2, 40, 3, 5),
(1019, 4, 5, 400, '2022-06-30', 1, 70, 2, 4),
(1020, 4, 5, 400, '2022-07-15', 3, 26, 5, 3),
(1021, 5, 1, 550, '2022-07-01', 5, 22, 2, NULL),
(1022, 5, 1, 550, '2022-07-08', 1, 34, 5, 1),
(1023, 5, 2, 645, '2022-07-15', 4, 38, 5, 1),
(1024, 5, 2, 645, '2022-07-21', 2, 58, 2, 1),
(1025, 5, 2, 645, '2022-07-28', 2, 44, 4, NULL);


-- Create DELIVERY_PARTNERS table
CREATE TABLE DELIVERY_PARTNERS (
    PARTNER_ID INT PRIMARY KEY,
    PARTNER_NAME VARCHAR(50) NOT NULL
);

-- Insert data into DELIVERY_PARTNERS table
INSERT INTO DELIVERY_PARTNERS (PARTNER_ID, PARTNER_NAME) VALUES
(1, 'Suresh'),
(2, 'Amit'),
(3, 'Lokesh'),
(4, 'Kartik'),
(5, 'Gyandeep');


-- Create ORDER_DETAILS table
CREATE TABLE ORDER_DETAILS (
    ID INT PRIMARY KEY,
    ORDER_ID INT NOT NULL,
    F_ID INT NOT NULL,
    FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID),
    FOREIGN KEY (F_ID) REFERENCES FOOD(F_ID)
);

-- Insert data into ORDER_DETAILS table
INSERT INTO ORDER_DETAILS (ID, ORDER_ID, F_ID) VALUES
(1, 1001, 1),
(2, 1001, 3),
(3, 1002, 4),
(4, 1002, 3),
(5, 1003, 6),
(6, 1003, 3),
(7, 1004, 6),
(8, 1004, 3),
(9, 1005, 7),
(10, 1005, 3),
(11, 1006, 1),
(12, 1006, 2),
(13, 1006, 3),
(14, 1007, 4),
(15, 1007, 3),
(16, 1008, 6),
(17, 1008, 3),
(18, 1009, 8),
(19, 1009, 9),
(20, 1010, 10),
(21, 1010, 11),
(22, 1010, 6),
(23, 1011, 1),
(24, 1012, 8),
(25, 1013, 4),
(26, 1014, 4),
(27, 1015, 4),
(28, 1016, 8),
(29, 1016, 9),
(30, 1017, 8),
(31, 1017, 9),
(32, 1018, 10),
(33, 1018, 11),
(34, 1019, 10),
(35, 1019, 11),
(36, 1020, 10),
(37, 1020, 11),
(38, 1021, 1),
(39, 1021, 3),
(40, 1022, 1),
(41, 1022, 3),
(42, 1023, 3),
(43, 1023, 4),
(44, 1023, 5),
(45, 1024, 3),
(46, 1024, 4),
(47, 1024, 5),
(48, 1025, 3),
(49, 1025, 4),
(50, 1025, 5);


                                               -- Questions
                                               
-- 1. Find customers who have never ordered ?
      select user_id,name
      from users
      where user_id not in (select distinct user_id from orders);
      
      
-- 2. Average Price/dish
      select f.f_id,f.f_name,round(avg(m.price),2) as avg_price_per_dish
      from food as f
      join
      menu as m
      on f.f_id=m.f_id
      group by f.f_id,f.f_name;
      
-- 3. Find the top restaurant in terms of the number of orders for a given month
      select r.r_id,r.r_name,count(*) as no_of_orders
      from restaurants as r
      join
      orders as o
      on r.r_id=o.r_id
      where month(o.date)=6
      group by r.r_id,r.r_name
      order by no_of_orders desc
      limit 3;
      
-- 4. restaurants with monthly sales greater than 500 ? 
      select r.r_id,r.r_name,sum(o.amount) as total_sales
      from restaurants as r
      join
      orders as o
      on r.r_id=o.r_id
      group by r.r_id,r.r_name
      where 
      having total_sales>200
      order by total_sales desc;
      
-- 5. Show all orders with order details for a particular customer in a particular date range ?
      select o.user_id,o.order_id,r.r_name,f.f_name
      from orders as o
      join
      order_details as od
      join
      food as f
      join 
      restaurants as r
      on o.order_id=od.order_id
      and od.f_id=f.f_id
      and o.r_id=r.r_id
      where o.user_id=1
      and o.date between '2022-06-10' and '2022-07-10'
      group by o.user_id,o.order_id,r.r_name,f.f_name;
      
      
-- 6. Find restaurants with max repeated customers
      select  r_name,name as loyal_customer from ( select r.r_id,r.r_name,u.user_id,u.name,count(*) as loyal_customer, rank() over(partition by r_id,r_name order by count(*) desc) as ranks
      from restaurants as r
      join
      users as u
      join
      orders as o
      on r.r_id=o.r_id
      and u.user_id=o.user_id
      group by r.r_id,r.r_name,u.user_id,u.name) as t
      where ranks=1;
      
-- 7. running revenue by month
     select month_name,revenue,sum(revenue) over(rows between unbounded preceding and current row) as running_revenue 
     from (select monthname(date) as month_name,round(sum(amount),2) as revenue
		   from orders as o
		   group by month_name) as t;
     
-- 8. Month over month revenue growth of swiggy
      with t as ( select monthname(date) as month_name,sum(amount) as revenue
                  from orders
				  group by month_name)
		
	 select month_name,revenue,(revenue - lag(revenue) over())*100.0/lag(revenue) over() as growth_percent 
     from t;
     
      
      
-- 9. Customer - favorite food
      select name,f_name as favourite_food
	  from ( select u.user_id,u.name,f.f_name,count(*) as number_of_times_ordered,rank() over(partition by u.name order by count(*) desc) as ranks
		     from users as u
			 join 
			 orders as o
			 join
			 order_details as od
			 join
			 food as f
			 on u.user_id=o.user_id
			 and o.order_id=od.order_id
			 and od.f_id=f.f_id
			 group by u.user_id,u.name,f.f_name) as t
		where ranks=1;
 
 -- 10. 
	
      