-- 1. List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world
WHERE population > (
SELECT population FROM world
WHERE name = 'Russia');

-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name FROM world
WHERE gdp/population > (
SELECT gdp/population
FROM world
WHERE name = 'United Kingdom')
AND continent = 'Europe';

-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. 
--    Order by name of the country.

SELECT name, continent
FROM world
WHERE continent IN (
SELECT continent FROM world
WHERE name = 'Argentina' 
OR name = 'Australia');

-- 4. Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.

SELECT name, population FROM world
WHERE population > (SELECT population FROM world 
WHERE name = 'United Kingdom')
AND population < (SELECT population FROM world 
WHERE name = 'Germany');

-- 5. Germany (population 80 million) has the largest population of the countries in Europe. 
--    Austria (population 8.5 million) has 11% of the population of Germany.

-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

-- The format should be Name, Percentage for example:

--   name    | percentage
-- ----------+------------  
--   Albania | 3%
--   Andorra | 0%
--   Austria | 11%
--   ...     | ...

SELECT name, CONCAT (ROUND (population * 100 / (  
SELECT population  FROM world  
WHERE name = 'Germany')), '%') percentage
FROM world
WHERE continent = 'Europe';

-- 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

SELECT name FROM world
WHERE GDP > ALL (
SELECT GDP FROM world
WHERE continent='Europe'
AND population > 0);

-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area:

SELECT continent, name, area 
FROM world x
WHERE area >= ALL(
SELECT area
FROM world y
WHERE y.continent = x.continent);

-- 8. List each continent and the name of the country that comes first alphabetically.

SELECT continent, name
FROM world x
WHERE name = (SELECT name
FROM world y
WHERE x.continent = y.continent
ORDER BY name LIMIT 1);

-- 9. Find the continents where all countries have a population <= 25000000. 
--    Then find the names of the countries associated with these continents. 
--    Show name, continent and population.

SELECT name, continent, population
FROM world x
WHERE 25000000 >= ALL(
SELECT population
FROM world y
WHERE x.continent = y.continent);

-- 10. Some countries have populations more than three times that of all of their neighbours (in the same continent). 
--     Give the countries and continents.

SELECT name, continent
FROM world x
WHERE population > ALL(
SELECT population * 3
FROM world y
WHERE x.continent = y.continent
AND x.name <> y.name);