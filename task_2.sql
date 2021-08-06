SELECT products.name AS name, products.price AS price, catalogs.name AS catalog FROM products JOIN catalogs
ON products.catalog_id = catalogs.id;