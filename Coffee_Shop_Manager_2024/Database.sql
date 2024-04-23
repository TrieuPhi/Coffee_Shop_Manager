-- Food
-- Table
-- FoodCategory
-- Account
-- Bill
-- BillInfo


CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Bàn chưa có tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'Trống'	-- Trống || Có người
)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,	
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'Kter',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL  DEFAULT 0 -- 1: admin && 0: staff
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên'
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0
	
	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0 -- 1: đã thanh toán && 0: chưa thanh toán
	
	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0
	
	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food(id)
)
GO

INSERT INTO dbo.Account
        ( UserName ,
          DisplayName ,
          PassWord ,
          Type
        )
VALUES  ( N'K9' , -- UserName - nvarchar(100)
          N'RongK9' , -- DisplayName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(1000)
          1  -- Type - int
        )
INSERT INTO dbo.Account
        ( UserName ,
          DisplayName ,
          PassWord ,
          Type
        )
VALUES  ( N'staff' , -- UserName - nvarchar(100)
          N'staff' , -- DisplayName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(1000)
          0  -- Type - int
        )
GO

CREATE OR ALTER PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS 
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO

EXEC dbo.USP_GetAccountByUserName @userName = N'K9' -- nvarchar(100)
GO 


CREATE OR ALTER PROC USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END
GO


DECLARE @i INT = 0

WHILE @i <= 10
BEGIN
	INSERT dbo.TableFood ( name)VALUES  ( N'Bàn ' + CAST(@i AS nvarchar(100)))
	SET @i = @i + 1
END

select * from TableFood
GO

--=====PROC LOAD DS BÀN ĂN=============
CREATE OR ALTER PROC USP_GetTableList
AS SELECT * FROM TableFood
GO 
Exec USP_GetTableList
--====================================
UPDATE dbo.TableFood SET STATUS = N'Có người' WHERE id = 9


--===========Bắt đầu đoạn hiển thị hóa đơn theo bàn. 
-- thêm category
INSERT INTO dbo.FoodCategory (name)
VALUES 
    (N'Hải sản'),
    (N'Nông sản'),
    (N'Lâm sản'),
    (N'Sản sản'),
    (N'Nước');


-- thêm món ăn
INSERT INTO dbo.Food (name, idCategory, price)
VALUES 
    (N'Mực một nắng nước sa tế', 1, 120000),
    (N'Nghêu hấp xả', 1, 50000),
    (N'Dú dê nướng sữa', 2, 60000),
    (N'Heo rừng nướng muối ớt', 3, 75000),
    (N'Cơm chiên mushi', 4, 999999),
    (N'7Up', 5, 15000),
    (N'Cafe', 5, 12000);


-- thêm bill
INSERT INTO dbo.Bill (DateCheckIn, DateCheckOut, idTable, status)
VALUES 
    (GETDATE(), NULL, 3, 0),
    (GETDATE(), NULL, 4, 0),
    (GETDATE(), GETDATE(), 5, 1);

        
-- thêm bill info
INSERT INTO dbo.BillInfo (idBill, idFood, count)
VALUES 
    (1, 1, 2),
    (1, 3, 4),
    (2, 5, 1),
    (2, 1, 2),
    (3, 6, 2),
    (3, 5, 2);


Select * from Bill
select * from BillInfo 
select * from Food 
select * from FoodCategory