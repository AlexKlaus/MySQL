CREATE USER shop_read IDENTIFIED WITH sha256_password BY '123456';
CREATE USER shop IDENTIFIED WITH sha256_password BY '123456';
GRANT SELECT ON shop.* TO shop_read;
GRANT ALL ON shop.* TO shop;