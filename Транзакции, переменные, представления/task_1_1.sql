START TRANSACTION;
INSERT INTO sample.users (name, birthday_at, created_at, updated_at)
	SELECT name, birthday_at, created_at, updated_at FROM shop.users WHERE id = 1;
COMMIT;