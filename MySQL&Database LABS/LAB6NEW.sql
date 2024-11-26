SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `Product` DEFAULT CHARACTER SET utf8mb4;

USE `Product`;

-- Таблиця Product
CREATE TABLE IF NOT EXISTS `Product`.`Product` (
  `ProductID` INT(11) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `UnitOfMeasure` VARCHAR(45) NOT NULL,
  `UnitPrice` DECIMAL(10, 2) NOT NULL,
  `SupplierID` INT(11) NOT NULL,
  `Category_id` INT(11) NOT NULL,
  PRIMARY KEY (`ProductID`),
  INDEX `category_idx` (`Category_id`),
  INDEX `supplier_idx` (`SupplierID`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- Таблиця Stock
CREATE TABLE IF NOT EXISTS `Product`.`Stock` (
  `id` INT NOT NULL,
  `Stock_id` INT NOT NULL,
  `Product_id` INT NOT NULL,
  `QuantityinStock` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `stock_product_id_idx` (`Product_id`),
  CONSTRAINT `fk_stock_product`
    FOREIGN KEY (`Product_id`)
    REFERENCES `Product`.`Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- Таблиця Sale
CREATE TABLE IF NOT EXISTS `Product`.`Sale` (
  `Sale_id` INT(11) NOT NULL,
  `Saledate` DATE NOT NULL,
  `Product_id` INT(11) NOT NULL,
  `QuantitySold` INT(11) NOT NULL,
  `QuantityAfterSale` INT(11) NOT NULL,
  `Customer_id` INT(11) NOT NULL,
  `Employee_id` INT(11) NOT NULL,
  PRIMARY KEY (`Sale_id`),
  INDEX `sale_product_id_idx` (`Product_id`),
  CONSTRAINT `fk_sale_product`
    FOREIGN KEY (`Product_id`)
    REFERENCES `Product`.`Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- Таблиця Supplier
CREATE TABLE IF NOT EXISTS `Product`.`Supplier` (
  `supplier_id` INT NOT NULL,
  `supplierName` VARCHAR(45) NOT NULL,
  `contactInfo` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- Таблиця Invoice
CREATE TABLE IF NOT EXISTS `Product`.`Invoice` (
  `invoice_id` INT(11) NOT NULL,
  `sale_id` INT(11) NOT NULL,
  `invoiceDate` DATE NOT NULL,
  `totalAmount` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`invoice_id`),
  CONSTRAINT `fk_invoice_sale`
    FOREIGN KEY (`sale_id`)
    REFERENCES `Product`.`Sale` (`Sale_id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- Таблиця Customer
CREATE TABLE IF NOT EXISTS `Product`.`Customer` (
  `customer_id` INT NOT NULL,
  `customerName` VARCHAR(45) NOT NULL,
  `contactInfo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- Таблиця ProductCategory
CREATE TABLE IF NOT EXISTS `Product`.`ProductCategory` (
  `category_id` INT(11) NOT NULL,
  `categoryName` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- Таблиця Order
CREATE TABLE IF NOT EXISTS `Product`.`Orderss` (
  `id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `orderDate` DATE NOT NULL,
  `customer_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantityOrdered` INT NOT NULL,
  `totalAmount` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `order_customer_id_idx` (`customer_id`),
  INDEX `order_product_id_idx` (`product_id`),
  CONSTRAINT `fk_orders_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Product`.`Customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_product_orders`
    FOREIGN KEY (`product_id`)
    REFERENCES `Product`.`Product` (`ProductID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;



-- Таблиця Employee
CREATE TABLE IF NOT EXISTS `Product`.`Employee` (
  `employee_id` INT NOT NULL,
  `employeeName` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `contactInfo` VARCHAR(45) NOT NULL,
  `hireDate` DATE NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- Таблиця Payment
CREATE TABLE IF NOT EXISTS `Product`.`Payment` (
  `id` INT NOT NULL,
  `payment_id` INT NOT NULL,
  `invoice_id` INT NOT NULL,
  `payment_date` DATE NOT NULL,
  `paymentAmount` DECIMAL(10, 2) NOT NULL,
  `paymentMethod` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`payment_id`),
  CONSTRAINT `fk_payment_invoice`
    FOREIGN KEY (`invoice_id`)
    REFERENCES `Product`.`Invoice` (`invoice_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `Product`.`Product` (ProductID, Name, UnitOfMeasure, UnitPrice, SupplierID, Category_id) 
VALUES 
(1, 'Ноутбук', 'pcs', 1000.00, 1, 1),
(2, 'Телефон', 'pcs', 500.00, 1, 2),
(3, 'Планшет', 'pcs', 300.00, 2, 2),
(4, 'Монітор', 'pcs', 200.00, 2, 3),
(5, 'Клавіатура', 'pcs', 50.00, 3, 4),
(6, 'Мишка', 'pcs', 30.00, 3, 4),
(7, 'Принтер', 'pcs', 150.00, 4, 5),
(8, 'Сканер', 'pcs', 120.00, 4, 5),
(9, 'Роутер', 'pcs', 80.00, 5, 6),
(10, 'Гральна консоль', 'pcs', 60.00, 5, 6),
(11, 'Камера', 'pcs', 400.00, 6, 7),
(12, 'Навушники', 'pcs', 70.00, 6, 8),
(13, 'Мікрофон', 'pcs', 90.00, 6, 8),
(14, 'Прожектор', 'pcs', 500.00, 7, 9),
(15, 'Смарт-годинник', 'pcs', 250.00, 7, 2);

INSERT INTO `Product`.`Stock` (id, Stock_id, Product_id, QuantityinStock) 
VALUES 
(1, 1, 1, 50),
(2, 2, 2, 100),
(3, 3, 3, 75),
(4, 4, 4, 60),
(5, 5, 5, 150),
(6, 6, 6, 200),
(7, 7, 7, 80),
(8, 8, 8, 90),
(9, 9, 9, 70),
(10, 10, 10, 65),
(11, 11, 11, 30),
(12, 12, 12, 40),
(13, 13, 13, 50),
(14, 14, 14, 25),
(15, 15, 15, 55);


INSERT INTO `Product`.`Customer` (id, customer_id, customerName, contactInfo) 
VALUES 
(1, 11, 'Богдан Тарасович Шевченко', 'b.shevchenko@gmail.com'),
(2, 12, 'Марко Ігорович Козак', 'marko.kozak@gmail.com'),
(3, 13, 'Ярослав Романович Петренко', 'y.r.petrenko@gmail.com'),
(4, 14, 'Олександр Дмитрович Сорока', 'oleksandr.sor@gmail.com'),
(5, 15, 'Андрій Олегович Мельник', 'andriy.mel@gmail.com'),
(6, 16, 'Оксана Василівна Коваль', 'koval.oksana@gmail.com'),
(7, 17, 'Софія Андріївна Шевчук', 'sofiya.shev@gmail.com'),
(8, 18, 'Марія Іванівна Петрушенко', 'petrushenko.mariya@gmail.com'),
(9, 19, 'Анастасія Олегівна Романенко', 'anastasiya.rom@gmail.com'),
(10, 11, 'Катерина Дмитрівна Костенко', 'kateryna.kos@gmail.com'),
(11, 12, 'Іван Андрійович Савченко', 'ivan.sav@gmail.com'),
(12, 13, 'Олеся Михайлівна Ковальчук', 'olesya.kov@gmail.com'),
(13, 14, 'Роман Олександрович Шевченко', 'r.o.shevchenko@gmail.com'),
(14, 15, 'Зоряна Мирославівна Чорновол', 'zoryana.chor@gmail.com'),
(15, 16, 'Борис Владиславович Левицький', ' levytskyy.borys@gmail.com');

INSERT INTO `Product`.`Sale` (id, Sale_id, Saledate, Product_id, QuantitySold, QuantityAfterSale, Customer_id, Employee_id) 
VALUES 
(1,1, '2024-10-01', 1, 2, 48, 1, 1),
(2,2, '2024-10-02', 2, 5, 95, 2, 2),
(3,3, '2024-10-03', 3, 3, 72, 3, 3),
(4,4, '2024-10-04', 4, 4, 56, 4, 4),
(5,5, '2024-10-05', 5, 10, 140, 5, 5),
(6,6, '2024-10-06', 6, 15, 185, 6, 6),
(7,7, '2024-10-07', 7, 1, 79, 7, 7),
(8,8, '2024-10-08', 8, 2, 88, 8, 8),
(9,9, '2024-10-09', 9, 7, 63, 9, 9),
(10,10, '2024-10-10', 10, 8, 57, 10, 10),
(11,11, '2024-10-11', 11, 1, 29, 11, 11),
(12,12, '2024-10-12', 12, 4, 36, 12, 12),
(13,13, '2024-10-13', 13, 6, 44, 13, 13),
(14,14, '2024-10-14', 14, 3, 22, 14, 14),
(15,15, '2024-10-15', 15, 9, 46, 15, 15);


INSERT INTO `Product`.`Employee` (employee_id, employeeName, position, contactInfo, hireDate) 
VALUES 
(1, 'Софія Романенко', 'Менеджер', 'sofarmnk.@gmail.com', '2020-01-15'),
(2, 'Максим Петренко', 'Продавець', 'maksym.petrenko@ukr.net', '2021-03-10'),
(3, 'Олена Ковальчук', 'Ремонтник', 'olenka.kv.@gmail.com', '2019-07-20'),
(4, 'Андрій Шевченко', 'Секретар', 'scvchandr.@gmail.com', '2018-05-30'),
(5, 'Ірина Шевчук', 'Керівник', 'evan.h@example.com', '2022-04-22'),
(6, 'Тарас Мельникo', 'Продавець', 'george.w@example.com', '2020-09-14'),
(7, 'Оксана Коваль', 'Ремонтник', 'helen.d@example.com', '2021-11-11'),
(8, 'Дмитро Савченко', 'Менеджер', 'ian.w@example.com', '2017-02-05'),
(9, 'Катерина Петренко', 'Консультант', 'jane.m@example.com', '2019-08-09'),
(10, 'Віктор Козак', 'Асистент', 'kyle.c@example.com', '2022-03-13'),
(11, 'Юлія Романенко', 'Консультант', 'laura.k@example.com', '2018-12-01'),
(12, 'Олег Шевченко', 'Ремонтник', 'michael.s@example.com', '2020-10-10'),
(13, 'Марія Коваль', 'Продавець', 'nina.r@example.com', '2023-01-01'),
(14, 'Андрій Петренко', 'СММ', 'oliver.s@example.com', '2016-05-05'),
(15, 'Олена Савченко', 'Керівник відділу персоналу', 'lenkasav@gmail.com', '2017-03-02');

INSERT INTO `Product`.`Invoice` (id, invoice_id, sale_id, invoiceDate, totalAmount) 
VALUES 
(1, 101, 1, '2024-10-02', 2000.00),
(2, 102, 2, '2024-10-03', 2500.00),
(3, 103, 3, '2024-10-04', 900.00),
(4, 104, 4, '2024-10-05', 800.00),
(5, 105, 5, '2024-10-06', 5000.00),
(6, 106, 6, '2024-10-07', 4500.00),
(7, 107, 7, '2024-10-08', 150.00),
(8, 108, 8, '2024-10-09', 240.00),
(9, 109, 9, '2024-10-10', 560.00),
(10, 110, 10, '2024-10-11', 800.00),
(11, 111, 11, '2024-10-12', 400.00),
(12, 112, 12, '2024-10-13', 160.00),
(13, 113, 13, '2024-10-14', 540.00),
(14, 114, 14, '2024-10-15', 110.00),
(15, 115, 15, '2024-10-16', 1150.00);

INSERT INTO `Product`.`Orderss` (id, order_id, orderDate, customer_id, product_id, quantityOrdered, totalAmount) 
VALUES 
(1, 221, '2024-10-01', 1, 1, 2, 2000.00),
(2, 222, '2024-10-02', 2, 2, 5, 2500.00),
(3, 223, '2024-10-03', 3, 3, 3, 900.00),
(4, 224, '2024-10-04', 4, 4, 4, 800.00),
(5, 225, '2024-10-05', 5, 5, 10, 5000.00),
(6, 226, '2024-10-06', 6, 6, 15, 4500.00),
(7, 227, '2024-10-07', 7, 7, 1, 150.00),
(8, 228, '2024-10-08', 8, 8, 2, 240.00),
(9, 229, '2024-10-09', 9, 9, 7, 560.00),
(10, 220, '2024-10-10', 10, 10, 8, 800.00),
(11, 231, '2024-10-11', 11, 11, 1, 400.00),
(12, 232, '2024-10-12', 12, 12, 4, 160.00),
(13, 233, '2024-10-13', 13, 13, 6, 540.00),
(14, 234, '2024-10-14', 14, 14, 3, 110.00),
(15, 235, '2024-10-15', 15, 15, 9, 1150.00);

INSERT INTO `Product`.`Payment` (payment_id, invoice_id, payment_date, paymentAmount, paymentMethod, id)  
VALUES  
  (1, 301, '2024-10-02', 2000.00, 'Кредитна картка', 1),
  (2, 302, '2024-10-03', 2500.00, 'Банківський переказ', 2),
  (3, 303, '2024-10-04', 900.00, 'Готівка', 3),
  (4, 304, '2024-10-05', 800.00, 'Кредитна картка', 4),
  (5, 305, '2024-10-06', 5000.00, 'Банківський переказ', 5),
  (6, 306, '2024-10-07', 4500.00, 'Готівка', 6),
  (7, 307, '2024-10-08', 150.00, 'Кредитна картка', 7),
  (8, 308, '2024-10-09', 240.00, 'Готівка', 8),
  (9, 309, '2024-10-10', 560.00, 'Банківський переказ', 9),
  (10, 310, '2024-10-11', 800.00, 'Кредитна картка', 10),
  (11, 311, '2024-10-12', 400.00, 'Готівка', 11),
  (12, 312, '2024-10-13', 160.00, 'Банківський переказ', 12),
  (13, 313, '2024-10-14', 540.00, 'Кредитна картка', 13),
  (14, 314, '2024-10-15', 110.00, 'Готівка', 14),
  (15, 315, '2024-10-16', 1150.00, 'Банківський переказ', 15);

INSERT INTO `Product`.`ProductCategory` (id, category_id, categoryName, description) 
VALUES 
(1, 1, 'Електроніка', 'Пристрої з електронними схемами'),
(2, 2, 'Мобільні пристрої', 'Телефони, планшети та носимі пристрої'),
(3, 3, 'Комп*ютерні аксесуари', 'Монітори, клавіатури та миші'),
(4, 4, 'Офісна техніка', 'Принтери, сканери та проектори'),
(5, 5, 'Мережеве обладнання', 'Маршрутизатори, комутатори та інше'),
(6, 6, 'Аудіообладнання', 'Навушники, колонки та мікрофони'),
(7, 7, 'Камери', 'Фотографічне та спостережне обладнання'),
(8, 8, 'Носимі технології', 'Розумні годинники та фітнес-трекери'),
(9, 9, 'Системи проектування', 'Проектори та аксесуари'),
(10, 10, 'Пристрої зберігання', 'Зовнішні та внутрішні жорсткі диски'),
(11, 11, 'Ігрові приставки', 'Консолі та аксесуари'),
(12, 12, 'Програмне забезпечення', 'Операційні системи та додатки'),
(13, 13, 'Побутова техніка', 'Розумні домашні пристрої та побутова техніка'),
(14, 14, 'Канцелярські товари', 'Папір, ручки та витратні матеріали'),
(15, 15, 'Промислове обладнання', 'Важка промислова техніка та інструменти');

INSERT INTO `Product`.`Supplier` (id, supplier_id, supplierName, contactInfo, address) 
VALUES 
(1, 1, 'TechStore', 'contact@techstore.com', 'вул. Технічна 123'),
(2, 2, 'MobileHub', 'info@mobilehub.com', 'пр-т Мобільний 456'),
(3, 3, 'OfficeSupplyCo', 'support@office.com', 'бул. Офісний 789'),
(4, 4, 'PrintWorld', 'sales@printworld.com', 'пров. Принтерна 101'),
(5, 5, 'NetGear', 'contact@netgear.com', 'вул. Маршрутизаторів 202'),
(6, 6, 'AudioMarket', 'info@audiomarket.com', 'бул. Звуковий 303'),
(7, 7, 'CameraPro', 'support@camerapro.com', 'вул. Камер 404'),
(8, 8, 'WearableTech', 'sales@wearabletech.com', 'пр-т Фітнес 505'),
(9, 9, 'Projection Inc.', 'contact@projection.com', 'вул. Проекторів 606'),
(10, 10, 'GameZone', 'info@gamezone.com', 'вул. Консольна 707'),
(11, 11, 'SoftLine', 'support@softline.com', 'бул. ПЗ 808'),
(12, 12, 'ApplianceWorld', 'sales@applianceworld.com', 'пров. Техніки побутової 909'),
(13, 13, 'HomeTech', 'contact@hometech.com', 'вул. Розумний Дім 1010'),
(14, 14, 'OfficeMart', 'info@officemart.com', 'пр-т Канцтоварів 1111'),
(15, 15, 'IndustrialPlus', 'support@industrial.com', 'бул. Промислового обладнання 1212');

SELECT * FROM  `Product`.`Sale`;
ALTER TABLE `Product`.`Stock` CHANGE `id integer` id INT;

ALTER TABLE `Product`.`Payment`
ADD COLUMN `id` INT NOT NULL;


INSERT INTO `Product`.`Payment`(payment_id, invoice_id, payment_date, paymentAmount, paymentMethod, id)  
VALUES  (3, 303, '2024-10-04', 900.00, 'Готівка', 3),
  (4, 304, '2024-10-05', 800.00, 'Кредитна картка', 4), (7, 307, '2024-10-08', 150.00, 'Кредитна картка', 7),
  (8, 308, '2024-10-09', 240.00, 'Готівка', 8),
  (9, 309, '2024-10-10', 560.00, 'Банківський переказ', 9),
  (10, 310, '2024-10-11', 800.00, 'Кредитна картка', 10),
  (11, 311, '2024-10-12', 400.00, 'Готівка', 11),
  (12, 312, '2024-10-13', 160.00, 'Банківський переказ', 12),
  (13, 313, '2024-10-14', 540.00, 'Кредитна картка', 13),
  (14, 314, '2024-10-15', 110.00, 'Готівка', 14);

-- завдання 2

SET SQL_SAFE_UPDATES = 0; -- Отключаем защитный режим!
SET SQL_SAFE_UPDATES = 1; -- Возвращаем защитный режим обратно!


-- Видалення всіх записів з таблиці Payment
DELETE FROM `Product`.`Payment`;

-- Видалення всіх записів з таблиці Orders
DELETE FROM `Product`.`Orders`;

-- Видалення всіх записів з таблиці Customer
DELETE FROM `Product`.`Customer`;

-- Видалення всіх записів з таблиці Product
DELETE FROM `Product`.`Product`;

-- Видалення всіх записів з таблиці Supplier
DELETE FROM `Product`.`Supplier`;

-- Видалення всіх записів з таблиці Invoice
DELETE FROM `Product`.`Invoice`;

-- Видалення всіх записів з таблиці Employee
DELETE FROM `Product`.`Employee`;

-- Видалення всіх записів з таблиці ProductCategory
DELETE FROM `Product`.`ProductCategory`;

-- Видалення всіх записів з таблиці Sale
DELETE FROM `Product`.`Sale`;

-- Видалення всіх записів з таблиці stock
DELETE FROM `Product`.`Stock`;


-- завдання 2.2 
-- 1  Видалення з таблиці Payment, де сума платежу менша за 1000 
DELETE FROM `Product`.`Payment`
WHERE paymentAmount < 1000;

-- 2 Видалення з таблиці Orders, де кількість замовленого товару менша за 10
DELETE FROM `Product`.`Orders`
WHERE quantityOrdered < 10;

-- 3 Видалення з таблиці Customer, де клієнт зареєстрований до 2023 року
DELETE FROM `Product`.`Customer`
WHERE registrationDate < '2023-01-01';

-- 4 Видалення з таблиці Product, де ціна товару менша за 500
DELETE FROM `Product`.`Product`
WHERE UnitPrice < 500;

-- 5 Видалення з таблиці Supplier, де постачальник неактивний більше 2 років
DELETE FROM `Product`.`Supplier`
WHERE lastActiveDate < DATE_SUB(CURDATE(), INTERVAL 2 YEAR);
 
-- 6   Видалення з таблиці Invoice, де сума рахунку менша за середню
DELETE FROM `Product`.`Invoice`
WHERE totalAmount < (SELECT AVG(totalAmount) FROM `Product`.`Invoice`);

 -- 7 
 DELETE FROM `Product`.`Employee`
WHERE hireDate < '2017-02-05';
-- 8 
DELETE FROM `Product`.`Stock`
WHERE quantity < 20;

-- 9 
DELETE FROM `Product`.`Sale`
WHERE QuantityAfterSale < 30;

-- 10   Видалення категорій, які мають id більше 10
DELETE FROM `Product`.`ProductCategory`
WHERE category_id > 10;


 -- ЗАВДАННЯ 3 
 -- 3.1 
 -- Вивести повну інформацію про працівників
 SELECT * FROM `Product`.`Product`;
 
 -- Вивести повну інформацію про клієнтів
 SELECT DISTINCT customerName, contactInfo
FROM `Product`.`Customer`;

 -- Знайти клієнта з найбільшою кількістю замовлень
SELECT c.customer_id, c.customerName, c.contactInfo, COUNT(o.order_id) AS order_count
FROM `Product`.`Customer` c
LEFT JOIN `Product`.`Orders` o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customerName, c.contactInfo
HAVING COUNT(o.order_id) > 0  -- Використання реляційної операції
ORDER BY order_count DESC
LIMIT 1;

-- 3.2 
-- 1 Знайти середню кількість коштів, що отримано від замовників, для кожного місяця поточного року 
SELECT MONTH(orderDate) AS month, AVG(totalAmount) AS average_amount
FROM `Product`.`Orders`
WHERE YEAR(orderDate) = YEAR(CURRENT_DATE)
  AND totalAmount > 100  -- Булева операція
GROUP BY MONTH(orderDate);

-- 2 Знайти максимальну ціну продукту 
SELECT MAX(UnitPrice) AS max_price 
FROM `Product`.`Product`
WHERE UnitPrice BETWEEN 500 AND 1000;  -- Використання BETWEEN
 
-- 3 Знайти мінімальну кількість замовлень за клієнта
SELECT MIN(order_count) AS min_orders
FROM (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM `Product`.`Orders`
    WHERE customer_id IN (SELECT customer_id FROM `Product`.`Customer`)  -- Використання IN
    GROUP BY customer_id
) AS customer_orders;


-- Знайти працівника, що оформив найбільшу кількість замовлень.
SELECT E.employeeName, COUNT(S.Sale_id) AS orderCount
FROM `Product`.`Employee` E
JOIN `Product`.`Sale` S ON E.employee_id = S.Employee_id
GROUP BY E.employee_id
ORDER BY orderCount DESC
LIMIT 1;




-- Вимкнути перевірку зовнішніх ключів
SET FOREIGN_KEY_CHECKS = 0;

-- Оновити таблицю Sale
UPDATE `Product`.`Employee` 
SET employee_id = employee_id + 29 
WHERE employee_id BETWEEN 1 AND 15;


UPDATE `Product`.`Employee` 
SET employee_id = employee_id - 29 
WHERE employee_id BETWEEN 30 AND 44;


UPDATE `Product`.`Invoice` 
SET sale_id = sale_id + 29 
WHERE sale_id BETWEEN 1 AND 15;
-- Увімкнути перевірку зовнішніх ключів знову
SET FOREIGN_KEY_CHECKS = 1;

                                                              -- LAB 7 -- 
-- 1.1 Процедура для оновлення кількості товару на складі 
CALL UpdateStockQuantity (3, 42);

SELECT * FROM  `Product`.`Stock`;

-- 1.2 процедура для створення нового замовлення
CALL CreateOrder (19, 19, '2024-10-02', 6, 3, 1, 2352.00);

SELECT * FROM `Product`.`Orders`;

-- 1.3  процедура для оновлення інф про постачальника 
CALL UpdateSupplierContact (1, 'newemail@gmail.com');

SELECT * FROM `Product`.`Supplier`;

-- ФУНКЦІЇ --
-- 1 Функція для отримання ціни продукту
SELECT GetProductPrice(2);
-- 2 Функція для отримання кількості товару на складі
SELECT GetStockQuantity(3);
-- 3 Функція для отримання загальної суми продажів для продукту
SELECT GetTotalSalesAmount(2);

-- завдання 3 таблиця log
CREATE TABLE IF NOT EXISTS `Product`.`log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `table_name` VARCHAR(45) NOT NULL,
  `operation` VARCHAR(10) NOT NULL,
  `oper_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
 
 -- перевірка тригеру before insert для таблиці product
INSERT INTO `Product`.`Product` 
(product.ProductID, product.Name, product.UnitOfMeasure, product.UnitPrice, product.SupplierID, product.Category_id)
VALUES (20, 'Test Product2000', 'pcs', 1, 7, 3);

INSERT INTO `Product`.`Orders`  
(id, order_id, orderDate, customer_id, product_id, quantityOrdered, totalAmount) 
VALUES 
(16, 216, '2024-10-01', 16, 16, 43, 2000.00);

ALTER TABLE `Product`.`Product` 
DROP FOREIGN KEY fk_product_order;  

SELECT * FROM `Product`.`Product`;

ALTER TABLE `Product`.`Product`
ADD CONSTRAINT fk_product_order 
FOREIGN KEY (ProductID) REFERENCES `order`(id) 
ON DELETE SET NULL ON UPDATE SET NULL;

SELECT * FROM `Product`.`Orderss` WHERE id = 16;

SHOW CREATE TABLE `Product`.`Product`;

ALTER TABLE `Product`.`Orderss` DROP FOREIGN KEY `fk_product_orders`;
