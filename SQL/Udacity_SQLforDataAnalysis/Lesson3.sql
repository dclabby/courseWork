/*Find the total amount of poster_qty paper ordered in the orders table. */
SELECT SUM(poster_qty) as sum_poster_qty
FROM orders

/*Find the total amount of standard_qty paper ordered in the orders table.*/
SELECT SUM(standard_qty) as sum_standard_qty
FROM orders

/*Find the total dollar amount of sales using the total_amt_usd in the orders table. */
SELECT SUM(total_amt_usd) as sum_total_amt_usd
FROM orders

/*Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. 
This should give a dollar amount for each order in the table.*/
SELECT SUM(standard_amt_usd) as sum_standard_amt_usd,
SUM(gloss_amt_usd) as sum_gloss_amt_usd
FROM orders

SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

/*Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.*/
SELECT SUM(standard_amt_usd)/SUM(standard_qty) as cost_per_std
FROM orders

/* NOTES FROM VIDEO ON AVG:
- AVG ignores NULL values, so that rows with NULL values are not countec. IF we want to treat NULL as 0 then we need to calculate average as SUM(x)/COUNT(x)
- finding the median happens to be a pretty difficult thing to get using SQL alone — so difficult that finding a median is occasionally asked as an interview question.*/


/*When was the earliest order ever placed? You only need to return the date.*/
SELECT MIN(occurred_at) as earliest_order
FROM orders

/*Try performing the same query as in question 1 without using an aggregation function. */
SELECT occurred_at as earliest_order
FROM orders
ORDER BY occurred_at
LIMIT 1

/*When did the most recent (latest) web_event occur?*/
SELECT MAX(occurred_at) as latest_order
FROM orders

/*Try to perform the result of the previous query without using an aggregation function.*/
SELECT occurred_at as latest_order
FROM orders
ORDER BY occurred_at DESC
LIMIT 1

/*Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. 
Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount. */
SELECT 
AVG(standard_amt_usd) as avg_std_cost,
AVG(gloss_amt_usd) as avg_gls_cost,
AVG(poster_amt_usd) as avg_pst_cost,
AVG(standard_qty) as avg_std_qty,
AVG(gloss_qty) as avg_gls_qty,
AVG(poster_qty) as avg_pst_qty
FROM orders

/*Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?*/
SELECT AVG(median_total_usd) 
FROM
(
SELECT total_amt_usd as median_total_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 2 OFFSET ((SELECT COUNT(total_amt_usd) FROM orders)/2 - 1)
) as subTable


/*NOTES ON GROUP BY: 
- Any columns in SELECT statement that are not aggregated should appear in the GROUP BY statement
- SQL evaluates the aggregations before the LIMIT clause*/

/*Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.*/
SELECT name, occurred_at
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
ORDER BY occurred_at
LIMIT 1

/*Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.*/
SELECT accounts.name, SUM(total_amt_usd)
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.name

/*Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? 
Your query should return only three values - the date, channel, and account name.*/
SELECT orders.occurred_at, web_events.channel, accounts.name
FROM accounts
JOIN web_events
ON web_events.account_id = accounts.id
JOIN orders 
ON accounts.id = orders.account_id
ORDER BY orders.occurred_at
LIMIT 1

SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id 
ORDER BY w.occurred_at DESC
LIMIT 1;

/*Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.*/
SELECT channel, COUNT(channel)
FROM web_events
GROUP BY channel

/*Who was the primary contact associated with the earliest web_event? */
SELECT primary_poc, occurred_at
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
ORDER BY occurred_at
LIMIT 1

/*What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.*/
SELECT name, MIN(total_amt_usd) smallest_order
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY name
ORDER BY smallest_order

/*Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.*/
SELECT region.name, COUNT(sales_reps.id) num_reps
FROM sales_reps
JOIN region
ON sales_reps.region_id = region.id
GROUP BY region.name
ORDER BY num_reps
