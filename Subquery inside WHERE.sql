/* You will now try to figure out which countries had high average life expectancies (at the country level) in 2015.*/

/*INSTRUCTION
Begin by calculating the average life expectancy across all countries for 2015.*/

-- Select average life_expectancy
SELECT avg(life_expectancy)
  -- From populations
  FROM populations
-- Where year is 2015
WHERE year = 2015;