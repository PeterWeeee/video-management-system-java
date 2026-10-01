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

-- 4. Dữ liệu mẫu đơn hàng với các trạng thái khác nhau để kiểm thử lọc đơn hàng
-- Trạng thái 1: Đơn hàng mới
INSERT INTO Orders (Username, OrderDate, ReceiverName, ReceiverPhone, ReceiverAddress, PaymentMethod, TotalAmount, Status, Notes)
VALUES ('user01', DATEADD(DAY, -1, GETDATE()), N'Trần Văn An', '0987000001', N'Số 1 Võ Văn Ngân, Thủ Đức, TP.HCM', N'COD', 449000, N'Đơn hàng mới', N'Giao vào giờ hành chính');
INSERT INTO OrderItems (OrderId, VideoId, Price, Quantity) VALUES (SCOPE_IDENTITY(), 'V01', 199000, 1);
INSERT INTO OrderItems (OrderId, VideoId, Price, Quantity) VALUES (SCOPE_IDENTITY(), 'V02', 250000, 1);

-- Trạng thái 2: Đã xác nhận
INSERT INTO Orders (Username, OrderDate, ReceiverName, ReceiverPhone, ReceiverAddress, PaymentMethod, TotalAmount, Status, Notes)
VALUES ('user01', DATEADD(DAY, -2, GETDATE()), N'Trần Văn An', '0987000001', N'Số 1 Võ Văn Ngân, Thủ Đức, TP.HCM', N'COD', 350000, N'Đã xác nhận', N'Gọi trước khi giao');
INSERT INTO OrderItems (OrderId, VideoId, Price, Quantity) VALUES (SCOPE_IDENTITY(), 'V07', 350000, 1);

-- Trạng thái 3: Chuẩn bị hàng
INSERT INTO Orders (Username, OrderDate, ReceiverName, ReceiverPhone, ReceiverAddress, PaymentMethod, TotalAmount, Status, Notes)
VALUES ('user01', DATEADD(DAY, -3, GETDATE()), N'Trần Văn An', '0987000001', N'Số 1 Võ Văn Ngân, Thủ Đức, TP.HCM', N'COD', 320000, N'Chuẩn bị hàng', N'Đóng gói cẩn thận giúp mình');
INSERT INTO OrderItems (OrderId, VideoId, Price, Quantity) VALUES (SCOPE_IDENTITY(), 'V04', 320000, 1);

-- Trạng thái 4: Vận chuyển
INSERT INTO Orders (Username, OrderDate, ReceiverName, ReceiverPhone, ReceiverAddress, PaymentMethod, TotalAmount, Status, Notes)
VALUES ('user01', DATEADD(DAY, -4, GETDATE()), N'Trần Văn An', '0987000001', N'Số 1 Võ Văn Ngân, Thủ Đức, TP.HCM', N'COD', 290000, N'Vận chuyển', N'Bưu cục TP.HCM đang chuyển');
INSERT INTO OrderItems (OrderId, VideoId, Price, Quantity) VALUES (SCOPE_IDENTITY(), 'V06', 290000, 1);

-- Trạng thái 5: Giao hàng
INSERT INTO Orders (Username, OrderDate, ReceiverName, ReceiverPhone, ReceiverAddress, PaymentMethod, TotalAmount, Status, Notes)
VALUES ('user01', DATEADD(DAY, -5, GETDATE()), N'Trần Văn An', '0987000001', N'Số 1 Võ Văn Ngân, Thủ Đức, TP.HCM', N'COD', 220000, N'Giao hàng', N'Shipper đang trên đường giao');
INSERT INTO OrderItems (OrderId, VideoId, Price, Quantity) VALUES (SCOPE_IDENTITY(), 'V09', 220000, 1);

-- Trạng thái 6: Đã giao
INSERT INTO Orders (Username, OrderDate, ReceiverName, ReceiverPhone, ReceiverAddress, PaymentMethod, TotalAmount, Status, Notes)
VALUES ('user01', DATEADD(DAY, -6, GETDATE()), N'Trần Văn An', '0987000001', N'Số 1 Võ Văn Ngân, Thủ Đức, TP.HCM', N'COD', 450000, N'Đã giao', N'Đã nhận đủ hàng và thanh toán COD');
INSERT INTO OrderItems (OrderId, VideoId, Price, Quantity) VALUES (SCOPE_IDENTITY(), 'V12', 450000, 1);

-- Trạng thái 7: Đơn hàng hủy
INSERT INTO Orders (Username, OrderDate, ReceiverName, ReceiverPhone, ReceiverAddress, PaymentMethod, TotalAmount, Status, Notes)
VALUES ('user01', DATEADD(DAY, -7, GETDATE()), N'Trần Văn An', '0987000001', N'Số 1 Võ Văn Ngân, Thủ Đức, TP.HCM', N'COD', 180000, N'Đơn hàng hủy', N'Khách đổi ý muốn đặt khóa khác');
INSERT INTO OrderItems (OrderId, VideoId, Price, Quantity) VALUES (SCOPE_IDENTITY(), 'V03', 180000, 1);

-- Trạng thái 8: Đơn hàng hoàn
INSERT INTO Orders (Username, OrderDate, ReceiverName, ReceiverPhone, ReceiverAddress, PaymentMethod, TotalAmount, Status, Notes)
VALUES ('user01', DATEADD(DAY, -8, GETDATE()), N'Trần Văn An', '0987000001', N'Số 1 Võ Văn Ngân, Thủ Đức, TP.HCM', N'COD', 210000, N'Đơn hàng hoàn', N'Không liên lạc được khách, hoàn về');
INSERT INTO OrderItems (OrderId, VideoId, Price, Quantity) VALUES (SCOPE_IDENTITY(), 'V05', 210000, 1);
GO
