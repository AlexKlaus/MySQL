DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (value INT);
INSERT INTO tbl (value)
VALUES ('1'),
	   ('2'),
	   ('3'),
	   ('4'),
	   ('5');
	  
SET @num = 1;
SELECT
	(CASE value 
		WHEN value THEN @num := @num * value
	END) AS `result`
FROM
	tbl
ORDER BY RESULT DESC LIMIT 1;