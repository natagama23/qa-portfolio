-- Setup database toko latihan (SQLite, dijalankan di sqliteonline.com)
-- Skrip ini aman dijalankan ulang karena diawali DROP TABLE IF EXISTS.
-- Data sengaja dibuat bermasalah untuk latihan verifikasi data (lihat 02-query-verifikasi-data.sql).

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT);
CREATE TABLE products (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price INTEGER, stock INTEGER);
CREATE TABLE orders (id INTEGER PRIMARY KEY AUTOINCREMENT, customer_id INTEGER, order_date TEXT, total INTEGER);
CREATE TABLE order_items (id INTEGER PRIMARY KEY AUTOINCREMENT, order_id INTEGER, product_id INTEGER, quantity INTEGER, price INTEGER);

-- Masalah sengaja: email duplikat (Budi dan Budi B), email kosong (Eko)
INSERT INTO customers (name, email) VALUES ('Andi','andi@mail.com'),('Budi','budi@mail.com'),('Citra','citra@mail.com'),('Dewi','dewi@mail.com'),('Budi B','budi@mail.com'),('Eko',NULL);

-- Masalah sengaja: stok negatif (Penghapus), harga 0 (Topi)
INSERT INTO products (name, price, stock) VALUES ('Pensil',2000,100),('Buku',5000,50),('Penghapus',1500,-3),('Tas',150000,10),('Topi',0,20);

-- Masalah sengaja: order 4 tanpa pelanggan, order 5 pelanggan tidak ada (99), order 6 tanpa item, total order 3 tidak sesuai item
INSERT INTO orders (customer_id, order_date, total) VALUES (1,'2026-11-01',9000),(2,'2026-11-01',150000),(3,'2026-11-02',20000),(NULL,'2026-11-02',5000),(99,'2026-11-03',2000),(1,'2026-11-03',0);

-- Masalah sengaja: quantity 0 pada order 2
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (1,1,2,2000),(1,2,1,5000),(2,4,1,150000),(2,1,0,2000),(3,2,2,5000),(4,2,1,5000),(5,1,1,2000);
