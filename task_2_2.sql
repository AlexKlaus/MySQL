SELECT
	DATE_FORMAT(
		REPLACE(birthday_at, YEAR(birthday_at), '2021'), '%W') AS day_of_week,
	COUNT(*) AS total
FROM
	users
GROUP BY
	day_of_week
ORDER BY
	(CASE day_of_week
		WHEN 'Monday' THEN 0
		WHEN 'Tuesday' THEN 1
		WHEN 'Wednesday' THEN 2
		WHEN 'Thursday' THEN 3
		WHEN 'Friday' THEN 4
		WHEN 'Saturday' THEN 5
		ELSE 6
	END);