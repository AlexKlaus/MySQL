DROP TRIGGER IF EXISTS update_carbide; -- занесение в лог изменение количетва прутков на складеы
delimiter //
CREATE TRIGGER update_carbide AFTER UPDATE ON carbide_in_stock 
FOR EACH ROW
BEGIN
	IF NEW.quantity > OLD.quantity THEN 
		INSERT INTO carbide_log (operation, carbide_type_id, coolant_holes, diameter, `length`, quantity)
			VALUES (
				'add', 
				NEW.carbide_type_id, 
				NEW.coolant_holes, 
				NEW.diameter, 
				NEW.`length`, 
				NEW.quantity - OLD.quantity
			);
	ELSE 
		INSERT INTO carbide_log (operation, carbide_type_id, coolant_holes, diameter, `length`, quantity)
			VALUES (
				'del', 
				NEW.carbide_type_id, 
				NEW.coolant_holes, 
				NEW.diameter, 
				NEW.`length`, 
				OLD.quantity - NEW.quantity
			);
	END IF;
END//
delimiter ;

DROP TRIGGER IF EXISTS insert_carbide; -- занесение в лог созxдание новой позиции материала на складе
delimiter //
CREATE TRIGGER insert_carbide AFTER INSERT ON carbide_in_stock 
FOR EACH ROW
BEGIN
	INSERT INTO carbide_log (operation, carbide_type_id, coolant_holes, diameter, `length`, quantity)
		VALUES (
			'add', 
			NEW.carbide_type_id, 
			NEW.coolant_holes, 
			NEW.diameter, 
			NEW.`length`, 
			NEW.quantity
		);
END//
delimiter ;

DROP TRIGGER IF EXISTS delete_carbide; -- занесение в лог удаление записи о позиции на складе
delimiter //
CREATE TRIGGER delete_carbide BEFORE DELETE ON carbide_in_stock 
FOR EACH ROW
BEGIN
	INSERT INTO carbide_log (operation, carbide_type_id, coolant_holes, diameter, `length`, quantity)
		VALUES (
			'del', 
			OLD.carbide_type_id, 
			OLD.coolant_holes, 
			OLD.diameter, 
			OLD.`length`, 
			OLD.quantity
		);
END//
delimiter ;

DROP TRIGGER IF EXISTS insert_order_item; -- автоматический подсчет суммарной длины необходимого материала для изготовления заказа
delimiter //
CREATE TRIGGER insert_order_item BEFORE INSERT ON order_items 
FOR EACH ROW
BEGIN
	DECLARE `length` int;
	SET `length` = (SELECT total_length FROM products WHERE id = NEW.product_id);
	SET NEW.need_carbide_total = NEW.quantity * `length`;
END//
delimiter ;
