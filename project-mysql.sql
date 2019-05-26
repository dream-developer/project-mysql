
/* --------------------------------------------------------------------------------------------------------------------------------
--
-- 第１章　イントロダクション
--
--------------------------------------------------------------------------------------------------------------------------------  */

\q

"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -p
\q

mysql -u root -p

/* --------------------------------------------------------------------------------------------------------------------------------
--
-- 第２章　ＳＱＬの基礎
--
--------------------------------------------------------------------------------------------------------------------------------  */

SHOW DATABASES;


SHOW


DATABASES


;

CREATE DATABASE ec_site;

SHOW DATABASES;

DROP DATABASE ec_site;

SHOW DATABASES;

CREATE DATABASE ec_site;

USE ec_site;

SHOW DATABASES;

SHOW TABLES;

CREATE TABLE items(
    item_id INT,
    name VARCHAR(255),
    price INT
);


SHOW TABLES;

DESC items;

SHOW FULL COLUMNS FROM items;

SHOW COLUMNS FROM items;

INSERT INTO items (item_id, name, price) VALUES (1, 'えんぴつ', 50);

INSERT INTO items (item_id, name, price) VALUES (2, '消しゴム', 100);

INSERT INTO items (item_id, name, price) VALUES (3, 'ノート', 150);

SELECT * FROM items;

SELECT name FROM items;

SELECT name, price FROM items;

SELECT name, price, item_id FROM items;

SELECT name, name, name FROM items;

SELECT * FROM items;
select * from items;
SELEcT * frOM items;

SELECT
  item_id,
  name,
  price
FROM
    items;

SELE
CT * FROM items;

SELECT ite
m_id FROM items;

SELECT * FROM items WHERE item_id = 2;

SELECT * FROM items WHERE price >= 100;

SELECT * FROM items WHERE name != '消しゴム';

UPDATE items SET price = 60 WHERE item_id = 1;

UPDATE items SET name = '砂消しゴム', price = 120 WHERE item_id = 2;

SELECT * FROM items;

DELETE FROM items WHERE item_id = 2;

SELECT * FROM items;

DELETE FROM items;

SELECT * FROM items;

DROP TABLE items;

SHOW TABLES;

CREATE TABLE items(
    item_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255) DEFAULT NULL,
    price INT DEFAULT 0
)ENGINE=MyISAM;

INSERT INTO items (name, price) VALUES ('えんぴつ', 50);

SELECT * FROM items;

INSERT INTO items (name, price) VALUES ('消しゴム', 100);

SELECT * FROM items;

INSERT INTO items (name, price) VALUES ('ノート', 150);

SELECT * FROM items;

CREATE TABLE customers(
    customer_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY COMMENT '顧客ID',
    name VARCHAR(255) DEFAULT NULL COMMENT '顧客名',
    mail VARCHAR(255) DEFAULT NULL COMMENT 'メールアドレス'
)ENGINE=InnoDB, COMMENT='顧客一覧';

SHOW TABLES;

SELECT table_name, table_comment FROM information_schema.tables WHERE table_schema = database();

SHOW FULL COLUMNS FROM customers;

# 顧客一覧テーブルにレコードを追加
INSERT INTO customers (name, mail) VALUES ('やまだたろう', 'yamadatarou@test.com');

SELECT * FROM customers; # レコードが追加されているかの確認

-- 2つ目レコードを追加
INSERT INTO customers (name, mail) VALUES ('さとうたろう', 'satoutarou@test.com');

SELECT * FROM customers; -- 2つのレコードがあるはず

/* 3つ目の
   レコードを
   追加 */
INSERT INTO customers (name, mail) VALUES ('すずきたろう', 'suzukitarou@test.com');

SELECT * FROM customers; /* 3つのレコードがあるはず */

CREATE TABLE sales(
    sales_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    item_id INT NOT NULL,
    customer_id INT NOT NULL,
    num INT DEFAULT 0,
    insert_datetime DATETIME DEFAULT NULL   
);

SHOW TABLES;

# 売上一覧テーブルのカラム構成
DESC sales;

INSERT INTO sales (item_id, customer_id, num, insert_datetime) VALUES
(2, 3, 1,'2019-05-01 10:00:00'), 
(1, 3, 1,'2019-05-01 12:50:10'), 
(3, 1, 1,'2019-05-01 16:07:42'), 
(1, 3, 4,'2019-05-01 17:15:02'), 
(2, 1, 1,'2019-05-02 11:41:30'), 
(3, 2, 1,'2019-05-02 15:25:11'), 
(1, 3, 1,'2019-05-03 10:53:16'), 
(2, 1, 2,'2019-05-03 13:31:03'), 
(2, 2, 1,'2019-05-03 14:29:55'), 
(3, 3, 2,'2019-05-03 16:19:24');

SELECT * FROM sales;

# 売上一覧テーブル
SELECT * FROM sales;

# customer_idの昇順
SELECT * FROM sales ORDER BY customer_id ASC;

# 昇順のASCは省略できる
SELECT * FROM sales ORDER BY customer_id;

# customer_idの降順
SELECT * FROM sales ORDER BY customer_id DESC;

# insert_datetimeの降順
SELECT insert_datetime, item_id, customer_id, num  FROM sales ORDER BY insert_datetime DESC;

# 第1ソート:customer_id(昇順)、第2ソート:num(降順)
SELECT item_id, customer_id, num FROM sales ORDER BY customer_id ASC, num DESC;

# 第1ソート:num(降順)、第2ソート:customer_id(昇順)
SELECT item_id, customer_id, num  FROM sales ORDER BY num DESC, customer_id ASC;

SELECT * FROM sales;

# 取得上限数3レコード
SELECT * FROM sales LIMIT 3;

# numを降順とし、取得上限数3レコード
SELECT item_id, customer_id, num FROM sales ORDER BY num DESC LIMIT 3;

# 開始位置0から、取得上限数3レコード
SELECT sales_id, item_id, customer_id FROM sales LIMIT 0, 3;

# 開始位置1から、取得上限数3レコード
SELECT sales_id, item_id, customer_id FROM sales LIMIT 1, 3;

# 開始位置5から、取得上限数3レコード
SELECT sales_id, item_id, customer_id FROM sales LIMIT 5, 3;


/* --------------------------------------------------------------------------------------------------------------------------------
--
-- 第３章　構成の追加変更
--
--------------------------------------------------------------------------------------------------------------------------------  */

DESC customers;

ALTER TABLE customers ADD status TINYINT DEFAULT 0 COMMENT 'ステータス(0:無効, 1:有効)' AFTER customer_id;

DESC customers;

ALTER TABLE sales CHANGE COLUMN insert_datetime ins_datetime DATETIME DEFAULT NULL;

DESC sales;

ALTER TABLE sales CHANGE COLUMN ins_datetime ins_datetime DATETIME DEFAULT NOW();

DESC sales;

# 顧客テーブルにnum(売上個数)カラムを追加
ALTER TABLE customers ADD num INT DEFAULT 0;

# カラムが追加されているか確認
DESC customers;

# 顧客テーブルのnum(売上個数)カラムを削除
ALTER TABLE customers DROP num;

# カラムが削除されているか確認
DESC customers;

# テーブル名 customers → users;
ALTER TABLE customers RENAME TO users;

SHOW TABLES;

# テーブル名 users → customers;
ALTER TABLE users RENAME TO customers;

SHOW TABLES;

/* --------------------------------------------------------------------------------------------------------------------------------
--
-- 第４章　もう１歩すすんでみる
--
--------------------------------------------------------------------------------------------------------------------------------  */

CREATE INDEX idx_status ON customers(status);

SHOW INDEX FROM customers;

# インデックスidx_statusを削除
DROP INDEX idx_status ON customers;

SHOW INDEX FROM customers;

\q

mysqldump -u root ec_site -p > C:\mysqldata\ec_site_dump.sql

mysql -u root -p

SHOW DATABASES;

DROP DATABASE ec_site;

SHOW DATABASES;

CREATE DATABASE ec_site;

SHOW DATABASES;

\q

mysql ec_site -u root -p < C:\mysqldata\ec_site_dump.sql

mysql -u root -p

USE ec_site;

SHOW DATABASES;

SELECT * FROM items;

SELECT NOW() FROM dual;

SELECT ABS(10), ABS(-10) FROM dual;

SELECT UPPER('AbcD'), UPPER('aBcd') FROM dual;

SELECT VERSION() FROM dual;

SELECT mail, UPPER(mail) FROM customers;

SELECT 'Match' FROM dual WHERE 'ABC' LIKE '%ABC';

SELECT 'Match' FROM dual WHERE 'ABC' LIKE '_ABC';

SELECT name FROM customers;

SELECT name FROM customers WHERE name LIKE '%たろう';

SELECT name FROM customers WHERE name LIKE 'すずき_';

SELECT name FROM customers WHERE name LIKE 'すずきたろ_';

SELECT name FROM customers WHERE name NOT LIKE '%たろう';

SELECT name FROM customers WHERE name NOT LIKE 'すずき_';

SELECT name FROM customers WHERE name NOT LIKE 'すずきたろ_';

SELECT customer_id, mail FROM customers;

UPDATE customers SET mail = NULL WHERE customer_id = 2;

SELECT customer_id, mail FROM customers WHERE mail IS NULL;

SELECT customer_id, mail FROM customers WHERE mail IS NOT NULL;

SELECT customer_id, mail FROM customers WHERE mail = '';

UPDATE customers SET mail = '' WHERE customer_id = 2;

SELECT customer_id, mail FROM customers WHERE mail = '';

SELECT customer_id, mail FROM customers WHERE mail IS NULL;

SELECT customer_id, mail FROM customers WHERE mail IS NOT NULL;

UPDATE customers SET mail = 'satoutarou@test.com ' WHERE customer_id = 2;

SELECT customer_id, num FROM sales;

SELECT customer_id, num FROM sales WHERE num >= 2 AND customer_id = 3;

SELECT customer_id, num FROM sales WHERE num >= 2 OR customer_id = 3;

SELECT customer_id, num FROM sales WHERE num >= 2 XOR customer_id = 3;

SELECT customer_id, num FROM sales WHERE NOT customer_id = 3;

SELECT customer_id, num FROM sales WHERE num >= 2 || customer_id = 3;

SELECT customer_id, num FROM sales WHERE num >= 2 AND customer_id = 3 OR customer_id = 1;

SELECT customer_id, num FROM sales WHERE customer_id = 1 OR customer_id = 3 AND num >= 2;

SELECT customer_id, num FROM sales WHERE num >= 2 AND (customer_id = 3 OR customer_id = 1);

SELECT 10 + 3, 10 - 3 FROM dual;

SELECT 10 * 3, 10 / 3 , 10 DIV 3 FROM dual;

SELECT 10 % 3, 10 MOD 3 FROM dual;

SELECT * FROM items;

SELECT price, price * 10 FROM items WHERE item_id = 2;

SELECT * FROM sales;

SELECT MAX(ins_datetime), MIN(ins_datetime) FROM sales;

SELECT MAX(num), MIN(num) , SUM(num), AVG(num) FROM sales;

SELECT SUM(num) FROM sales WHERE item_id = 2;

SELECT COUNT(*) FROM sales;

SELECT COUNT(*) FROM sales WHERE item_id = 2;

SELECT DATE('2019-05-01 10:00:00') FROM dual;

SELECT NOW(), DATE(NOW()) FROM dual;

SELECT * FROM sales WHERE DATE(ins_datetime) = '2019-05-01';

SELECT SUM(num) FROM sales WHERE DATE(ins_datetime) = '2019-05-01';

SELECT item_id, MAX(num), SUM(num) FROM sales GROUP BY item_id;

SELECT MAX(num), SUM(num), DATE(ins_datetime) FROM sales GROUP BY DATE(ins_datetime);

SELECT DATE(NOW()) FROM dual;

SELECT DATE(NOW()) AS today FROM dual;

SELECT * FROM sales;

SELECT * FROM items;

SELECT * FROM items, sales;

SELECT * FROM sales, items WHERE sales.item_id = items.item_id;

SELECT * FROM sales, items WHERE sales.item_id = items.item_id AND sales.num >= 2;

SELECT * FROM sales JOIN items ON sales.item_id = items.item_id;

SELECT sales.ins_datetime AS datetime, customers.name, items.name AS item, items.price, sales.num FROM sales JOIN items ON sales.item_id = items.item_id JOIN customers ON sales.customer_id = customers.customer_id;

SELECT sales.ins_datetime AS datetime, customers.name, items.name AS item, items.price, sales.num, items.price * sales.num AS sale FROM sales JOIN items ON sales.item_id = items.item_id JOIN customers ON sales.customer_id = customers.customer_id;

SELECT SUM(items.price * sales.num) AS sum_sale FROM sales JOIN items ON sales.item_id = items.item_id JOIN customers ON sales.customer_id = customers.customer_id;

SELECT DATE(sales.ins_datetime) AS sale_date, SUM(items.price * sales.num) AS sum_sale
FROM sales JOIN items ON sales.item_id = items.item_id GROUP BY sale_date;

SELECT DATE(sales.ins_datetime) AS sale_date, items.name, SUM(sales.num) AS sum_num, SUM(items.price * sales.num) AS sum_sale
FROM sales JOIN items ON sales.item_id = items.item_id WHERE sales.item_id = 2 GROUP BY sale_date;



/* --------------------------------------------------------------------------------------------------------------------------------
--
-- 第５章　CSV操作をしよう
--
--------------------------------------------------------------------------------------------------------------------------------  */

SELECT * FROM items INTO OUTFILE 'C:\\mysqldata\\items_outfile.csv';

SELECT * FROM items INTO OUTFILE 'C:\\mysqldata\\items_comma.csv' FIELDS TERMINATED BY ',';

UPDATE items SET name = 'え"ん,ぴつ' WHERE item_id = 1;

SELECT * FROM items INTO OUTFILE 'C:\\mysqldata\\items_comma_2.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"';

UPDATE items SET name = 'えんぴつ' WHERE item_id = 1;

SELECT * FROM items WHERE item_id >= 2 INTO OUTFILE 'C:\\mysqldata\\items_id2gte.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"';

SELECT DATE(sales.ins_datetime) AS sale_date, SUM(items.price * sales.num) AS sum_sale
FROM sales JOIN items ON sales.item_id = items.item_id GROUP BY sale_date INTO OUTFILE 'C:\\mysqldata\\date_sum_sale.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

CREATE TABLE date_sum_sale (
  sale_date varchar(10) NOT NULL,
  sum_sale int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (sale_date)
);

LOAD DATA INFILE 'C:\\mysqldata\\date_sum_sale.csv' INTO TABLE date_sum_sale FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n';

SELECT * FROM date_sum_sale;

LOAD DATA INFILE 'C:\\mysqldata\\date_sum_sale.csv' INTO TABLE date_sum_sale FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n';

CREATE TABLE items_copy LIKE items;

DESC items_copy;

SELECT * FROM items_copy;

INSERT INTO items_copy SELECT * FROM items;

SELECT * FROM items_copy;

CREATE TABLE items_copy_2 LIKE items;

INSERT INTO items_copy_2 (item_id, name) SELECT item_id, name FROM items WHERE item_id >= 2;

SELECT * FROM items_copy_2;

# items(商品一覧)のcsv：items.csv
SELECT * FROM items INTO OUTFILE 'C:\\mysqldata\\items.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n';

# customers(顧客一覧)のcsv：customers.csv
SELECT * FROM customers INTO OUTFILE 'C:\\mysqldata\\customers.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n';

# sales(売上一覧)のcsv：sales.csv
SELECT * FROM sales INTO OUTFILE 'C:\\mysqldata\\sales.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n';

CREATE TABLE csv_items LIKE items;

CREATE TABLE csv_customers LIKE customers;

CREATE TABLE csv_sales LIKE sales;

# items.csvを読み込み、csv_itemsに格納
LOAD DATA INFILE 'C:\\mysqldata\\items.csv' INTO TABLE csv_items FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n';

# customers.csvを読み込み、csv_customersに格納
LOAD DATA INFILE 'C:\\mysqldata\\customers.csv' INTO TABLE csv_customers FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n';

# sales.csvを読み込み、csv_salesに格納
LOAD DATA INFILE 'C:\\mysqldata\\sales.csv' INTO TABLE csv_sales FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n';

SELECT
csv_sales.ins_datetime, csv_customers.name, csv_items.name, csv_items.price, csv_sales.num,
csv_items.price * csv_sales.num
FROM csv_sales
JOIN csv_items ON csv_sales.item_id = csv_items.item_id
JOIN csv_customers ON csv_sales.customer_id = csv_customers.customer_id
INTO OUTFILE 'C:\\mysqldata\\sales_data.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

SELECT DATE(sales.ins_datetime) AS sale_date, SUM(items.price * sales.num) AS sum_sale
FROM sales JOIN items ON sales.item_id = items.item_id GROUP BY sale_date
INTO OUTFILE 'C:\\mysqldata\\sales_data_sum.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\r\n';


