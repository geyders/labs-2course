SELECT * 
FROM Country
WHERE Continent = 'Африка';

SELECT Name AS 'Країна', 
       Continent AS 'Континент', 
       IndepYear AS 'Рік Незалежності', 
       GovernmentForm AS 'Форма Правління'
FROM Country
WHERE IndepYear BETWEEN 1900 AND 1950;

SELECT * 
FROM Country
WHERE GovernmentForm LIKE '%Монархія%';

SELECT COUNT(*) AS 'Кількість країн в Африці'
FROM Country
WHERE Continent = 'Африка';

SELECT Name, Population
FROM Country
WHERE Continent = 'Африка'
ORDER BY Population ASC
LIMIT 1;

SELECT Continent, SUM(SurfaceArea) AS 'Загальна Площа'
FROM Country
GROUP BY Continent
ORDER BY SUM(SurfaceArea) DESC;

SELECT Name, GDP
FROM Country
WHERE GDP > (SELECT AVG(GDP) FROM Country);

SELECT Name, Continent, LifeExpectancy
FROM Country
WHERE Continent IN ('Європа', 'Азія')
  AND LifeExpectancy > (SELECT AVG(LifeExpectancy) 
                        FROM Country 
                        WHERE Continent IN ('Європа', 'Азія'))
ORDER BY LifeExpectancy DESC;