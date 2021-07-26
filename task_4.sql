-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT * FROM 
	-- считаем количество лайков мужчин
	(SELECT count(*) AS total_likes, 'm' AS gender FROM likes WHERE user_id IN 
		(SELECT user_id FROM profiles WHERE gender = 'm')
	UNION 
	-- считаем количество лайков женщин
	SELECT count(*), 'f' AS gender FROM likes WHERE user_id IN 
		(SELECT user_id FROM profiles WHERE gender = 'f')) AS likes
	ORDER BY total_likes DESC LIMIT 1;