DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	`datetime` DATETIME,
	table_name VARCHAR(100),
	primary_key_id BIGINT,
	name VARCHAR(100)
	) ENGINE=Archive;

	
DROP TRIGGER IF EXISTS users_log;
delimiter //
CREATE TRIGGER users_log AFTER INSERT ON users
FOR EACH ROW 
BEGIN 
	INSERT INTO logs 
	VALUES (now(), 'users', NEW.id, NEW.name);
END//
delimiter ;

DROP TRIGGER IF EXISTS catalogs_log;
delimiter //
CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN 
	INSERT INTO logs 
	VALUES (now(), 'catalogs', NEW.id, NEW.name);
END//
delimiter ;

DROP TRIGGER IF EXISTS products_log;
delimiter //
CREATE TRIGGER products_log AFTER INSERT ON products
FOR EACH ROW 
BEGIN 
	INSERT INTO logs 
	VALUES (now(), 'products', NEW.id, NEW.name);
END//
delimiter ;
