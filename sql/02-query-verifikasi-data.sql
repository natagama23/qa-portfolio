-- 10 query verifikasi data untuk database toko latihan (SQLite)
-- Jalankan 01-setup-database-toko.sql dulu. Satu query per nomor, jalankan satu per satu.

-- 1. Hitung total pelanggan (angka acuan). Harapan: 6
SELECT COUNT(*) FROM customers;

-- 2. Email duplikat. Harapan: budi@mail.com (2)
SELECT email, COUNT(*) FROM customers GROUP BY email HAVING COUNT(*) > 1;

-- 3. Pelanggan tanpa email. Harapan: Eko
SELECT * FROM customers WHERE email IS NULL;

-- 4. Order tanpa pelanggan (customer_id kosong). Harapan: order 4
SELECT * FROM orders WHERE customer_id IS NULL;

-- 5. Order dengan pelanggan yang tidak ada di tabel customers. Harapan: order 4 dan 5
SELECT orders.*
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id
WHERE customers.id IS NULL;

-- 6. Pelanggan yang belum pernah order. Harapan: Dewi, Budi B, Eko
SELECT customers.*
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
WHERE orders.id IS NULL;

-- 7. Order tanpa item. Harapan: order 6
SELECT orders.*
FROM orders
LEFT JOIN order_items ON order_items.order_id = orders.id
WHERE order_items.id IS NULL;

-- 8. Total order tidak sama dengan jumlah item. Harapan: order 3 (20000 vs 10000)
SELECT orders.id, orders.total, SUM(order_items.quantity * order_items.price) AS hitung_ulang
FROM orders
JOIN order_items ON order_items.order_id = orders.id
GROUP BY orders.id
HAVING orders.total != SUM(order_items.quantity * order_items.price);

-- 9. Produk dengan stok negatif atau harga 0. Harapan: Penghapus dan Topi
SELECT * FROM products WHERE stock < 0 OR price = 0;

-- 10. Item pesanan dengan quantity 0 atau kurang. Harapan: item 4 (order 2)
SELECT * FROM order_items WHERE quantity <= 0;
