# Week 1 - Kerry Rainford

#Part A
# Question 1: How many airplanes have listed speeds? 23
SELECT COUNT(*) FROM planes
WHERE speed IS NOT null; 

#What is the minimum listed speed and the maximum listed speed?
#Minimum speed is 90
SELECT manufacturer,speed FROM planes
WHERE speed IS NOT NULL
ORDER BY speed ASC LIMIT 1;

#Maximum speed is 432
SELECT manufacturer,speed FROM planes
WHERE speed IS NOT NULL
ORDER BY speed DESC LIMIT 1;

#Question 2: What is the total distance flown by all of the planes in January 2013? 27188805

SELECT SUM(distance) FROM flights
WHERE year = '2013' AND month = '1';

# What is the total distance flown by all of the planes in January 2013 where the tailnum is missing? 

SELECT SUM(distance) FROM flights
WHERE year = '2013' AND month = '1' AND tailnum IS NULL;

#Question 3: What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer?
#Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN.  How do your results compare?
# There are 14 rows returned with both joins. In this instance there are no differences in the result sets with bouth joins

SELECT p.manufacturer, SUM(f.distance) FROM planes p		
INNER JOIN flights f
ON p.tailnum = f.tailnum
WHERE f.month = '7' AND f.day = '5' AND f.year = '2013'
GROUP BY p.manufacturer;

SELECT p.manufacturer, SUM(f.distance) FROM planes p		
LEFT OUTER JOIN flights f
ON p.tailnum = f.tailnum
WHERE f.month = '7' AND f.day = '5' AND f.year = '2013'
GROUP BY p.manufacturer;

#Question 4: Write and answer at least one question of your own choosing that 
#joins information from at least three of the tables in the flights database. 
# What is the average distance flown for all planes on December 15, 2013 which departed
#from JFK Airport grouped by aircraft manufacturer?

SELECT p.manufacturer, AVG(f.arr_delay) FROM planes p		
INNER JOIN flights f
ON p.tailnum = f.tailnum
LEFT JOIN airports a
ON f.origin = a.faa
WHERE f.month = '12' AND f.day = '15' AND f.year = '2013' AND a.faa = 'JFK'
GROUP BY p.manufacturer;

#Part B
#Script to generate csv for Tableau analysis to compare flight performance.
#Average monthly departure delay across the three New York airports. 

SELECT p.manufacturer, CONCAT(f.month, '/', f.day, '/', f.year) AS Flight_Date, f. arr_delay, f.carrier, f.tailnum, f.origin FROM planes p		
INNER JOIN flights f
ON p.tailnum = f.tailnum
WHERE f.origin = 'JFK' 
OR f.origin = 'EWR' 
OR f.origin = 'LGA';

#Link to Tableau visuals: https://public.tableau.com/profile/kerry3535#!/vizhome/Avg_flights_delays_NYC/Sheet1?publish=yes