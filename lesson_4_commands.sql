-- INSERT INTO users (id, firstname, lastname, email, phone)
-- VALUES (581, 'Dean', 'Satterfield', 'orin6119@example.net', 9260120629);

-- SELECT *
-- FROM users
-- WHERE id = 581;

-- INSERT INTO users VALUES
-- ('445', 'Reuben', 'Nienow', 'arlo515@e4xample.org', NULL, 0),
-- ('446', 'Reuben', 'Nienow', 'arlo516@e4xample.org', NULL, 0),
-- ('447', 'Reuben', 'Nienow', 'arlo517@e4xample.org', NULL, 0),
-- ('448', 'Reuben', 'Nienow', 'arlo518@e4xample.org', NULL, 0);

-- INSERT INTO users
-- SET
-- 	firstname = 'Иван',
-- 	lastname = 'Иванов',
-- 	email = 'ivan@example.com',
-- 	phone = '9531234578';
	
-- INSERT INTO users 
-- 	(id, firstname, lastname, email, phone)
-- SELECT
-- 	id, firstname, lastname, email, phone 
-- FROM vk2.users
-- WHERE id = 100;

-- SELECT 10+20 FROM dual;

-- SELECT DISTINCT firstname
-- FROM users;

-- SELECT *
-- FROM users
-- LIMIT 3 offset 5;

-- SELECT *
-- FROM users
-- WHERE id = 5 OR firstname = 'Reuben';

-- SELECT *
-- FROM users 
-- WHERE id IN (1,2,30,4);

-- UPDATE friend_requests 
-- SET
-- 	status = 'declined',
-- 	updated_at = now()
-- WHERE 
-- 	initiator_user_id = 1 AND target_user_id = 3
-- 	AND status = 'requested';

-- DELETE FROM users  удалит строки таблицы
-- WHERE id = 13;

-- DELETE FROM messages 
-- WHERE from_user_id = 1;

-- DROP TABLE messages; удалит таблицу

-- TRUNCATE TABLE users; удалит строки, но оставит таблицу 







