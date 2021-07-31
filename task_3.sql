
-- без join
SELECT (SELECT name FROM cities where `from`=label) AS `from`, 
	(SELECT name FROM cities WHERE `to`=label) AS `to` 
	FROM flights;


-- join
SELECT c.name `from`, c2.name `to` FROM flights f
	JOIN cities c ON f.`from` = c.label
	JOIN cities c2 ON f.`to` = c2.label
	ORDER BY f.id;