USE WebDe04;
GO

INSERT INTO Category (Categoryname, Categorycode, Images, Status)
VALUES 
(N'Lập trình Java', 'JAVA', 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=500', 1),
(N'Lập trình Web', 'WEB', 'https://images.unsplash.com/photo-1547658719-da2b51169166?w=500', 1),
(N'Cơ sở dữ liệu', 'DATABASE', 'https://images.unsplash.com/photo-1544383835-bda2bc66a55d?w=500', 1),
(N'Trí tuệ nhân tạo', 'AI', 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=500', 1);
GO

INSERT INTO Users (Username, Password, Phone, Fullname, Email, Admin, Active, Images)
VALUES 
('admin', '123456', '0901234567', N'Quản Trị Viên', 'admin@iotstar.vn', 1, 1, 'https://ui-avatars.com/api/?name=Admin'),
('thainguyen', '123456', '0912345678', N'Nguyễn Trí Thái', 'NguyenTT162.4@gmail.com', 1, 1, 'https://ui-avatars.com/api/?name=Nguyen+Tri+Thai'),
('user01', '123456', '0987000001', N'Trần Văn An', 'an.tv@gmail.com', 0, 1, 'https://ui-avatars.com/api/?name=Tran+An'),
('user02', '123456', '0987000002', N'Lê Thị Bình', 'binh.lt@gmail.com', 0, 1, 'https://ui-avatars.com/api/?name=Le+Binh'),
('user03', '123456', '0987000003', N'Phạm Quang Cường', 'cuong.pq@gmail.com', 0, 1, 'https://ui-avatars.com/api/?name=Pham+Cuong'),
('user04', '123456', '0987000004', N'Hoàng Thị Dung', 'dung.ht@gmail.com', 0, 1, 'https://ui-avatars.com/api/?name=Hoang+Dung'),
('user05', '123456', '0987000005', N'Đỗ Minh Đức', 'duc.dm@gmail.com', 0, 1, 'https://ui-avatars.com/api/?name=Do+Duc'),
('user06', '123456', '0987000006', N'Vũ Ngọc Hạnh', 'hanh.vn@gmail.com', 0, 1, 'https://ui-avatars.com/api/?name=Vu+Hanh'),
('user07', '123456', '0987000007', N'Bùi Thanh Hùng', 'hung.bt@gmail.com', 0, 1, 'https://ui-avatars.com/api/?name=Bui+Hung'),
('user08', '123456', '0987000008', N'Ngô Gia Khiêm', 'khiem.ng@gmail.com', 0, 1, 'https://ui-avatars.com/api/?name=Ngo+Khiem'),
('user09', '123456', '0987000009', N'Đặng Thu Lan', 'lan.dt@gmail.com', 0, 1, 'https://ui-avatars.com/api/?name=Dang+Lan'),
('user10', '123456', '0987000010', N'Mai Văn Nam', 'nam.mv@gmail.com', 0, 1, 'https://ui-avatars.com/api/?name=Mai+Nam'),
('user11', '123456', '0987000011', N'Trịnh Yến Nhi', 'nhi.ty@gmail.com', 0, 0, 'https://ui-avatars.com/api/?name=Trinh+Nhi'),
('user12', '123456', '0987000012', N'Lý Hải Phong', 'phong.lh@gmail.com', 0, 1, 'https://ui-avatars.com/api/?name=Ly+Phong');
GO

INSERT INTO Videos (VideoId, Title, Poster, Views, Description, Active, CategoryId, Price, Stock)
VALUES 
('V01', N'Hướng dẫn Lập trình Java Cơ bản cho Người mới bắt đầu', 'https://picsum.photos/id/1/400/250', 1250, N'Khóa học Java căn bản từ biến, vòng lặp đến lập trình hướng đối tượng OOP chi tiết.', 1, 1, 199000, 10),
('V02', N'Lập trình Hướng đối tượng OOP trong Java nâng cao', 'https://picsum.photos/id/2/400/250', 980, N'Tìm hiểu sâu về Kế thừa, Đa hình, Trừu tượng hóa và Đóng gói trong Java.', 1, 1, 250000, 8),
('V03', N'Java Collection Framework toàn tập', 'https://picsum.photos/id/3/400/250', 840, N'Hướng dẫn sử dụng List, Set, Map, HashMap, ArrayList và tối ưu hóa hiệu năng.', 1, 1, 180000, 12),
('V04', N'Xử lý Đa luồng Multithreading trong Java', 'https://picsum.photos/id/4/400/250', 620, N'Làm chủ Thread, Runnable, ExecutorService, Lock và Synchronized.', 1, 1, 320000, 5),
('V05', N'Lập trình Mạng Socket trong Java', 'https://picsum.photos/id/5/400/250', 450, N'Xây dựng ứng dụng Chat Client - Server với Socket TCP/IP.', 1, 1, 210000, 7),
('V06', N'Java JDBC Kết nối SQL Server thực chiến', 'https://picsum.photos/id/6/400/250', 1560, N'Kết nối Java với SQL Server thực hiện các thao tác CRUD cơ bản và nâng cao.', 1, 1, 290000, 15),
('V07', N'Xây dựng Website với Java Servlet và JSP', 'https://picsum.photos/id/7/400/250', 2100, N'Hướng dẫn chi tiết kiến trúc MVC 3 lớp kết hợp Servlet JSP và Sitemesh.', 1, 2, 350000, 20),
('V08', N'Tạo Form Đăng nhập và Session trong Servlet', 'https://picsum.photos/id/8/400/250', 1780, N'Bảo mật ứng dụng web với Session, Cookie và Filter xác thực đăng nhập.', 1, 2, 150000, 6),
('V09', N'Tích hợp gửi OTP kích hoạt tài khoản qua Gmail', 'https://picsum.photos/id/9/400/250', 1420, N'Sử dụng Jakarta Mail gửi mã OTP xác nhận kích hoạt tài khoản đăng ký.', 1, 2, 220000, 9),
('V10', N'Thiết kế CSDL Quan hệ Chuẩn hóa SQL Server', 'https://picsum.photos/id/10/400/250', 890, N'Hướng dẫn chuẩn hóa 1NF, 2NF, 3NF và tối ưu truy vấn Indexing.', 1, 3, 175000, 14),
('V11', N'Viết Stored Procedure và Trigger trong SQL Server', 'https://picsum.photos/id/11/400/250', 730, N'Nâng cao kỹ năng quản trị CSDL với Proc, Trigger và Transaction.', 1, 3, 280000, 11),
('V12', N'Nhập môn Trí tuệ nhân tạo và Machine Learning', 'https://picsum.photos/id/12/400/250', 3200, N'Tổng quan về AI, Deep Learning và các mô hình ngôn ngữ lớn hiện đại.', 1, 4, 450000, 4);
GO

INSERT INTO Shares (Emails, SharedDate, Username, VideoId)
VALUES 
('friend1@gmail.com', '2026-09-01', 'user01', 'V01'),
('friend2@gmail.com', '2026-09-02', 'user02', 'V01'),
('friend3@gmail.com', '2026-09-03', 'user03', 'V01'),
('friend4@gmail.com', '2026-09-04', 'user04', 'V01'),
('friend5@gmail.com', '2026-09-05', 'user05', 'V01'),
('student1@gmail.com', '2026-09-06', 'user01', 'V07'),
('student2@gmail.com', '2026-09-07', 'user02', 'V07'),
('student3@gmail.com', '2026-09-08', 'user03', 'V07'),
('user_share@gmail.com', '2026-09-09', 'thainguyen', 'V02');
GO

INSERT INTO Favorites (LikedDate, VideoId, Username)
VALUES 
('2026-09-01', 'V01', 'user01'),
('2026-09-02', 'V01', 'user02'),
('2026-09-03', 'V01', 'user03'),
('2026-09-04', 'V01', 'user04'),
('2026-09-05', 'V01', 'user05'),
('2026-09-06', 'V01', 'thainguyen'),
('2026-09-07', 'V07', 'user01'),
('2026-09-08', 'V07', 'user02'),
('2026-09-09', 'V07', 'user03'),
('2026-09-10', 'V07', 'thainguyen'),
('2026-09-11', 'V02', 'user04'),
('2026-09-12', 'V03', 'user05');
GO
