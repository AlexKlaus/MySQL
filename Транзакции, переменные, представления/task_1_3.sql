DROP PROCEDURE IF EXISTS august;
delimiter //
CREATE PROCEDURE august()
BEGIN
	DECLARE d int DEFAULT 1;
	WHILE d <= 31 do
		INSERT INTO august (created_at)
		VALUES (CONCAT('2018-08-', d));
		SET d = d + 1;
	END WHILE;
END //
delimiter ;

DROP TABLE IF EXISTS august;
CREATE TEMPORARY TABLE august (created_at date);

CALL august();

SELECT 
	created_at,
	IF (created_at IN ('2018-08-01', '2018-08-04', '2018-08-16', '2018-08-17'), 1, 0) AS 1_or_0
FROM august;

