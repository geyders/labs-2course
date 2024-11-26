CREATE TABLE Religion (
    idReligion INT PRIMARY KEY,  -- первинний ключ для таблиці
    NameReligion VARCHAR(100),   -- назва релігії
    Description VARCHAR(255)     -- священна книга або книги для релігії
);

INSERT INTO Religion (idReligion, NameReligion, Description) 
VALUES 
(1, 'Christianity', 'The Bible'),
(2, 'Muslim', 'The Quran'),
(3, 'Hindu', 'The Vedas'),
(4, 'Buddhist', 'The Tripitaka'),
(5, 'Jewish', 'The Tanakh'),
(6, 'Folk religions',' Magic'),
(7, 'Unaffiliated', 'Fiction');

-- завдання 5(3 запити на оновлення) 

UPDATE Religion
SET NameReligion = 'Баїзм'
WHERE idReligion = 7;

UPDATE Religion
SET Description = 'Коран - священна книга для мусульман, яка містить основні релігійні настанови'
WHERE idReligion = 2; -- змінимо для ісламу 

-- завд 6
CREATE INDEX idx_name_religion
ON Religion (NameReligion);
 -- завд 7 Вибірка назви країни та основних релігій, для яких відсоток послідовників більше 10%:
 SELECT C.Name AS CountryName, C.GDP, R.NameReligion, CR.percentage
FROM Country C
JOIN CountryReligion CR ON C.CodeISO = CR.country_code
JOIN Religion R ON CR.id_religion = R.idReligion
WHERE C.GDP > 600;

-- Вибірка даних про країни, їх континент та відсоток послідовників релігії: 
SELECT C.Name AS CountryName, C.Continent, R.NameReligion, CR.percentage
FROM Country C
JOIN CountryReligion CR ON C.CodeISO = CR.country_code
JOIN Religion R ON CR.id_religion = R.idReligion
ORDER BY CR.percentage DESC;

-- Вибірка основної інформації про країну, релігії та ВВП:
SELECT C.Name AS CountryName, C.GDP, R.NameReligion, CR.percentage
FROM Country C
JOIN CountryReligion CR ON C.CodeISO = CR.country_code
JOIN Religion R ON CR.id_religion = R.idReligion
WHERE C.GDP > 5000;

-- завд 8.1 Видалення деяких записів з таблиці CountryReligion
SET SQL_SAFE_UPDATES = 0; -- Отключаем защитный режим!
DELETE FROM CountryReligion WHERE percentage < 5.00 LIMIT 3; -- Удаляем выбранную запись.
SET SQL_SAFE_UPDATES = 1; -- Возвращаем защитный режим обратно!

-- завд 8.2 Спроба видалити записи з таблиці Religion, що має обмеження зовнішнього ключа
DELETE FROM Religion
WHERE NameReligion = 'Народна релігія';

-- завд 8.3 Додавання каскадного видалення до зовнішнього ключа: 
SHOW CREATE TABLE CountryReligion; -- Визначення існуючих зовнішніх ключів 
ALTER TABLE CountryReligion -- Видалення зовнішнього ключа для id_religion 
DROP FOREIGN KEY CountryReligion_ibfk_2;
ALTER TABLE CountryReligion -- Створення нового зовнішнього ключа з каскадним видаленням 
ADD CONSTRAINT fkey_cascade_delete
FOREIGN KEY (id_religion)
REFERENCES Religion(idReligion)
ON DELETE CASCADE;

-- 8.4. Видалення запису з таблиці Religion з каскадним видаленням 
DELETE FROM Religion
WHERE idReligion = 6;

-- завд 9. Видалити вміст таблиці CountryReligion за допомогою оператора TRUNCATE TABLE
TRUNCATE TABLE CountryReligion;

-- завд 10. Видалити створені таблиці за допомогою оператора DROP TABLE
DROP TABLE IF EXISTS CountryReligion;
DROP TABLE IF EXISTS Religion;
  







