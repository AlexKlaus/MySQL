-- Заказы выполеные в этом году
DROP VIEW IF EXISTS completed_last_year;
CREATE OR REPLACE VIEW completed_last_year AS
SELECT * 
FROM orders WHERE 
	((status = 'completed') AND (YEAR(updated_at) = YEAR(NOW())));


-- Позиции на которые материала хватает
DROP VIEW IF EXISTS enough_carbide;
CREATE OR REPLACE VIEW enough_carbide AS 
SELECT * 
FROM 
  -- Суммируем длины подходящих прутков
  (SELECT 
	id AS order_item_id,
	need_carbide_total_mm,
	sum(total_mm_in_stock) AS have_carbide_mm_in_stock 
  FROM 
  	-- Нходим подходящие прутки для заказов
	(SELECT 
	  oi.id,
	  p.rod_diameter,
	  p.total_length,
	  (SELECT name 
	  FROM 
	    carbide_types ct 
	  WHERE 
	    id = p.carbide_type_id) AS carbide_type,
	  oi.need_carbide_total AS need_carbide_total_mm, 
	  cis.`length` * cis.quantity AS total_mm_in_stock
	FROM order_items oi
	  JOIN products p ON (oi.product_id = p.id 
	  	AND IF ((SELECT 	-- если статус заказа не завершен
	  				status 
	  			FROM 
	  				orders 
	  			WHERE 
	  				id = oi.order_id) <> 'completed', 1, 0))
	  JOIN carbide_in_stock cis  ON (
		cis.carbide_type_id = p.carbide_type_id 
		AND cis.coolant_holes = p.coolant_holes 
		AND cis.diameter = p.rod_diameter 
		AND cis.`length` > p.total_length))AS suitable_carbide
		GROUP BY id) AS enough_carbide 
	WHERE (have_carbide_mm_in_stock > need_carbide_total_mm)
	ORDER BY order_item_id;


-- не хватает сплава
DROP VIEW IF EXISTS not_enough_carbide;
CREATE OR REPLACE VIEW not_enough_carbide AS 
SELECT
  * 
FROM 
  order_items 
WHERE 
  id NOT IN (SELECT order_item_id FROM enough_carbide)
  AND IF ((SELECT status FROM orders WHERE id = order_id) <> 'completed', 1, 0)
 ORDER BY id;


