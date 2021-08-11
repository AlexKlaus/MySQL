DELIMITER //
DROP FUNCTION IF EXISTS hello //
CREATE FUNCTION hello()
RETURNS varchar(100) DETERMINISTIC
BEGIN 
	SET @now := (SELECT time(now()));
	RETURN 
		(SELECT CASE 
			WHEN @now BETWEEN '06:00:00' AND '11:59:59' THEN 'Доброе утро'
			WHEN @now BETWEEN '12:00:00' AND '17:59:59' THEN 'Добрый день'
			WHEN @now BETWEEN '18:00:00' AND '23:59:59' THEN 'Добрый вечер'
			WHEN @now BETWEEN '00:00:00' AND '05:59:59' THEN 'Доброй ночи'
			END);
END //
DELIMITER ;
