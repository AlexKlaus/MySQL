-- Выборка 3 самых популярных товара
SELECT 
	(SELECT name FROM products WHERE id = product_id) AS product_name, 
	SUM(quantity) AS total 
FROM order_items 
GROUP BY product_id 
ORDER BY total DESC LIMIT 3;


-- Список самых просроченых заказов
SELECT 
	customers.name, 
	orders.order_number, 
	orders.status,
	orders.deadline AS deadline
FROM customers JOIN orders
	ON (customers.id = orders.customer_id 
		AND orders.deadline < now()
		AND (orders.status <> 'completed'))
	ORDER BY deadline;