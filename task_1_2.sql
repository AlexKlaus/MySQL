DROP PROCEDURE IF EXISTS million;
delimiter //
CREATE PROCEDURE million ()
BEGIN 
	DECLARE n int DEFAULT 1;
	WHILE n <= 1000000 do 
		SET @new_user = CONCAT('user', n); 
		INSERT INTO users (name)
		values (@new_user);
		SET n = n + 1;
	END WHILE;
END//
delimiter ;

CALL million();

