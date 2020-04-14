/* Welcome to the end of the course! 
The next three exercises will test your knowledge of the content covered in this course 
and apply many of the ideas you've seen to difficult problems. Good luck!
Read carefully over the instructions and solve them step-by-step, 
thinking about how the different clauses work together.
In this exercise, you'll need to get the country names and other 2015 data in the economies table 
and the countries table for Central American countries with an official language. */


/* INSTRUCTION
* Select unique country names. Also select the total investment and imports fields.
* Use a left join with countries on the left. (An inner join would also work, but please use a left join here.)
* Match on code in the two tables and use a subquery inside of on to choose the appropriate languages records.
* Order by country name ascending
* Use table aliasing but not field aliasing in this exercise. */

-- SELECT fields
SELECT DISTINCT name, total_investment, imports
  -- From table (with alias)
  FROM countries AS c
    -- Join with table (with alias)
    LEFT JOIN economies AS e
      -- Match on code
      ON (c.code = e.code
      -- AND code IN Subquery
        AND c.code IN (
          SELECT code
          FROM languages AS l
          WHERE official = 'true'
        ) )
  -- WHERE region AND year are correct
  WHERE region = 'Central America' AND year = 2015
-- ORDER BY field
ORDER BY name;




/* <My Own Solutions (1/2)> */

SELECT name, total_investment, imports
FROM countries
INNER JOIN economies
USING (code)
WHERE year = 2015 
AND region = 'Central America'
AND code IN (
        SELECT code
        FROM economies
        INNER JOIN languages
        USING (code)
        WHERE year = 2015 AND official = 'true'
)
ORDER BY name;


/* <My Own Solutions (2/2)> */
SELECT distinct name, total_investment, imports
FROM countries
INNER JOIN economies
USING (code)
WHERE year = 2015 
AND region = 'Central America'
AND code IN (
        SELECT code 
        FROM languages
        WHERE official = 'true'
)
ORDER BY country;

