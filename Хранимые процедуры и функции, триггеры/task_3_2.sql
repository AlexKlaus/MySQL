DROP TRIGGER IF EXISTS prohibit_insert_with_empty_fields;
delimiter //
CREATE TRIGGER prohibit_insert_with_empty_fields BEFORE INSERT ON products
FOR EACH ROW 
BEGIN 
	IF (NEW.name IS NULL) AND (NEW.description IS NULL) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = '`name` and `descriprtion` cannot be empty';
	END IF;
END //
delimiter ;

DROP TRIGGER IF EXISTS prohibit_update_with_empty_fields;
delimiter //
CREATE TRIGGER prohibit_update_with_empty_fields BEFORE UPDATE ON products
FOR EACH ROW 
BEGIN 
	IF (NEW.name IS NULL OR NEW.name = '') AND (NEW.description IS NULL OR NEW.description = '') THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = '`name` and `descriprtion` cannot be empty';
	END IF;
END //
delimiter ;