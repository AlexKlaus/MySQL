SET @uid = 4; -- id пользователя

-- Кто больше всех общался
SELECT friend_id, SUM(total_messages) AS total_messages FROM 
	-- Кто сколько сообщений написал пользователю
	(SELECT from_user_id AS friend_id, count(*) AS total_messages FROM messages 
	WHERE to_user_id = @uid AND from_user_id IN 
		-- друзья пользователя
		(SELECT initiator_user_id FROM friend_requests
		WHERE target_user_id = @uid AND status = 'approved'
		UNION
		SELECT target_user_id FROM friend_requests
		WHERE initiator_user_id = @uid AND status = 'approved')
		GROUP BY from_user_id
	UNION all
	-- Кому сколько сообщений написал пользователь
	SELECT to_user_id, count(*) FROM messages WHERE from_user_id = @uid AND to_user_id IN 
		-- друзья пользователя
		(SELECT initiator_user_id FROM friend_requests
		WHERE target_user_id = @uid AND status = 'approved'
		UNION
		SELECT target_user_id FROM friend_requests
		WHERE initiator_user_id = @uid AND status = 'approved')
		GROUP BY to_user_id) AS count_messages
GROUP BY friend_id
ORDER BY total_messages DESC LIMIT 1;
