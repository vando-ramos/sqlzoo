-- 1. You may use a SELECT statement in the FROM line.

-- In this case the derived table X has columns name and gdp_per_capita.
-- The calculated values in the inner SELECT can be used in the outer SELECT.

SELECT name, ROUND (gdp_per_capita)
FROM (SELECT name, gdp / population AS gdp_per_capita FROM bbc) X
WHERE gdp_per_capita > 20000;

-- Notice that

-- the inner table is given an alias X
-- the first column in the inner query keeps its name
-- the second column in the inner query has an alias

-- 2. Find the countries in the same region as Bhutan

-- You may use a SELECT statement in the WHERE line - this returns a list of regions.

SELECT name FROM bbc
WHERE region IN (
SELECT region FROM bbc
WHERE name = 'Bhutan'
);

-- 3. If a value from the outer query appears in the inner query this is "correlated subquery".

-- Show the countries where the population is greater than 5 times the average for its region

SELECT name FROM bbc b1
WHERE population > 5 * (SELECT AVG (population)
FROM bbc WHERE region = b1.region);