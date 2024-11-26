CREATE TABLE CountryReligion (
    country_code CHAR(3),  -- код країни, який зазвичай зберігається в 3-символьному форматі (ISO стандарт)
    id_religion INT,       -- ідентифікатор релігії для зв'язку з таблицею Religion
    percentage DECIMAL(5, 2),  -- відсоток тих, хто є прибічниками цієї релігії у відсотках (наприклад, 23.50)
    PRIMARY KEY (country_code, id_religion),  -- комбінація country_code та id_religion як первинний ключ
    FOREIGN KEY (country_code) REFERENCES Country(CodeISO),  -- зовнішній ключ до таблиці Country
    FOREIGN KEY (id_religion) REFERENCES Religion(idReligion)      -- зовнішній ключ до таблиці Religion
);

-- Вставляємо дані про релігії для країн Центральної Африки у таблицю CountryReligion
INSERT INTO CountryReligion (country_code, id_religion, percentage)
VALUES
-- Дані для Центральноафриканської Республіки
('CF', 1, 50.0), -- 50% Християнство
('CF', 2, 15.0), -- 15% Іслам
('CF', 3, 20.0), -- 20% Індуїзм
('CF', 4, 10.0), -- 10% Буддизм
('CF', 5, 5.0),  -- 5% Юдаїзм
('CF', 6, 10.0), -- 10% Буддизм
('CF', 7, 5.0),  -- 5% Юдаїзм

-- Дані для Конго
('CD', 1, 80.0), -- 80% Християнство
('CD', 2, 10.0), -- 10% Іслам
('CD', 3, 5.0),  -- 5% Індуїзм
('CD', 4, 3.0),  -- 3% Буддизм
('CD', 5, 2.0),  -- 2% Юдаїзм
('CD', 6, 3.0),  -- 3% Буддизм
('CD', 7, 2.0),  -- 2% Юдаїзм

-- Дані для Габону
('GA', 1, 60.0), -- 60% Християнство
('GA', 2, 25.0), -- 25% Іслам
('GA', 3, 8.0),  -- 8% Індуїзм
('GA', 4, 5.0),  -- 5% Буддизм
('GA', 5, 2.0), -- 2% Юдаїзм
('GA', 6, 2.0),  -- 2% Юдаїзм
('GA', 7, 2.0);  -- 2% Юдаїзм

-- завд 5

UPDATE CountryReligion
SET percentage = 60.0
WHERE country_code = 'CD' AND id_religion = 1; -- Конго християнство 60%


 

