SET @id := 0;

DELETE FROM 
	users 
WHERE 
	created_at < (SELECT created_at FROM 
		(SELECT 
			@id := @id + 1 AS id, 
			created_at 
		FROM users
		ORDER BY created_at DESC) AS fresh WHERE fresh.id = 5);

