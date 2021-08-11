DROP VIEW IF EXISTS username;
CREATE OR REPLACE VIEW username AS
SELECT id, name FROM accounts;

DROP USER IF EXISTS user_read;
CREATE USER user_read IDENTIFIED WITH sha256_password BY '123456';
GRANT SELECT ON test.username TO user_read;