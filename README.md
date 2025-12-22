### Swiggy Case Study

1.	Create a DATABASE: SWIGGY
### TABLES

####   Users
| COLUMN NAME | DATA TYPE     | REMARKS |
|-------------|---------------|---------|
| USER_ID     | INTEGER       | PRIMARY KEY |
| NAME        | VARCHAR(40)   | NOT NULL |
| EMAIL       | VARCHAR(40)   | NOT NULL |
| PASSWORD    | VARCHAR(50)   | NOT NULL |


#### Restaurants
| COLUMN NAME | DATA TYPE     | REMARKS |
|-------------|---------------|---------|
| RESTAURANT_ID | TINYINT     | PRIMARY KEY |
| R_NAME      | VARCHAR(40)  | NOT NULL |
| CUISINE     | VARCHAR(50)  | NOT NULL |


#### Food
| COLUMN NAME | DATA TYPE     | REMARKS |
|-------------|---------------|---------|
| F_ID        | INT           | PRIMARY KEY |
| F_NAME      | VARCHAR(40)   | NOT NULL |
| TYPE        | VARCHAR(30)   | NOT NULL |


#### Menu
| COLUMN NAME | DATA TYPE | REMARKS |
|-------------|-----------|---------|
| MENU_ID     | INTEGER   | PRIMARY KEY |
| RESTAURANT_ID | INTEGER | FOREIGN KEY |
| FOOD_ID     | INTEGER   | FOREIGN KEY |
| PRICE       | INTEGER   | NOT NULL |


####  Orders
| COLUMN NAME          | DATA TYPE        | REMARKS |
|----------------------|------------------|---------|
| ORDER_ID             | INTEGER          | PRIMARY KEY |
| USER_ID              | INTEGER          | FOREIGN KEY |
| RESTAURANT_ID        | INTEGER          | FOREIGN KEY |
| AMOUNT               | INTEGER          | NOT NULL |
| ORDER_DATE           | DATE             | STORES ORDER DATE |
| PARTNER_ID           | VARCHAR(40)      | NOT NULL |
| DELIVERY_TIME        | INTEGER          | NOT NULL (IN MINUTES) |
| DELIVERY_RATING      | DECIMAL(2,1)     | NOT NULL |
| RESTAURANT_RATING    | DECIMAL(2,1)     | RATING FROM 1.0 TO 5.0 |

#### QUESTIONS

-- Q1. Find customers who have never ordered
```sql
SELECT user_id, name
FROM users
WHERE user_id NOT IN (
    SELECT DISTINCT user_id
    FROM orders
);
```
-- Q2. Average price per dish
```sql
SELECT f.f_id,
       f.f_name,
       ROUND(AVG(m.price), 2) AS avg_price_per_dish
FROM food f
JOIN menu m
ON f.f_id = m.f_id
GROUP BY f.f_id, f.f_name;
```
-- Q3. Find the top restaurant in terms of number of orders for a given month (June)
```sql
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
```
-- Q4. Restaurants with monthly sales greater than 500
```sql
SELECT r.r_id,
       r.r_name,
       SUM(o.amount) AS total_sales
FROM restaurants r
JOIN orders o
ON r.r_id = o.r_id
GROUP BY r.r_id, r.r_name
HAVING total_sales > 500
ORDER BY total_sales DESC;
```
-- Q5. Show all orders with order details for a particular customer in a particular date range
```sql
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
```
-- Q6. Find restaurants with max repeated customers
```sql
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
```
-- Q7. Running revenue by month
```sql
SELECT month,
       revenue,
       SUM(revenue) OVER (ORDER BY month) AS running_revenue
FROM (
    SELECT MONTH(date) AS month,
           SUM(amount) AS revenue
    FROM orders
    GROUP BY MONTH(date)
) t;
```
-- Q8. Month-over-month revenue growth
```sql
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
```
-- Q9. Customer favorite food
```sql
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
    GROUP BY u.user_id, u._
```
