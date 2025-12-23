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



															  -- QUESTIONS
                                                              
-- Q1. Find customers who have never ordered 
SELECT user_id, name
FROM users
WHERE user_id NOT IN (
    SELECT DISTINCT user_id
    FROM orders
);

-- Q2. Average price per dish
SELECT f.f_id,
       f.f_name,
       ROUND(AVG(m.price), 2) AS avg_price_per_dish
FROM food f
JOIN menu m
ON f.f_id = m.f_id
GROUP BY f.f_id, f.f_name;

-- Q3. Find the top restaurant in terms of number of orders for a given month (June)
SELECT r.r_id,
       r.r_name,
       COUNT(*) AS no_of_orders
FROM restaurants r
JOIN orders o
ON r.r_id = o.r_id
WHERE MONTH(o.date) = 6
GROUP BY r.r_id, r.r_name
ORDER BY no_of_orders DESC
LIMIT 1;

-- Q4. Restaurants with monthly sales greater than 500
SELECT r.r_id,
       r.r_name,
       SUM(o.amount) AS total_sales
FROM restaurants r
JOIN orders o
ON r.r_id = o.r_id
GROUP BY r.r_id, r.r_name
HAVING total_sales > 500
ORDER BY total_sales DESC;

-- Q5. Show all orders with order details for a particular customer in a particular date range
SELECT o.user_id,
       o.order_id,
       r.r_name,
       f.f_name
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
JOIN food f
ON od.f_id = f.f_id
JOIN restaurants r
ON o.r_id = r.r_id
WHERE o.user_id = 1
AND o.date BETWEEN '2022-06-10' AND '2022-07-10';

-- Q6. Find restaurants with max repeated customers
SELECT r_name,
       name AS loyal_customer
FROM (
    SELECT r.r_id,
           r.r_name,
           u.user_id,
           u.name,
           COUNT(*) AS order_count,
           RANK() OVER (PARTITION BY r.r_id ORDER BY COUNT(*) DESC) AS ranks
    FROM restaurants r
    JOIN orders o
    ON r.r_id = o.r_id
    JOIN users u
    ON u.user_id = o.user_id
    GROUP BY r.r_id, r.r_name, u.user_id, u.name
) t
WHERE ranks = 1;

-- Q7. Running revenue by month
SELECT month,
       revenue,
       SUM(revenue) OVER (ORDER BY month) AS running_revenue
FROM (
    SELECT MONTH(date) AS month,
           SUM(amount) AS revenue
    FROM orders
    GROUP BY MONTH(date)
) t;

-- Q8. Month-over-month revenue growth
WITH t AS (
    SELECT MONTH(date) AS month,
           SUM(amount) AS revenue
    FROM orders
    GROUP BY MONTH(date)
)
SELECT month,
       revenue,
       ROUND(
           (revenue - LAG(revenue) OVER (ORDER BY month)) * 100.0 /
           LAG(revenue) OVER (ORDER BY month),
       2) AS growth_percent
FROM t;

-- Q9. Customer favorite food
SELECT name,
       f_name AS favourite_food
FROM (
    SELECT u.user_id,
           u.name,
           f.f_name,
           COUNT(*) AS order_count,
           RANK() OVER (PARTITION BY u.user_id ORDER BY COUNT(*) DESC) AS ranks
    FROM users u
    JOIN orders o
    ON u.user_id = o.user_id
    JOIN order_details od
    ON o.order_id = od.order_id
    JOIN food f
    ON od.f_id = f.f_id
    GROUP BY u.user_id, u.name, f.f_name
) t
WHERE ranks = 1;


