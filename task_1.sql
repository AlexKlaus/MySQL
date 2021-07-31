SELECT name, count(*) AS orders FROM users join orders 
ON users.id = orders.user_id
GROUP BY name
ORDER BY orders;