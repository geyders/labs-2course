CREATE DATABASE cafe;

USE cafe;

-- 1. Таблиця продуктів
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    expiration_date DATE
);

-- 2. Таблиця страв та напоїв
CREATE TABLE dishes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type ENUM('страва', 'напій'),
    name VARCHAR(100) NOT NULL,
    expiration_date DATE
);

-- 3. Таблиця працівників
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE
);

-- 4. Таблиця клієнтів
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE
);

-- 5. Таблиця улюблених страв або напоїв клієнтів
CREATE TABLE favorite_dishes (
    client_id INT,
    dish_id INT,
    PRIMARY KEY (client_id, dish_id),
    FOREIGN KEY (client_id) REFERENCES clients(id),
    FOREIGN KEY (dish_id) REFERENCES dishes(id)
);

-- 6. Таблиця історії замовлень
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    employee_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (client_id) REFERENCES clients(id),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- 7. Продукти у замовленнях
CREATE TABLE order_products (
    order_id INT,
    product_id INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO products (name, expiration_date) VALUES 
('Кава зернова', '2024-12-31'),
('Молоко', '2024-10-25'),
('Цукор', '2025-01-01'),
('Шоколад', '2025-03-15'),
('Борошно', '2024-11-20');

INSERT INTO dishes (type, name, expiration_date) VALUES 
('напій', 'Еспресо', '2024-12-31'),
('напій', 'Капучино', '2024-12-25'),
('напій', 'Лате', '2024-12-31'),
('страва', 'Круасан', '2024-10-22'),
('страва', 'Панкейки', '2024-10-20');

INSERT INTO employees (full_name, birth_date) VALUES 
('Іван Петров', '1990-02-15'),
('Марія Іваненко', '1988-07-10'),
('Олег Коваленко', '1995-03-25');

INSERT INTO clients (full_name, birth_date) VALUES 
('Олександр Сидоренко', '1985-05-20'),
('Анна Бойко', '1992-11-15'),
('Вікторія Кравець', '1998-08-30');

INSERT INTO favorite_dishes (client_id, dish_id) VALUES 
(1, 2), -- Олександр Сидоренко любить Капучино
(1, 4), -- Олександр Сидоренко любить Круасан
(2, 3), -- Анна Бойко любить Лате
(3, 5); -- Вікторія Кравець любить Панкейки

INSERT INTO orders (client_id, employee_id, order_date, total_price) VALUES 
(1, 1, '2024-10-15 10:30:00', 150.00),
(2, 2, '2024-10-16 14:45:00', 120.00),
(1, 1, '2024-10-17 09:15:00', 80.00),
(3, 3, '2024-10-18 13:20:00', 200.00);

INSERT INTO order_products (order_id, product_id) VALUES 
(1, 1), -- У першому замовленні: Кава зернова
(1, 2), -- У першому замовленні: Молоко
(2, 1), -- У другому замовленні: Кава зернова
(2, 3), -- У другому замовленні: Цукор
(3, 4), -- У третьому замовленні: Шоколад
(4, 2), -- У четвертому замовленні: Молоко
(4, 5); -- У четвертому замовленні: Борошно


SELECT c.full_name AS Client, d.name AS FavoriteDish
FROM clients c
JOIN favorite_dishes fd ON c.id = fd.client_id
JOIN dishes d ON fd.dish_id = d.id;

SELECT o.order_date, c.full_name AS Client, e.full_name AS Employee, o.total_price
FROM orders o
JOIN clients c ON o.client_id = c.id
JOIN employees e ON o.employee_id = e.id
ORDER BY o.order_date;

SELECT c.full_name, COUNT(o.id) AS VisitCount
FROM clients c
JOIN orders o ON c.id = o.client_id
GROUP BY c.id
ORDER BY VisitCount DESC;




