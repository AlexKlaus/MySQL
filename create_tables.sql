DROP DATABASE IF EXISTS excalibur;
CREATE DATABASE excalibur;
USE excalibur;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
) COMMENT = 'заказчики';

DROP TABLE IF EXISTS carbide_types;
CREATE TABLE carbide_types (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100)
) COMMENT = 'типы твердого сплава';

DROP TABLE IF EXISTS carbide_in_stock;
CREATE TABLE carbide_in_stock (
	id SERIAL PRIMARY KEY,
	carbide_type_id BIGINT UNSIGNED NOT NULL,
	coolant_holes BOOL DEFAULT FALSE NOT NULL,
	diameter FLOAT NOT NULL,
	`length` INT NOT NULL,
	quantity INT NOT NULL,
	KEY index_of_carbide_type_id(carbide_type_id),
	CONSTRAINT carbide_type_id_fk
	FOREIGN KEY (carbide_type_id) REFERENCES carbide_types (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
) COMMENT = 'сплав на складе';


DROP TABLE IF EXISTS coating_types;
CREATE TABLE coating_types (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100)
) COMMENT = 'типы покрытий';

DROP TABLE IF EXISTS product_types;
CREATE TABLE product_types (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
) COMMENT = 'типы изделия';

DROP TABLE IF EXISTS media;
CREATE TABLE media (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	file_path VARCHAR(255) NOT NULL
) COMMENT = 'чертежи, эскизы, фото, модели';

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	description TEXT,
	product_type_id BIGINT UNSIGNED NOT NULL,
	carbide_type_id BIGINT UNSIGNED NOT NULL,
	coating_type BIGINT UNSIGNED DEFAULT NULL,
	coolant_holes BOOL DEFAULT FALSE,
	rod_diameter FLOAT NOT NULL, -- диаметр заготовки
	total_length FLOAT NOT NULL, -- общая длина
	media_id BIGINT UNSIGNED DEFAULT NULL,
	KEY index_of_product_type_id(product_type_id),
	KEY index_of_carbide_type_id(carbide_type_id),
	CONSTRAINT product_type_id_fk
	FOREIGN KEY (product_type_id) REFERENCES product_types (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
	CONSTRAINT media_id_fk
	FOREIGN KEY (media_id) REFERENCES media (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
	CONSTRAINT coating_type_fk
	FOREIGN KEY (coating_type) REFERENCES coating_types (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
	CONSTRAINT carbide_type_id_fk2
	FOREIGN KEY (carbide_type_id) REFERENCES carbide_types (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
) COMMENT = 'изделия';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	order_number INT NOT NULL, -- номер счета,
	customer_id BIGINT UNSIGNED NOT NULL,
	status ENUM('waiting', 'in work', 'completed') DEFAULT 'waiting' NOT NULL, 
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	deadline DATETIME,
	KEY index_of_customer_id(customer_id),
	CONSTRAINT customer_id_fk
	FOREIGN KEY (customer_id) REFERENCES customers (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
) COMMENT = 'заказы';

DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (
	id SERIAL PRIMARY KEY,
	order_id BIGINT UNSIGNED NOT NULL,
	product_id BIGINT UNSIGNED NOT NULL,
	quantity INT UNSIGNED,
	need_carbide_total INT, -- необходимая длина материала для изготовления
	CONSTRAINT order_id_fk
	FOREIGN KEY (order_id) REFERENCES orders (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
	CONSTRAINT product_id_fk
	FOREIGN KEY (product_id) REFERENCES products (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
) COMMENT = 'Позиции заказа';

DROP TABLE IF EXISTS carbide_log;
CREATE TABLE carbide_log (
	operation ENUM('add', 'del'),
	carbide_type_id BIGINT UNSIGNED,
	coolant_holes BOOL,
	diameter FLOAT,
	`length` INT,
	quantity INT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	
) ENGINE = Archive COMMENT = 'лог добавления и расхода сплава на складе';
-- logs






