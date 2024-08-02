-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been
-- traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed,
-- so find the least populated country in Southern Europe, and we'll start looking for her there.

 SELECT country.name AS country_name, country.continent AS country_continent, country.region AS country_region
 WHERE continent = 'Europe' and region='Southern Europe'
 ORDER By population ASC
 LIMIT 1;

         country_name          | country_continent | country_region
-------------------------------+-------------------+-----------------
 Holy See (Vatican City State) | Europe            | Southern Europe
(1 row)


-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in
-- this country's officially recognized language. Check our databases and find out what language is
-- spoken in this country, so we can call in a translator to work with you.

SELECT country.name AS country_name, countrylanguage.language AS countrylanguage_language
FROM country
JOIN countrylanguage ON countrylanguage.countrycode = country.code
WHERE country.code = 'VAT';

         country_name          | countrylanguage_language
-------------------------------+--------------------------
 Holy See (Vatican City State) | Italian
(1 row)


-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on
-- to a different country, a country where people speak only the language she was learning. Find out which
--  nearby country speaks nothing but that language.

 SELECT country.*, countrylanguage.*
 FROM country
 JOIN countrylanguage ON countrylanguage.countrycode = country.code
 WHERE countrylanguage.language = 'Italian'
 ORDER BY countrylanguage.percentage DESC
 LIMIT 1;

 code |    name    | continent |     region      | surfacearea | indepyear | population | lifeexpectancy |  gnp   | gnpold | localname  | governmentform | headofstate | capital | code2 | countrycode | language | isofficial | percentage
------+------------+-----------+-----------------+-------------+-----------+------------+----------------+--------+--------+------------+----------------+-------------+---------+-------+-------------+----------+------------+------------
 SMR  | San Marino | Europe    | Southern Europe |          61 |       885 |      27000 |           81.1 | 510.00 |        | San Marino | Republic       |             |    3171 | SM    | SMR         | Italian  | t          |        100
(1 row)

-- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time.
-- There are only two cities she could be flying to in the country. One is named the same as the country – that
-- would be too obvious. We're following our gut on this one; find out what other city in that country she might
--  be flying to.

 SELECT country.*, city.*
 FROM country
 JOIN city ON country.code = city.countrycode
 WHERE country.code = 'SMR' AND city.name != 'San Marino';

code |    name    | continent |     region      | surfacearea | indepyear | population | lifeexpectancy |  gnp   | gnpold | localname  | governmentform | headofstate | capital | code2 |  id  |    name    | countrycode |     district      | population
------+------------+-----------+-----------------+-------------+-----------+------------+----------------+--------+--------+------------+----------------+-------------+---------+-------+------+------------+-------------+-------------------+------------
 SMR  | San Marino | Europe    | Southern Europe |          61 |       885 |      27000 |           81.1 | 510.00 |        | San Marino | Republic       |             |    3171 | SM    | 3170 | Serravalle | SMR         | Serravalle/Dogano |       4802
(1 row)

-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different
-- parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were
-- headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!

 SELECT city.name AS city_name, country.name AS country_name
 FROM city
 JOIN country ON country.code = city.countrycode
 WHERE country.continent = 'South America'
 AND city.name LIKE 'Serr%';

  city_name | country_name
-----------+--------------
 Serra     | Brazil
(1 row)

-- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
-- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
-- follow right behind you!

 SELECT country.name AS country_name, city.name AS capital_city
 FROM country
 JOIN country ON country.capital = city.id
 WHERE country.name = 'Brazil';

  country_name | capital_city
--------------+--------------
 Brazil       | Bras∩┐╜lia
(1 row)


-- Clue #7:  She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to
-- the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the
-- landing dock. 
-- Lucky for us, she's getting cocky. She left us a note, and I'm sure she thinks she's very clever, but
-- if we can crack it, we can finally put her where she belongs – behind bars.




-- Our playdate of late has been unusually fun –
-- As an agent, I'll say, you've been a joy to outrun.
-- And while the food here is great, and the people – so nice!
-- I need a little more sunshine with my slice of life.
-- So I'm off to add one to the population I find
-- In a city of ninety-one thousand and now, eighty five.


-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.

 SELECT city.name AS city_name, city.countrycode AS city_countrycode, city.population AS city_population
 FROM city
 WHERE city.population = 91084;

  city_name   | city_countrycode | city_population
--------------+------------------+-----------------
 Santa Monica | USA              |           91084
(1 row)
