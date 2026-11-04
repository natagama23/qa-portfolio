# SQL untuk QA: Verifikasi Data

Latihan Minggu 3: memakai SQL (SQLite, lewat sqliteonline.com) untuk memeriksa data seperti yang dilakukan QA setelah testing, yaitu mencari duplikat, data yatim (orphan), dan angka yang tidak konsisten.

## Isi folder

| File | Fungsi |
|------|--------|
| `01-setup-database-toko.sql` | Membuat 4 tabel dan mengisi data yang sengaja bermasalah. Aman dijalankan ulang (diawali `DROP TABLE IF EXISTS`). |
| `02-query-verifikasi-data.sql` | 10 query verifikasi data beserta hasil yang diharapkan. |

## Struktur database

| Tabel | Kolom | Relasi |
|-------|-------|--------|
| `customers` | id, name, email | - |
| `products` | id, name, price, stock | - |
| `orders` | id, customer_id, order_date, total | `customer_id` ke `customers.id` |
| `order_items` | id, order_id, product_id, quantity, price | `order_id` ke `orders.id`, `product_id` ke `products.id` |

## Temuan dari 10 query

| No | Pengecekan | Teknik SQL | Temuan |
|----|------------|------------|--------|
| 1 | Jumlah pelanggan | `COUNT` | 6 pelanggan (angka acuan) |
| 2 | Email duplikat | `GROUP BY` + `HAVING` | budi@mail.com dipakai Budi dan Budi B |
| 3 | Pelanggan tanpa email | `IS NULL` | Eko |
| 4 | Order tanpa pelanggan | `IS NULL` | Order 4 |
| 5 | Order dengan pelanggan yang tidak ada | `LEFT JOIN` | Order 4 dan 5 (pelanggan 99 tidak ada) |
| 6 | Pelanggan yang belum pernah order | `LEFT JOIN` | Dewi, Budi B, Eko |
| 7 | Order tanpa item | `LEFT JOIN` | Order 6 |
| 8 | Total order tidak sesuai jumlah item | `JOIN` + `SUM` + `HAVING` | Order 3: tercatat 20000, hitung ulang 10000 |
| 9 | Stok negatif atau harga 0 | `WHERE` + `OR` | Penghapus (stok -3), Topi (harga 0) |
| 10 | Quantity 0 atau kurang | `WHERE` | Item 4 pada Order 2 |

## Cara menjalankan

1. Buka https://sqliteonline.com dan pilih SQLite.
2. Jalankan isi `01-setup-database-toko.sql`.
3. Hapus isi editor, lalu jalankan query dari `02-query-verifikasi-data.sql` satu per satu.

## Yang saya pelajari

- Dasar SQL: `SELECT`, `WHERE`, `ORDER BY`, `JOIN`, `GROUP BY`, `HAVING`, `INSERT`, `UPDATE`, `DELETE`
- `LEFT JOIN` + `IS NULL` untuk menemukan data yatim (data tanpa pasangan)
- Selalu uji dengan `SELECT` + `WHERE` sebelum menjalankan `UPDATE` atau `DELETE`
- Ringkasan rumus dan cara pakainya ada di tab *Cheat Sheet SQL* pada [Google Sheet](https://docs.google.com/spreadsheets/d/1tOBTeLUC1jbGIvGAtP3jhZNwbULxlmorf8ABgktQv4Q/edit?usp=sharing)
