-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
SELECT 
user_id AS uid, 
(SELECT SUM(user_activity) AS user_activity from
  -- сумма лайков поставленных пользователем
  (SELECT COUNT(*) AS user_activity, user_id FROM likes
  GROUP BY user_id
  UNION ALL
  -- запросы в друзья отправленные пользователем
  SELECT count(*), initiator_user_id FROM friend_requests fr 
  GROUP BY initiator_user_id
  UNION ALL
  -- колличество медиафайлов добавленым пользователем
  SELECT count(*), user_id FROM media
  GROUP BY user_id
  UNION ALL
  -- сумма сообщений 
  SELECT COUNT(*), from_user_id FROM messages
  GROUP BY from_user_id) temp_table WHERE user_id = uid GROUP BY user_id ) AS user_activity 
 FROM profiles
ORDER BY user_activity LIMIT 10; 
	
	






