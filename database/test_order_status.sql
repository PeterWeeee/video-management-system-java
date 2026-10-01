-- =======================================================================
-- KỊCH BẢN KIỂM THỬ THAY ĐỔI 8 TRẠNG THÁI ĐƠN HÀNG TRONG CƠ SỞ DỮ LIỆU
-- =======================================================================
-- Hướng dẫn:
-- 1. Mở SQL Server Management Studio (SSMS) và kết nối CSDL WebDe04.
-- 2. Đăng nhập tài khoản User trên web và vào trang Lịch sử đặt hàng.
-- 3. Bôi đen và thực thi từng lệnh UPDATE dưới đây cho đơn hàng của bạn.
-- 4. Quay lại trang Lịch sử đặt hàng và F5 (Refresh) để xem đơn chuyển qua Tab tương ứng.
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
-- THAY ĐỔI TRẠNG THÁI CHO ĐƠN HÀNG MỚI NHẤT
-- (Hoặc bạn có thể gõ trực tiếp: WHERE OrderId = [Mã_Đơn_Của_Bạn])
-- =======================================================================

-- Trạng thái 1: Đơn hàng mới (Khách vừa đặt xong)
UPDATE Orders 
SET Status = N'Đơn hàng mới' 
WHERE OrderId = (SELECT TOP 1 OrderId FROM Orders ORDER BY OrderId DESC);
GO

-- Trạng thái 2: Đã xác nhận (Admin/Shop đã gọi điện xác nhận đơn)
UPDATE Orders 
SET Status = N'Đã xác nhận' 
WHERE OrderId = (SELECT TOP 1 OrderId FROM Orders ORDER BY OrderId DESC);
GO

-- Trạng thái 3: Chuẩn bị hàng (Kho đang đóng gói hàng hóa)
UPDATE Orders 
SET Status = N'Chuẩn bị hàng' 
WHERE OrderId = (SELECT TOP 1 OrderId FROM Orders ORDER BY OrderId DESC);
GO

-- Trạng thái 4: Vận chuyển (Hàng đã giao cho bưu cục trung chuyển)
UPDATE Orders 
SET Status = N'Vận chuyển' 
WHERE OrderId = (SELECT TOP 1 OrderId FROM Orders ORDER BY OrderId DESC);
GO

-- Trạng thái 5: Giao hàng (Shipper đang trên đường đi giao hàng)
UPDATE Orders 
SET Status = N'Giao hàng' 
WHERE OrderId = (SELECT TOP 1 OrderId FROM Orders ORDER BY OrderId DESC);
GO

-- Trạng thái 6: Đã giao (Khách đã nhận được hàng và trả tiền COD)
UPDATE Orders 
SET Status = N'Đã giao' 
WHERE OrderId = (SELECT TOP 1 OrderId FROM Orders ORDER BY OrderId DESC);
GO

-- Trạng thái 7: Đơn hàng hủy (Đơn bị hủy bởi khách hoặc shop)
UPDATE Orders 
SET Status = N'Đơn hàng hủy' 
WHERE OrderId = (SELECT TOP 1 OrderId FROM Orders ORDER BY OrderId DESC);
GO

-- Trạng thái 8: Đơn hàng hoàn (Giao hàng không thành công, bưu tá hoàn về)
UPDATE Orders 
SET Status = N'Đơn hàng hoàn' 
WHERE OrderId = (SELECT TOP 1 OrderId FROM Orders ORDER BY OrderId DESC);
GO
