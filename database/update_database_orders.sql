USE WebDe04;
GO

-- 1. Bổ sung cột Price và Stock vào bảng Videos nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Videos') AND name = 'Price')
BEGIN
    ALTER TABLE Videos ADD Price DECIMAL(18,0) NOT NULL DEFAULT 150000;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Videos') AND name = 'Stock')
BEGIN
    ALTER TABLE Videos ADD Stock INT NOT NULL DEFAULT 15;
END
GO

-- Cập nhật giá và số lượng tồn kho mẫu cho các video hiện có
UPDATE Videos SET Price = 199000, Stock = 10 WHERE VideoId = 'V01';
UPDATE Videos SET Price = 250000, Stock = 8  WHERE VideoId = 'V02';
UPDATE Videos SET Price = 180000, Stock = 12 WHERE VideoId = 'V03';
UPDATE Videos SET Price = 320000, Stock = 5  WHERE VideoId = 'V04';
UPDATE Videos SET Price = 210000, Stock = 7  WHERE VideoId = 'V05';
UPDATE Videos SET Price = 290000, Stock = 15 WHERE VideoId = 'V06';
UPDATE Videos SET Price = 350000, Stock = 20 WHERE VideoId = 'V07';
UPDATE Videos SET Price = 150000, Stock = 6  WHERE VideoId = 'V08';
UPDATE Videos SET Price = 220000, Stock = 9  WHERE VideoId = 'V09';
UPDATE Videos SET Price = 175000, Stock = 14 WHERE VideoId = 'V10';
UPDATE Videos SET Price = 280000, Stock = 11 WHERE VideoId = 'V11';
UPDATE Videos SET Price = 450000, Stock = 4  WHERE VideoId = 'V12';
GO

-- 2. Tạo bảng Orders (Đơn hàng)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Orders')
BEGIN
    CREATE TABLE Orders (
        OrderId INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL,
        OrderDate DATETIME DEFAULT GETDATE(),
        ReceiverName NVARCHAR(100) NOT NULL,
        ReceiverPhone NVARCHAR(20) NOT NULL,
        ReceiverAddress NVARCHAR(500) NOT NULL,
        PaymentMethod NVARCHAR(50) NOT NULL DEFAULT N'COD',
        TotalAmount DECIMAL(18,0) NOT NULL DEFAULT 0,
        Status NVARCHAR(50) NOT NULL DEFAULT N'Đơn hàng mới',
        Notes NVARCHAR(500) NULL,
        CONSTRAINT FK_Orders_Users FOREIGN KEY (Username) REFERENCES Users(Username) ON DELETE CASCADE ON UPDATE CASCADE
    );
END
GO

-- 3. Tạo bảng OrderItems (Chi tiết đơn hàng)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'OrderItems')
BEGIN
    CREATE TABLE OrderItems (
        OrderItemId INT IDENTITY(1,1) PRIMARY KEY,
        OrderId INT NOT NULL,
        VideoId NVARCHAR(50) NOT NULL,
        Price DECIMAL(18,0) NOT NULL,
        Quantity INT NOT NULL,
        CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_OrderItems_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId) ON DELETE CASCADE ON UPDATE CASCADE
    );
END
GO
