/* ============================================================================
   Автосервис — чистовой импорт в MS SQL Server (для SSMS)
   Источники: client_a_import.txt, service_a_import.txt, serviceclient_a_import.xlsx
   Таблицы : Gender(справочник), Client(50), Service(100), ClientService(100)
   Исправлено: ФИО по колонкам, NBSP в телефонах, стоимость -> money,
   длительность -> секунды, скидка % -> float/NULL,
   ClientService: ID услуги и ID клиента восстановлены по названию/фамилии.
   Открывать в SSMS: файл в кодировке UTF-8 с BOM (кириллица корректна).
*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('dbo.ClientService', 'U') IS NOT NULL DROP TABLE dbo.ClientService;
IF OBJECT_ID('dbo.Client', 'U') IS NOT NULL DROP TABLE dbo.Client;
IF OBJECT_ID('dbo.Service', 'U') IS NOT NULL DROP TABLE dbo.Service;
IF OBJECT_ID('dbo.Gender', 'U') IS NOT NULL DROP TABLE dbo.Gender;
GO
CREATE TABLE [dbo].[Gender](
    [Code] [nchar](1) NOT NULL,
    [Name] [nvarchar](10) NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED ([Code] ASC)
);
GO
CREATE TABLE [dbo].[Client](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [FirstName] [nvarchar](50) NOT NULL,
    [LastName] [nvarchar](50) NOT NULL,
    [Patronymic] [nvarchar](50) NULL,
    [Birthday] [date] NULL,
    [RegistrationDate] [datetime] NOT NULL,
    [Email] [nvarchar](255) NULL,
    [Phone] [nvarchar](20) NOT NULL,
    [GenderCode] [nchar](1) NOT NULL,
    [PhotoPath] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO
CREATE TABLE [dbo].[Service](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](100) NOT NULL,
    [Cost] [money] NOT NULL,
    [DurationInSeconds] [int] NOT NULL,
    [Description] [nvarchar](max) NULL,
    [Discount] [float] NULL,
    [MainImagePath] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO
CREATE TABLE [dbo].[ClientService](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [ClientID] [int] NOT NULL,
    [ServiceID] [int] NOT NULL,
    [StartTime] [datetime] NOT NULL,
    [Comment] [nvarchar](max) NULL,
 CONSTRAINT [PK_ClientService] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO
ALTER TABLE [dbo].[Client] WITH CHECK ADD CONSTRAINT [FK_Client_Gender]
    FOREIGN KEY([GenderCode]) REFERENCES [dbo].[Gender] ([Code]);
ALTER TABLE [dbo].[ClientService] WITH CHECK ADD CONSTRAINT [FK_ClientService_Client]
    FOREIGN KEY([ClientID]) REFERENCES [dbo].[Client] ([ID]);
ALTER TABLE [dbo].[ClientService] WITH CHECK ADD CONSTRAINT [FK_ClientService_Service]
    FOREIGN KEY([ServiceID]) REFERENCES [dbo].[Service] ([ID]);
GO

INSERT INTO dbo.Gender (Code, Name) VALUES (N'м', N'Мужской'), (N'ж', N'Женский');

SET IDENTITY_INSERT dbo.Client ON;
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (1, N'Иветта', N'Мишина', N'Андреевна', DATEFROMPARTS(2002, 10, 05), '2016-01-24', N'aukjan@yahoo.com', N'7(3926)244-81-96', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (2, N'Божена', N'Суворова', N'Анатольевна', DATEFROMPARTS(1981, 03, 09), '2016-01-28', N'attwood@aol.com', N'7(347)895-86-57', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (3, N'Диана', N'Белозёрова', N'Антоновна', DATEFROMPARTS(1989, 02, 27), '2017-01-30', N'dialworld@aol.com', N'7(9900)174-59-87', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (4, N'Эдита', N'Дементьева', N'Онисимовна', DATEFROMPARTS(1975, 09, 17), '2018-11-24', N'frosal@hotmail.com', N'7(198)922-28-76', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (5, N'Евгений', N'Блинов', N'Мэлсович', DATEFROMPARTS(1994, 01, 05), '2017-05-07', N'moxfulder@outlook.com', N'7(0852)321-82-64', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (6, N'Наум', N'Морозов', N'Валерьянович', DATEFROMPARTS(1985, 07, 04), '2016-05-02', N'salesgeek@mac.com', N'7(636)050-96-13', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (7, N'Харита', N'Попова', N'Якуновна', DATEFROMPARTS(1997, 12, 16), '2016-07-05', N'firstpr@verizon.net', N'7(335)386-81-06', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (8, N'Наум', N'Крюков', N'Ильяович', DATEFROMPARTS(1993, 11, 17), '2017-02-01', N'floxy@hotmail.com', N'7(81)657-88-92', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (9, N'Авигея', N'Крюкова', N'Святославовна', DATEFROMPARTS(2000, 08, 10), '2018-01-03', N'simone@gmail.com', N'7(499)318-88-53', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (10, N'Сабрина', N'Беляева', N'Федосеевна', DATEFROMPARTS(1972, 07, 26), '2017-06-14', N'agapow@gmail.com', N'7(6580)534-32-58', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (11, N'Святослав', N'Медведев', N'Юлианович', DATEFROMPARTS(1972, 10, 04), '2018-10-13', N'hllam@comcast.net', N'7(3520)435-21-20', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (12, N'Пантелеймон', N'Блохин', N'Феликсович', DATEFROMPARTS(1978, 03, 06), '2018-02-14', N'balchen@comcast.net', N'7(9524)556-48-98', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (13, N'Никки', N'Горбачёва', N'Еремеевна', DATEFROMPARTS(1987, 04, 21), '2018-08-16', N'chinthaka@att.net', N'7(94)789-69-20', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (14, N'Прасковья', N'Архипова', N'Валерьевна', DATEFROMPARTS(1979, 01, 09), '2018-07-23', N'cgcra@live.com', N'7(86)540-10-21', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (15, N'Патрисия', N'Андреева', N'Валерьевна', DATEFROMPARTS(1993, 11, 18), '2016-07-17', N'jigsaw@aol.com', N'7(9648)953-81-26', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (16, N'Марта', N'Горшкова', N'Иосифовна', DATEFROMPARTS(2001, 02, 13), '2016-08-04', N'gbacon@mac.com', N'7(544)650-59-03', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (17, N'Влада', N'Орлова', N'Мартыновна', DATEFROMPARTS(1990, 06, 26), '2016-03-21', N'rnelson@yahoo.ca', N'7(2506)433-38-35', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (18, N'Глеб', N'Ершов', N'Федорович', DATEFROMPARTS(1970, 06, 14), '2016-09-14', N'sjava@aol.com', N'7(2608)298-40-82', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (19, N'Тала', N'Быкова', N'Георгьевна', DATEFROMPARTS(2000, 02, 22), '2016-08-13', N'ganter@optonline.net', N'7(13)915-53-53', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (20, N'Адриан', N'Новиков', N'Аркадьевич', DATEFROMPARTS(1974, 01, 15), '2018-11-23', N'multiplx@verizon.net', N'7(70)572-33-62', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (21, N'Аристарх', N'Филатов', N'Дмитриевич', DATEFROMPARTS(1989, 05, 29), '2017-01-11', N'hampton@att.net', N'7(696)235-29-24', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (22, N'Тамара', N'Анисимова', N'Витальевна', DATEFROMPARTS(1988, 06, 16), '2016-02-25', N'schwaang@mac.com', N'7(66)128-04-10', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (23, N'Аверкий', N'Кудряшов', N'Константинович', DATEFROMPARTS(1991, 07, 26), '2018-03-08', N'nanop@msn.com', N'7(88)732-96-30', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (24, N'Орест', N'Колобов', N'Юлианович', DATEFROMPARTS(2001, 07, 14), '2017-01-01', N'parkes@verizon.net', N'7(1680)508-58-26', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (25, N'Дэнна', N'Кузьмина', N'Витальевна', DATEFROMPARTS(1993, 08, 24), '2016-03-27', N'nichoj@mac.com', N'7(9940)977-45-73', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (26, N'Станислав', N'Александров', N'Эдуардович', DATEFROMPARTS(1981, 07, 04), '2018-11-08', N'bigmauler@aol.com', N'7(18)164-05-12', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (27, N'Станислав', N'Андреев', N'Максович', DATEFROMPARTS(1975, 10, 10), '2017-12-26', N'budinger@mac.com', N'7(02)993-91-28', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (28, N'Вольдемар', N'Дроздов', N'Артемович', DATEFROMPARTS(1976, 02, 07), '2017-07-18', N'smpeters@me.com', N'7(307)456-99-05', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (29, N'Станислав', N'Абрамов', N'Филатович', DATEFROMPARTS(1989, 05, 18), '2016-12-08', N'solomon@att.net', N'7(6545)478-87-79', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (30, N'Роза', N'Гусева', N'Дмитриевна', DATEFROMPARTS(1999, 02, 13), '2017-12-12', N'martyloo@live.com', N'7(23)064-51-84', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (31, N'Алексей', N'Лазарев', N'Богданович', DATEFROMPARTS(1977, 03, 10), '2017-01-02', N'claesjac@me.com', N'7(0055)737-37-48', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (32, N'Вадим', N'Большаков', N'Данилович', DATEFROMPARTS(1970, 05, 15), '2018-08-04', N'uncle@gmail.com', N'7(386)641-13-37', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (33, N'Витольд', N'Ефремов', N'Авксентьевич', DATEFROMPARTS(1975, 12, 02), '2018-04-09', N'kwilliams@yahoo.ca', N'7(93)922-14-03', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (34, N'Захар', N'Игнатов', N'Павлович', DATEFROMPARTS(1998, 10, 07), '2017-11-10', N'dieman@icloud.com', N'7(578)574-73-36', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (35, N'Артур', N'Калашников', N'Юрьевич', DATEFROMPARTS(1972, 12, 13), '2017-08-20', N'oevans@aol.com', N'7(147)947-47-21', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (36, N'Лаура', N'Овчинникова', N'Еремеевна', DATEFROMPARTS(1992, 04, 03), '2018-11-24', N'carcus@yahoo.ca', N'7(85)829-33-79', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (37, N'Иосиф', N'Голубев', N'Тимофеевич', DATEFROMPARTS(1982, 05, 06), '2018-08-18', N'smcnabb@att.net', N'7(78)972-73-11', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (38, N'Эрик', N'Галкин', N'Онисимович', DATEFROMPARTS(1975, 01, 18), '2016-07-19', N'snunez@verizon.net', N'7(759)873-77-39', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (39, N'Варлам', N'Некрасов', N'Михайлович', DATEFROMPARTS(2000, 11, 12), '2017-12-03', N'dogdude@verizon.net', N'7(019)258-06-35', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (40, N'Осип', N'Федотов', N'Анатольевич', DATEFROMPARTS(1971, 04, 13), '2018-07-23', N'breegster@hotmail.com', N'7(590)702-33-06', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (41, N'Мартын', N'Смирнов', N'Арсеньевич', DATEFROMPARTS(1996, 06, 25), '2017-02-07', N'haddawy@live.com', N'7(6251)589-02-43', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (42, N'Касьян', N'Копылов', N'Робертович', DATEFROMPARTS(1983, 08, 04), '2018-03-18', N'crobles@sbcglobal.net', N'7(5774)679-82-06', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (43, N'Элина', N'Дмитриева', N'Даниловна', DATEFROMPARTS(1988, 12, 10), '2017-02-11', N'vmalik@live.com', N'7(787)140-48-84', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (44, N'Инара', N'Бирюкова', N'Улебовна', DATEFROMPARTS(1978, 07, 21), '2017-10-01', N'smpeters@hotmail.com', N'7(098)346-50-58', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (45, N'Оскар', N'Васильев', N'Богданович', DATEFROMPARTS(1971, 01, 30), '2017-05-28', N'miturria@verizon.net', N'7(585)801-94-29', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (46, N'Устин', N'Киселёв', N'Яковлевич', DATEFROMPARTS(1985, 01, 08), '2018-06-21', N'dalamb@verizon.net', N'7(83)334-52-76', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (47, N'Леонтий', N'Кузьмин', N'Валерьянович', DATEFROMPARTS(2000, 05, 05), '2017-10-12', N'msloan@hotmail.com', N'7(1340)148-90-68', N'м', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (48, N'Магда', N'Ефимова', N'Платоновна', DATEFROMPARTS(1995, 08, 16), '2017-08-01', N'rbarreira@me.com', N'7(9261)386-15-92', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (49, N'Изабелла', N'Воронова', N'Вячеславовна', DATEFROMPARTS(1999, 09, 24), '2017-12-21', N'kildjean@sbcglobal.net', N'7(17)433-44-98', N'ж', NULL);
INSERT INTO dbo.Client (ID, FirstName, LastName, Patronymic, Birthday, RegistrationDate, Email, Phone, GenderCode, PhotoPath)
VALUES (50, N'Людвиг', N'Волков', N'Витальевич', DATEFROMPARTS(1977, 12, 27), '2016-04-27', N'jrkorson@msn.com', N'7(8459)592-05-58', N'м', NULL);
SET IDENTITY_INSERT dbo.Client OFF;

SET IDENTITY_INSERT dbo.Service ON;
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (1, N'Замена жидкости в кондиционере', 3040.00, 28800, NULL, 0.25, N'Услуги автосервиса\Кондиционер.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (2, N'Ремонт и замена коллектора', 2770.00, 9000, NULL, 0.15, N'Услуги автосервиса\Выхлопная система.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (3, N'Замена актуатора сцепления', 4100.00, 19800, NULL, 0.15, N'Услуги автосервиса\Сцепление.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (4, N'Замена жидкости ГУР', 2380.00, 32400, NULL, 0.2, N'Услуги автосервиса\ГУР.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (5, N'Заправка кондиционеров', 4860.00, 7200, NULL, 0.05, N'Услуги автосервиса\Кондиционер.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (6, N'Замена масла в вариаторе', 4720.00, 7200, NULL, 0.05, N'Услуги автосервиса\Вариатор.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (7, N'Ремонт двигателя', 2470.00, 14400, NULL, 0.25, N'Услуги автосервиса\Двигатель.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (8, N'Замена заднего сальника АКПП', 1510.00, 23400, NULL, 0.25, N'Услуги автосервиса\АКПП.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (9, N'Покраска', 2370.00, 7200, NULL, 0.15, N'Услуги автосервиса\Дополнительные услуги.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (10, N'Мойка колес', 3490.00, 34200, NULL, NULL, N'Услуги автосервиса\Шиномонтаж.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (11, N'Замена прокладки впускного-выпуского коллектора', 2980.00, 10800, NULL, NULL, N'Услуги автосервиса\Выхлопная система.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (12, N'Диагностика работы двигателя', 2760.00, 9000, NULL, 0.1, N'Услуги автосервиса\Двигатель.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (13, N'Установка сигнализации', 1760.00, 14400, NULL, NULL, N'Услуги автосервиса\Электрика.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (14, N'Замена компрессора кондиционера', 2720.00, 16200, NULL, 0.1, N'Услуги автосервиса\Кондиционер.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (15, N'Замена ремня привода ГУР', 3350.00, 36000, NULL, NULL, N'Услуги автосервиса\ГУР.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (16, N'Замена тормозных колодок', 4260.00, 28800, NULL, 0.05, N'Услуги автосервиса\Техническое обслуживание.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (17, N'Замена масла', 1430.00, 30600, NULL, 0.25, N'Услуги автосервиса\Техническое обслуживание.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (18, N'Замена цепи ГРМ', 4570.00, 21600, NULL, 0.2, N'Услуги автосервиса\Двигатель.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (19, N'Замена бензонасоса', 1780.00, 14400, NULL, 0.1, N'Услуги автосервиса\Топливная система.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (20, N'Ремонт приводного вала', 4520.00, 12600, NULL, 0.05, N'Услуги автосервиса\rulevoe-upravlenie-avtomobilya.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (21, N'Замена подшипника компрессора кондиционера', 1110.00, 19800, NULL, 0.2, N'Услуги автосервиса\Кондиционер.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (22, N'Снятие и установка колес', 3130.00, 23400, NULL, NULL, N'Услуги автосервиса\Шиномонтаж.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (23, N'Замена лямбда зонда', 770.00, 16200, NULL, 0.05, N'Услуги автосервиса\Выхлопная система.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (24, N'Замена привода в сборе', 3890.00, 28800, NULL, 0.15, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (25, N'Замена трубки кондиционера', 2810.00, 10800, NULL, 0.15, N'Услуги автосервиса\Кондиционер.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (26, N'Замена ремня кондиционера', 4650.00, 28800, NULL, NULL, N'Услуги автосервиса\Кондиционер.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (27, N'Замена охлаждающей жидкости', 1590.00, 12600, NULL, NULL, N'Услуги автосервиса\Техническое обслуживание.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (28, N'Замена троса сцепления', 4460.00, 28800, NULL, 0.05, N'Услуги автосервиса\Сцепление.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (29, N'Замена масла в МКПП', 4490.00, 32400, NULL, 0.2, N'Услуги автосервиса\КПП.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (30, N'Замена рулевой рейки', 4840.00, 34200, NULL, 0.25, N'Услуги автосервиса\rulevoe-upravlenie-avtomobilya.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (31, N'Ремонт дисков', 3860.00, 16200, NULL, 0.1, N'Услуги автосервиса\Шиномонтаж.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (32, N'Замена масла заднего редуктора (моста)', 840.00, 25200, NULL, 0.25, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (33, N'Замена подшипника задней ступицы', 1860.00, 16200, NULL, 0.25, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (34, N'Восстановление рулевых реек', 1020.00, 7200, NULL, 0.2, N'Услуги автосервиса\Подвеска.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (35, N'Замена рулевой тяги', 570.00, 10800, NULL, NULL, N'Услуги автосервиса\rulevoe-upravlenie-avtomobilya.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (36, N'Ремонт и замена гидроблока АКПП', 2040.00, 16200, NULL, NULL, N'Услуги автосервиса\АКПП.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (37, N'Замена масла раздаточной коробки', 2070.00, 30600, NULL, NULL, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (38, N'Диагностика кондиционера', 2590.00, 36000, NULL, 0.1, N'Услуги автосервиса\Кондиционер.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (39, N'Ремонт и замена катализатора', 500.00, 16200, NULL, 0.25, N'Услуги автосервиса\Выхлопная система.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (40, N'Замена гофры глушителя', 760.00, 16200, NULL, 0.25, N'Услуги автосервиса\Выхлопная система.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (41, N'Замена ремня ГРМ', 4630.00, 9000, NULL, 0.25, N'Услуги автосервиса\Двигатель.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (42, N'Ремонт редуктора', 870.00, 28800, NULL, 0.15, N'Услуги автосервиса\КПП.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (43, N'Замена электромагнитного клапана без снятия ТНВД', 4610.00, 27000, NULL, 0.1, N'Услуги автосервиса\diz.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (44, N'Вулканизация шин', 540.00, 19800, NULL, 0.2, N'Услуги автосервиса\Шиномонтаж.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (45, N'Ремонт стартера', 2680.00, 28800, NULL, NULL, N'Услуги автосервиса\Электрика.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (46, N'Ремонт коробки передач', 1850.00, 27000, NULL, 0.25, N'Услуги автосервиса\КПП.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (47, N'Жидкостная промывка топливной системы', 3620.00, 21600, NULL, 0.15, N'Услуги автосервиса\Топливная система.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (48, N'Ремонт генератора', 1700.00, 12600, NULL, 0.2, N'Услуги автосервиса\Электрика.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (49, N'Замена масла АКПП', 2430.00, 27000, NULL, 0.25, N'Услуги автосервиса\АКПП.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (50, N'Диагностика трансмиссии', 2790.00, 7200, NULL, 0.2, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (51, N'Монтаж и снятие шин с диска', 3990.00, 36000, NULL, 0.15, N'Услуги автосервиса\Шиномонтаж.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (52, N'Замена подшипника передней ступицы', 4020.00, 19800, NULL, 0.15, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (53, N'Замена главного цилиндра сцепления', 4910.00, 9000, NULL, 0.05, N'Услуги автосервиса\Сцепление.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (54, N'Установка автомагнитолы', 3210.00, 16200, NULL, NULL, N'Услуги автосервиса\Электрика.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (55, N'Диагностика рулевых тяг', 1680.00, 10800, NULL, 0.05, N'Услуги автосервиса\rulevoe-upravlenie-avtomobilya.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (56, N'Замена радиатора кондиционера', 1770.00, 32400, NULL, NULL, N'Услуги автосервиса\Кондиционер.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (57, N'Замена тормозной жидкости', 2200.00, 21600, NULL, 0.1, N'Услуги автосервиса\Техническое обслуживание.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (58, N'Ремонт рулевого управления', 3440.00, 7200, NULL, 0.2, N'Услуги автосервиса\Подвеска.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (59, N'Замена заднего редуктора', 2240.00, 19800, NULL, 0.25, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (60, N'Дефектация CVT', 1830.00, 10800, NULL, 0.05, N'Услуги автосервиса\Вариатор.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (61, N'Замена карданного вала', 4450.00, 7200, NULL, NULL, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (62, N'Замена сцепления', 4320.00, 19800, NULL, NULL, N'Услуги автосервиса\КПП.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (63, N'Установка системы автозапуска', 3620.00, 32400, NULL, NULL, N'Услуги автосервиса\Электрика.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (64, N'Замена опоры АКПП', 2540.00, 18000, NULL, 0.1, N'Услуги автосервиса\АКПП.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (65, N'Ремонт бензонасоса', 500.00, 12600, NULL, 0.15, N'Услуги автосервиса\Топливная система.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (66, N'Замена масла переднего редуктора (моста)', 3950.00, 32400, NULL, 0.05, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (67, N'Ремонт подвесного подшипника', 4440.00, 25200, NULL, 0.25, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (68, N'Тестирование форсунок (стенд)', 1600.00, 21600, NULL, NULL, N'Услуги автосервиса\Топливная система.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (69, N'Диагностика сцепления', 4210.00, 21600, NULL, 0.2, N'Услуги автосервиса\Сцепление.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (70, N'Замена ступицы в сборе', 4250.00, 9000, NULL, 0.2, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (71, N'Антибактериальная обработка кондиционера', 4580.00, 27000, NULL, 0.2, N'Услуги автосервиса\Кондиционер.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (72, N'Ремонт глушителя', 2100.00, 9000, NULL, 0.25, N'Услуги автосервиса\Выхлопная система.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (73, N'Диагностика рулевого редуктора', 2930.00, 10800, NULL, 0.1, N'Услуги автосервиса\rulevoe-upravlenie-avtomobilya.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (74, N'Диагностика подвески', 1460.00, 19800, NULL, NULL, N'Услуги автосервиса\Подвеска.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (75, N'Замена свечей', 2240.00, 7200, NULL, 0.1, N'Услуги автосервиса\Техническое обслуживание.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (76, N'Диагностика инжектора', 3390.00, 19800, NULL, 0.05, N'Услуги автосервиса\Топливная система.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (77, N'Комплексная диагностика автомобиля', 1120.00, 36000, NULL, NULL, N'Услуги автосервиса\Техническое обслуживание.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (78, N'Ремонт раздаточной коробки', 3610.00, 36000, NULL, 0.05, N'Услуги автосервиса\КПП.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (79, N'Удаление катализатора', 1930.00, 30600, NULL, 0.1, N'Услуги автосервиса\Дополнительные услуги.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (80, N'Снятие/установка форсунок', 1470.00, 18000, NULL, 0.25, N'Услуги автосервиса\diz.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (81, N'Развал-схождение', 3890.00, 10800, NULL, NULL, N'Услуги автосервиса\Подвеска.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (82, N'Замена выжимного подшипника', 2250.00, 36000, NULL, 0.05, N'Услуги автосервиса\Сцепление.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (83, N'Чистка форсунок ультразвуком', 3920.00, 14400, NULL, 0.05, N'Услуги автосервиса\Топливная система.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (84, N'Ремонт компрессора кондиционера', 4760.00, 9000, NULL, 0.25, N'Услуги автосервиса\Кондиционер.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (85, N'Замена цилиндра сцепления', 810.00, 28800, NULL, 0.25, N'Услуги автосервиса\Сцепление.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (86, N'Ремонт подвески (ходовой)', 680.00, 10800, NULL, 0.05, N'Услуги автосервиса\Подвеска.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (87, N'Замена фильтров', 530.00, 12600, NULL, 0.15, N'Услуги автосервиса\Техническое обслуживание.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (88, N'Кузовной ремонт', 2750.00, 9000, NULL, 0.05, N'Услуги автосервиса\Дополнительные услуги.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (89, N'Замена прокладки приемной трубки', 4680.00, 34200, NULL, 0.2, N'Услуги автосервиса\Выхлопная система.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (90, N'Диагностика выхлопной системы автомобиля', 2550.00, 10800, NULL, 0.25, N'Услуги автосервиса\Выхлопная система.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (91, N'Балансировка колес', 4690.00, 23400, NULL, 0.25, N'Услуги автосервиса\Шиномонтаж.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (92, N'Ремонт автоэлектрики', 4230.00, 27000, NULL, 0.1, N'Услуги автосервиса\Электрика.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (93, N'ТО с сохранением гарантии', 4300.00, 16200, NULL, 0.2, N'Услуги автосервиса\Техническое обслуживание.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (94, N'Ремонт карданного вала', 780.00, 12600, NULL, 0.05, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (95, N'Ремонт сцепления', 3290.00, 36000, NULL, 0.25, N'Услуги автосервиса\КПП.png');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (96, N'Замена кулисы АКПП', 3250.00, 21600, NULL, 0.1, N'Услуги автосервиса\АКПП.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (97, N'Ремонт кронштейна глушителя', 1410.00, 34200, NULL, NULL, N'Услуги автосервиса\Выхлопная система.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (98, N'Замена сальника привода', 3820.00, 34200, NULL, 0.15, N'Услуги автосервиса\transmission.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (99, N'Замена пыльника шруса', 4730.00, 18000, NULL, NULL, N'Услуги автосервиса\rulevoe-upravlenie-avtomobilya.jpg');
INSERT INTO dbo.Service (ID, Title, Cost, DurationInSeconds, Description, Discount, MainImagePath)
VALUES (100, N'Замена маховика', 2400.00, 36000, NULL, 0.25, N'Услуги автосервиса\Сцепление.jpg');
SET IDENTITY_INSERT dbo.Service OFF;

SET IDENTITY_INSERT dbo.ClientService ON;
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (1, 47, 49, '2019-04-15 13:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (2, 29, 92, '2019-11-27 13:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (3, 38, 32, '2019-07-29 10:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (4, 42, 15, '2019-09-05 14:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (5, 41, 80, '2019-02-04 19:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (6, 46, 49, '2019-06-24 14:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (7, 50, 45, '2019-12-05 18:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (8, 30, 25, '2019-03-19 09:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (9, 28, 50, '2019-10-09 18:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (10, 8, 83, '2019-05-19 16:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (11, 11, 7, '2019-08-02 18:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (12, 48, 90, '2019-12-06 09:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (13, 48, 35, '2019-08-08 19:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (14, 24, 8, '2019-04-14 15:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (15, 30, 75, '2019-09-09 17:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (16, 20, 28, '2019-10-16 18:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (17, 5, 50, '2019-12-07 17:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (18, 24, 13, '2019-09-05 19:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (19, 13, 80, '2019-11-26 10:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (20, 18, 27, '2019-07-30 10:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (21, 11, 96, '2019-07-07 09:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (22, 29, 75, '2019-12-15 14:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (23, 27, 71, '2019-12-16 19:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (24, 46, 52, '2019-06-28 10:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (25, 16, 92, '2019-12-30 14:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (26, 11, 8, '2019-02-26 17:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (27, 23, 28, '2019-11-15 15:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (28, 16, 81, '2019-09-13 10:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (29, 15, 81, '2019-03-06 12:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (30, 27, 74, '2019-04-11 16:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (31, 14, 71, '2019-07-12 19:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (32, 16, 88, '2019-07-09 18:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (33, 39, 15, '2019-11-23 14:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (34, 14, 27, '2019-08-15 18:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (35, 23, 23, '2019-11-27 09:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (36, 42, 7, '2019-12-23 15:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (37, 7, 45, '2019-09-17 11:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (38, 12, 84, '2019-07-02 15:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (39, 1, 74, '2019-08-12 11:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (40, 22, 65, '2019-04-15 11:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (41, 36, 100, '2019-06-10 16:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (42, 22, 39, '2019-02-21 08:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (43, 34, 88, '2019-10-14 12:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (44, 34, 87, '2019-12-15 19:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (45, 25, 57, '2019-08-24 11:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (46, 21, 13, '2019-06-15 09:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (47, 35, 52, '2019-04-22 11:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (48, 22, 39, '2019-02-24 13:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (49, 14, 95, '2019-02-15 17:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (50, 16, 27, '2019-07-09 16:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (51, 32, 96, '2019-08-24 17:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (52, 22, 97, '2019-08-25 08:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (53, 13, 81, '2019-06-21 14:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (54, 13, 13, '2019-12-28 17:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (55, 38, 49, '2019-01-29 16:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (56, 13, 90, '2019-11-30 18:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (57, 20, 98, '2019-10-17 19:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (58, 23, 4, '2019-03-16 10:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (59, 35, 98, '2019-11-14 15:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (60, 17, 33, '2019-12-18 10:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (61, 18, 92, '2019-06-14 18:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (62, 27, 74, '2019-07-05 13:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (63, 20, 75, '2019-10-14 19:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (64, 28, 27, '2019-08-21 17:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (65, 7, 75, '2019-05-28 11:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (66, 14, 72, '2019-09-19 16:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (67, 48, 73, '2019-06-22 13:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (68, 24, 26, '2019-08-08 17:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (69, 8, 52, '2019-08-12 08:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (70, 8, 49, '2019-03-04 11:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (71, 11, 13, '2019-03-22 15:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (72, 21, 94, '2019-06-05 10:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (73, 17, 75, '2019-04-21 12:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (74, 32, 4, '2019-07-28 12:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (75, 32, 32, '2019-10-10 13:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (76, 29, 100, '2019-04-05 10:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (77, 2, 87, '2019-07-30 12:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (78, 31, 52, '2019-12-30 08:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (79, 50, 75, '2019-06-29 17:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (80, 38, 8, '2019-08-19 17:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (81, 6, 26, '2019-11-05 12:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (82, 20, 97, '2019-01-19 11:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (83, 6, 9, '2019-04-14 14:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (84, 39, 21, '2019-05-27 08:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (85, 18, 75, '2019-06-16 12:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (86, 44, 21, '2019-08-12 15:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (87, 31, 72, '2019-04-06 11:50:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (88, 23, 84, '2019-05-23 11:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (89, 1, 76, '2019-09-20 08:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (90, 5, 84, '2019-02-24 13:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (91, 47, 21, '2019-05-01 10:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (92, 27, 94, '2019-05-27 14:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (93, 22, 4, '2019-02-16 09:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (94, 44, 65, '2019-03-23 16:40:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (95, 34, 32, '2019-12-24 09:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (96, 35, 16, '2019-05-09 10:00:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (97, 10, 65, '2019-10-05 18:30:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (98, 25, 15, '2019-04-26 10:20:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (99, 17, 15, '2019-08-05 10:10:00', NULL);
INSERT INTO dbo.ClientService (ID, ClientID, ServiceID, StartTime, Comment)
VALUES (100, 24, 95, '2019-12-19 15:00:00', NULL);
SET IDENTITY_INSERT dbo.ClientService OFF;
GO

/* ---- Контрольные запросы (можно показать преподавателю) ----
SELECT COUNT(*) AS Clients  FROM dbo.Client;         -- ожидается 50
SELECT COUNT(*) AS Services FROM dbo.Service;        -- ожидается 100
SELECT COUNT(*) AS Records  FROM dbo.ClientService;  -- ожидается 100
SELECT TOP 5 c.LastName, c.FirstName, COUNT(*) AS Услуг
FROM dbo.ClientService cs JOIN dbo.Client c ON c.ID = cs.ClientID
GROUP BY c.LastName, c.FirstName ORDER BY COUNT(*) DESC;
SELECT s.Title, COUNT(*) AS Записей FROM dbo.ClientService cs
JOIN dbo.Service s ON s.ID = cs.ServiceID GROUP BY s.Title
HAVING COUNT(*) > 1 ORDER BY COUNT(*) DESC;
*/
GO
