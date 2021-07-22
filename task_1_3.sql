SELECT value FROM storehouses_products

ORDER BY IF (value > 0, 0, 1), value;