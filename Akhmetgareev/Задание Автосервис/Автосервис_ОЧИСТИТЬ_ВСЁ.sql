/* ============================================================================
   Автосервис — ОЧИСТКА ВСЕХ ТАБЛИЦ (13 таблиц схемы ms.sql)
   ----------------------------------------------------------------------------
   Удаляет данные из всех таблиц в порядке, безопасном для внешних ключей.
   Использование: выполнить этот скрипт, затем «Автосервис_ТОЛЬКО_ДАННЫЕ.sql».
   ВНИМАНИЕ: удаляет ВСЕ данные. Запускать только осознанно.
   ============================================================================ */
SET NOCOUNT ON;
GO

-- 1) Дочерние таблицы (те, что ссылаются на другие)
DELETE FROM dbo.AttachedProduct;      -- -> Product
DELETE FROM dbo.ProductSale;          -- -> ClientService, Product
DELETE FROM dbo.DocumentByService;    -- -> ClientService
DELETE FROM dbo.ProductPhoto;         -- -> Product
DELETE FROM dbo.ServicePhoto;         -- -> Service
DELETE FROM dbo.TagOfClient;          -- -> Client, Tag
DELETE FROM dbo.ClientService;        -- -> Client, Service

-- 2) Родительские таблицы
DELETE FROM dbo.Client;
DELETE FROM dbo.Product;
DELETE FROM dbo.Service;
DELETE FROM dbo.Tag;
DELETE FROM dbo.Manufacturer;
DELETE FROM dbo.Gender;
GO

-- 3) Сброс IDENTITY: следующая вставка без явных ID начнётся с 1
DBCC CHECKIDENT ('dbo.Client', RESEED, 0);
DBCC CHECKIDENT ('dbo.ClientService', RESEED, 0);
DBCC CHECKIDENT ('dbo.DocumentByService', RESEED, 0);
DBCC CHECKIDENT ('dbo.Manufacturer', RESEED, 0);
DBCC CHECKIDENT ('dbo.Product', RESEED, 0);
DBCC CHECKIDENT ('dbo.ProductPhoto', RESEED, 0);
DBCC CHECKIDENT ('dbo.ProductSale', RESEED, 0);
DBCC CHECKIDENT ('dbo.Service', RESEED, 0);
DBCC CHECKIDENT ('dbo.ServicePhoto', RESEED, 0);
DBCC CHECKIDENT ('dbo.Tag', RESEED, 0);
GO

-- 4) Контроль: все значения должны быть 0
SELECT 'AttachedProduct' AS Таблица, COUNT(*) AS Строк FROM dbo.AttachedProduct
UNION ALL SELECT 'Client', COUNT(*) FROM dbo.Client
UNION ALL SELECT 'ClientService', COUNT(*) FROM dbo.ClientService
UNION ALL SELECT 'DocumentByService', COUNT(*) FROM dbo.DocumentByService
UNION ALL SELECT 'Gender', COUNT(*) FROM dbo.Gender
UNION ALL SELECT 'Manufacturer', COUNT(*) FROM dbo.Manufacturer
UNION ALL SELECT 'Product', COUNT(*) FROM dbo.Product
UNION ALL SELECT 'ProductPhoto', COUNT(*) FROM dbo.ProductPhoto
UNION ALL SELECT 'ProductSale', COUNT(*) FROM dbo.ProductSale
UNION ALL SELECT 'Service', COUNT(*) FROM dbo.Service
UNION ALL SELECT 'ServicePhoto', COUNT(*) FROM dbo.ServicePhoto
UNION ALL SELECT 'Tag', COUNT(*) FROM dbo.Tag
UNION ALL SELECT 'TagOfClient', COUNT(*) FROM dbo.TagOfClient;
GO
