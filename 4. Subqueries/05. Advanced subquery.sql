/*You can also nest multiple subqueries to answer even more specific questions.

In this exercise, for each of the six continents listed in 2015, 
you'll identify which country had the maximum inflation rate (and how high it was) using multiple subqueries. 
The table result of your query in Task 3 should look something like the following, where anything between < > will be filled in with appropriate values:

+------------+---------------+-------------------+
| name       | continent     | inflation_rate    |
|------------+---------------+-------------------|
| <country1> | North America | <max_inflation1>  |
| <country2> | Africa        | <max_inflation2>  |
| <country3> | Oceania       | <max_inflation3>  |
| <country4> | Europe        | <max_inflation4>  |
| <country5> | South America | <max_inflation5>  |
| <country6> | Asia          | <max_inflation6>  |
+------------+---------------+-------------------+

Again, there are multiple ways to get to this solution using only joins, 
but the focus here is on showing you an introduction into advanced subqueries.*/


/*INSTRUCTION (1/3)
* Now it's time to append the second part's query to the first part's query using AND and IN to obtain the name of the country, its continent, and the maximum inflation rate for each continent in 2015!
* For the sake of practice, change all joining conditions to use ON instead of USING (based upon the same column, code).
* Revisit the sample output in the assignment text at the beginning of the exercise to see how this matches up.*/

-- Select fields
SELECT name, continent, inflation_rate
  -- From countries
  FROM countries
  	-- Join to economies
  	INNER JOIN economies
    -- Match on code
    ON countries.code = economies.code
-- Where year is 2015
WHERE year = 2015;


/*INSTRUCTION (2/3)
Select the maximum inflation rate in 2015 AS max_inf grouped by continent using the previous step's query as a subquery in the FROM clause.

* Thus, in your subquery you should:
* Create an inner join with countries on the left and economies on the right with USING (without aliasing your tables or columns).
* Retrieve the country name, continent, and inflation rate for 2015.
* Alias the subquery as subquery.

This will result in the six maximum inflation rates in 2015 for the six continents as one field table. Make sure to not include continent in the outer SELECT statement.*/

-- Select the maximum inflation rate as max_inf
SELECT max(inflation_rate) AS max_inf
  -- Subquery using FROM (alias as subquery)
  FROM (SELECT name, continent, inflation_rate
      FROM countries
      INNER JOIN economies
      USING (code)
      WHERE year=2015) AS subquery
-- Group by continent
GROUP BY continent;


/*INSTRUCTION (3/3)

* Now it's time to append your second query to your first query using AND and IN to obtain the name of the country, 
  its continent, and the maximum inflation rate for each continent in 2015.
* For the sake of practice, change all joining conditions to use ON instead of USING.*/

-- Select fields
SELECT name, continent, inflation_rate
  -- From countries
  FROM countries
	-- Join to economies
	INNER JOIN economies
	-- Match on code
	ON countries.code = economies.code
  -- Where year is 2015
  WHERE year = 2015
    -- And inflation rate in subquery (alias as subquery)
    AND inflation_rate IN (
        SELECT MAX(inflation_rate) AS max_inf
        FROM (
             SELECT name, continent, inflation_rate
             FROM countries
             INNER JOIN economies
             USING (code)
             WHERE year = 2015) AS subquery
      -- Group by continent
        GROUP BY continent);





/* <Explanation on the final queries>

Among every inflation_rate data, you have to pick up the maximum inflation_rate corresponding to each type of the continent.
So, before selecting all the required columns, you need to extract "max(inflation_rate)" matched to respect continent 
by using "GROUP BY."
While takin this process, you can make a subquery in FROM clause. 
The subquery will provides you with an arbitrary table from which you can take the MAX(inf_rate) out. 
Note that you don't have to include "name" in SELECT clause in this FROM subquery. 
Once you get the MAX(inf_rate) of year 2015 grouped by each continent, 
you have to complete the whole queries by matching the max one with the corresponding countries with continent.*/


/* <My Own Solution>

My guess is the FROM subquery is redundant. So, I just deleted the subquery, 
then got the max(inf_rate) directly from "economies" table joined to "countries" table 
by continent. 
The result is as follows below: */

SELECT name, continent, inflation_rate
FROM countries
INNER JOIN economies
    USING (code)
WHERE year = 2015
    AND inflation_rate IN (
        SELECT MAX(inflation_rate)
        FROM countries
        INNER JOIN economies
            USING (code)
        WHERE year = 2015
        GROUP BY continent);
