/*Use your knowledge of subqueries in WHERE to get the urban area population for only capital cities.*/

/*INSTRUCTION
Make use of the capital field in the countries table in your subquery.

Select the city name, country code, and urban area population fields.*/

-- 2. Select fields
select name, country_code, urbanarea_pop
  -- 3. From cities
  from cities
-- 4. Where city name in the field of capital cities
where name IN
  -- 1. Subquery
  (select capital from countries)
ORDER BY urbanarea_pop DESC;