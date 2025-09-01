-- サンプルデータの挿入
USE sampledb;

-- セッションの文字エンコーディング設定
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET character_set_connection=utf8mb4;
SET character_set_database=utf8mb4;
SET character_set_results=utf8mb4;
SET character_set_server=utf8mb4;
SET collation_connection=utf8mb4_unicode_ci;
SET collation_database=utf8mb4_unicode_ci;
SET collation_server=utf8mb4_unicode_ci;

-- ユーザーデータの挿入
INSERT INTO users (username, email, first_name, last_name) VALUES
('john_doe', 'john.doe@example.com', 'John', 'Doe'),
('jane_smith', 'jane.smith@example.com', 'Jane', 'Smith'),
('bob_wilson', 'bob.wilson@example.com', 'Bob', 'Wilson'),
('alice_brown', 'alice.brown@example.com', 'Alice', 'Brown'),
('charlie_davis', 'charlie.davis@example.com', 'Charlie', 'Davis');

-- 商品データの挿入
INSERT INTO products (name, description, price, category, stock_quantity) VALUES
('ノートパソコン', '高性能なビジネスノートパソコン', 89999.00, 'Electronics', 50),
('スマートフォン', '最新のスマートフォン', 59999.00, 'Electronics', 100),
('ヘッドフォン', 'ノイズキャンセリング機能付き', 15999.00, 'Electronics', 75),
('本棚', '木製の本棚', 12999.00, 'Furniture', 25),
('デスク', '作業用デスク', 29999.00, 'Furniture', 30),
('コーヒーカップ', 'セラミック製コーヒーカップ', 1999.00, 'Kitchen', 200),
('キーボード', 'メカニカルキーボード', 8999.00, 'Electronics', 60),
('マウス', 'ワイヤレスマウス', 3999.00, 'Electronics', 80);

-- 注文データの挿入
INSERT INTO orders (user_id, total_amount, status) VALUES
(1, 105998.00, 'delivered'),
(2, 15999.00, 'shipped'),
(3, 42898.00, 'processing'),
(4, 1999.00, 'pending'),
(5, 59999.00, 'delivered');

-- 注文詳細データの挿入
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 89999.00),
(1, 3, 1, 15999.00),
(2, 3, 1, 15999.00),
(3, 4, 1, 12999.00),
(3, 5, 1, 29999.00),
(4, 6, 1, 1999.00),
(5, 2, 1, 59999.00);
