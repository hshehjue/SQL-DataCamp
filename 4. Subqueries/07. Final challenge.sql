/* Welcome to the end of the course! 
The next three exercises will test your knowledge of the content covered IN this course 
AND apply many of the ideas you've seen to difficult problems. Good luck!
Read carefully over the INstructions AND solve them step-by-step, 
thINkINg about how the different clauses work together.
IN this exercise, you'll need to get the country names AND other 2015 data IN the economies table 
AND the countries table for Central American countries with an official language. */


/* INSTRUCTION
* SELECT unique country names. Also SELECT the total INvestment AND imports fields.
* Use a left joIN with countries on the left. (An INNER JOIN would also work, but please use a left joIN here.)
* Match on code IN the two tables AND use a subquery INside of ON to choose the appropriate languages records.
* ORDER BY country name ascendINg.
* Use table aliasINg but not field aliasINg IN this exercise. */

-- SELECT fields
SELECT DISTINCT name, total_INvestment, imports
  -- From table (with alias)
  FROM countries AS c
    -- JoIN with table (with alias)
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




/* My Own Solutions (1/2) */

SELECT name, total_INvestment, imports
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


/* My Own Solutions (2/2) */
SELECT distINct name, total_INvestment, imports
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

