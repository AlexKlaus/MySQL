SELECT (SELECT name FROM cities where `from`=label) AS `from`, 
	(SELECT name FROM cities WHERE `to`=label) AS `to` 
	FROM flights;
