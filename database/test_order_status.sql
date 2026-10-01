-- =======================================================================
-- KỊCH BẢN KIỂM THỬ THAY ĐỔI 8 TRẠNG THÁI ĐƠN HÀNG TRONG CƠ SỞ DỮ LIỆU
-- =======================================================================
-- Hướng dẫn:
-- 1. Mở SQL Server Management Studio (SSMS) và kết nối CSDL WebDe04.
-- 2. Mở trình duyệt và đăng nhập tài khoản User (VD: user01 / 123456).
-- 3. Truy cập trang Lịch sử đặt hàng: http://localhost:8080/24110330_04/order-history
-- 4. Bôi đen và thực thi từng lệnh UPDATE dưới đây, sau đó F5 trình duyệt để
--    quan sát đơn hàng di chuyển qua các Tab trạng thái tương ứng.
-- =======================================================================

USE WebDe04;
GO

-- 1. Xem danh sách tất cả các đơn hàng hiện có
SELECT 
    OrderId, 
    Username, 
    ReceiverName, 
    ReceiverPhone, 
    TotalAmount, 
    Status, 
    OrderDate 
FROM Orders 
ORDER BY OrderId DESC;
GO

-- =======================================================================
-- THAY ĐỔI TRẠNG THÁI ĐƠN HÀNG (Thay số 1 bằng OrderId bạn muốn kiểm tra)
-- =======================================================================

-- Trạng thái 1: Đơn hàng mới (Khách vừa đặt xong)
UPDATE Orders 
SET Status = N'Đơn hàng mới' 
WHERE OrderId = 1;
GO

-- Trạng thái 2: Đã xác nhận (Admin/Shop đã gọi điện hoặc duyệt đơn)
UPDATE Orders 
SET Status = N'Đã xác nhận' 
WHERE OrderId = 1;
GO

-- Trạng thái 3: Chuẩn bị hàng (Kho đang đóng gói hàng hóa)
UPDATE Orders 
SET Status = N'Chuẩn bị hàng' 
WHERE OrderId = 1;
GO

-- Trạng thái 4: Vận chuyển (Hàng đã giao cho bưu cục trung chuyển)
UPDATE Orders 
SET Status = N'Vận chuyển' 
WHERE OrderId = 1;
GO

-- Trạng thái 5: Giao hàng (Shipper đang đi giao tới tay khách)
UPDATE Orders 
SET Status = N'Giao hàng' 
WHERE OrderId = 1;
GO

-- Trạng thái 6: Đã giao (Khách đã nhận được hàng và trả tiền COD)
UPDATE Orders 
SET Status = N'Đã giao' 
WHERE OrderId = 1;
GO

-- Trạng thái 7: Đơn hàng hủy (Đơn bị hủy bởi khách hoặc shop)
UPDATE Orders 
SET Status = N'Đơn hàng hủy' 
WHERE OrderId = 1;
GO

-- Trạng thái 8: Đơn hàng hoàn (Giao không thành công, hoàn trả về kho)
UPDATE Orders 
SET Status = N'Đơn hàng hoàn' 
WHERE OrderId = 1;
GO
