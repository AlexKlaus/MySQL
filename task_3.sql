-- считаем сколько лайков
SELECT count(*) AS total_likes FROM likes WHERE media_id in
	-- Находим медиа принадлежащие этим пользователям
	(SELECT id FROM media WHERE user_id IN 
		-- 10 самых молодых пользователей
		(SELECT *  FROM (SELECT user_id FROM profiles 
		ORDER BY TIMESTAMPDIFF(YEAR, birthday, now()) LIMIT 10) AS temp_table));
