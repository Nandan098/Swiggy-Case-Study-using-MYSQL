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
<img width="205" height="100" alt="1" src="https://github.com/user-attachments/assets/2539cb43-0d26-4a6e-ab5d-5ae5f115b52e" />


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
<img width="405" height="278" alt="2 (2)" src="https://github.com/user-attachments/assets/4e82784d-30da-46f7-844c-26e6fd4096d4" />

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
<img width="273" height="69" alt="3" src="https://github.com/user-attachments/assets/29154ae2-fceb-4ab9-81b1-15dc593db033" />

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
<img width="282" height="157" alt="4" src="https://github.com/user-attachments/assets/be694198-02de-465e-a7bb-6a586707b13a" />

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
<img width="372" height="180" alt="5" src="https://github.com/user-attachments/assets/edfdc30c-3e9d-4f72-8de6-0daedfa01cdf" />


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
<img width="252" height="182" alt="6" src="https://github.com/user-attachments/assets/5ad29e8a-2259-4123-a635-45ba6de46ab1" />


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
<img width="301" height="127" alt="7" src="https://github.com/user-attachments/assets/b6960724-869e-4613-96e7-4f2e84ea12b2" />

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
<img width="290" height="132" alt="8" src="https://github.com/user-attachments/assets/9b7fc2a6-cab1-4b9d-9ee1-4262db821b60" />

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
    GROUP BY u.user_id, u.name, f.f_name)
WHERE ranks=1;
```
<img width="250" height="175" alt="9" src="https://github.com/user-attachments/assets/d939bfe0-c724-4887-82fb-dfe6ce036fc2" />

