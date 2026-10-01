# Video Management System (Java Web MVC)

Dự án Hệ thống Quản lý và Chia sẻ Video trực tuyến xây dựng trên nền tảng **Java Web (Jakarta EE 10, Servlet 6.1, JSP 4.0)** theo mô hình kiến trúc MVC 3 lớp, kết hợp giao diện Bootstrap hiện đại và bộ trang trí SiteMesh 3.

---

## Tính năng nổi bật

### 1. Phân hệ Người dùng (User)
- **Xem & Khám phá Video**: Xem danh sách video theo danh mục, xem chi tiết video, tăng lượt xem.
- **Tương tác**: Yêu thích (Favorites), chia sẻ video qua email (Shares).
- **Xác thực an toàn (Authentication)**:
  - Đăng ký tài khoản gửi mã OTP tự động qua Gmail (sử dụng **Jakarta Angus Mail**).
  - Xác thực OTP kích hoạt tài khoản.
  - Đăng nhập, Ghi nhớ đăng nhập (Remember Me) bằng Cookie và Session.
- **Thương mại điện tử & Đặt hàng (E-Commerce)**:
  - **Giỏ hàng (Shopping Cart)**:
    - Thêm sản phẩm/video vào giỏ hàng.
    - Cập nhật số lượng linh hoạt bằng nút `+` / `-` hoặc nhập số trực tiếp.
    - Kiểm soát số lượng nghiêm ngặt theo giới hạn tồn kho `Stock` (không cho phép vượt quá số lượng trong kho).
    - Xóa từng sản phẩm hoặc làm trống toàn bộ giỏ hàng.
  - **Thanh toán đơn hàng bằng COD (Cash On Delivery)**:
    - Nhập họ tên, số điện thoại, địa chỉ nhận hàng và ghi chú đơn hàng.
    - Phương thức thanh toán khi nhận hàng (Ship COD).
    - Tự động trừ số lượng tồn kho `Stock` trong CSDL khi đặt hàng thành công.
    - Tự động làm trống giỏ hàng và chuyển sang trang xác nhận đơn hàng thành công.
  - **Lịch sử đặt hàng & Bộ lọc 8 Trạng thái**:
    - Hiển thị danh sách tất cả các đơn hàng đã đặt của tài khoản.
    - Thanh điều hướng Tabs lọc theo chính xác 8 trạng thái kèm Badge đếm số lượng:
      1. `Đơn hàng mới` (Mặc định khi vừa đặt)
      2. `Đã xác nhận`
      3. `Chuẩn bị hàng`
      4. `Vận chuyển`
      5. `Giao hàng`
      6. `Đã giao`
      7. `Đơn hàng hủy`
      8. `Đơn hàng hoàn`
    - Cho phép khách hàng chủ động hủy đơn khi đơn hàng đang ở trạng thái `Đơn hàng mới` (tự động hoàn lại số lượng tồn kho `Stock` vào CSDL).

### 2. Phân hệ Quản trị (Admin)
- **Admin Dashboard**: Thống kê số lượng video, danh mục, người dùng, lượt tương tác.
- **Quản lý Người dùng**: Xem danh sách, thêm, sửa thông tin, phân quyền Admin, khóa/mở kích hoạt tài khoản.
- **Quản trị nội dung**: Quản lý Video và Danh mục.

---

## Công nghệ sử dụng (Tech Stack)

| Thành phần | Công nghệ |
| :--- | :--- |
| **Ngôn ngữ** | Java 21 (LTS) |
| **Nền tảng Web** | Jakarta EE 10 (Servlet 6.1, JSP 4.0, JSTL 3.0) |
| **Cơ sở dữ liệu** | Microsoft SQL Server 2019+ |
| **JDBC Driver** | `mssql-jdbc` 12.8.1 |
| **Gửi Mail & OTP** | Eclipse Angus Mail 2.0.3 (Jakarta Mail) |
| **Layout Decorator**| SiteMesh 3 (`org.sitemesh:sitemesh:3.3.0-RC1`) |
| **Giao diện UI** | Bootstrap 5, Bootstrap Icons, Font Awesome |
| **Build Tool** | Apache Maven 3.8+ |
| **Web Server** | Apache Tomcat 10.1+ / 11 |

---

## Cấu trúc thư mục

```text
├── database/
│   ├── create_database.sql       # Script khởi tạo cơ sở dữ liệu WebDe04
│   ├── insert_records.sql        # Dữ liệu mẫu (Users, Categories, Videos...)
│   ├── update_database_orders.sql# Script cập nhật Price, Stock và tạo bảng Orders
│   └── test_order_status.sql     # Script kiểm thử thay đổi 8 trạng thái đơn hàng
├── src/
│   ├── main/
│   │   ├── java/vn/iotstar/
│   │   │   ├── connection/       # Kết nối CSDL (DBConnect)
│   │   │   ├── controller/       # Các Servlet điều hướng nghiệp vụ
│   │   │   ├── dao/              # Tầng DAO truy vấn CSDL
│   │   │   ├── filter/           # SiteMesh filter và Security filter
│   │   │   ├── model/            # Các Entity/Model dữ liệu
│   │   │   ├── service/          # Tầng xử lý logic nghiệp vụ
│   │   │   └── util/             # Tiện ích (EmailUtil, Hash...)
│   │   ├── resources/
│   │   │   └── mail.properties.example # Mẫu cấu hình Gmail OTP
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── decorators/   # Template SiteMesh (admin.jsp, web.jsp)
│   │       │   ├── views/        # Giao diện JSP (admin, web, common)
│   │       │   ├── sitemesh3.xml # Cấu hình rules cho SiteMesh
│   │       │   └── web.xml       # Deployment descriptor
│   └── test/
└── pom.xml
```

---

## Hướng dẫn cài đặt & Khởi chạy

### 1. Chuẩn bị môi trường
- Cài đặt **JDK 21**
- Cài đặt **Apache Tomcat 10.1** (hỗ trợ Jakarta EE 10 / Servlet 6.0+)
- Cài đặt **Microsoft SQL Server**

### 2. Thiết lập Cơ sở dữ liệu
1. Mở **SQL Server Management Studio (SSMS)**.
2. Nếu cài đặt mới từ đầu:
   - Thực thi file `database/create_database.sql` để tạo CSDL `WebDe04` kèm các bảng `Videos` (có `Price`, `Stock`), `Orders`, `OrderItems`.
   - Thực thi file `database/insert_records.sql` để nạp dữ liệu mẫu ban đầu (bao gồm 8 đơn hàng mẫu ở 8 trạng thái khác nhau).
3. Nếu đã có sẵn CSDL `WebDe04` cũ:
   - Thực thi file `database/update_database_orders.sql` để bổ sung cột `Price`, `Stock` và tạo bảng `Orders`, `OrderItems`.

### 3. Cấu hình biến môi trường / Thông tin bảo mật
Bạn có thể cấu hình thông qua **Biến môi trường (Environment Variables)**:

```bash
# Thông tin CSDL (Mặc định: localhost:1433, sa/123456)
DB_HOST=localhost
DB_PORT=1433
DB_NAME=WebDe04
DB_USER=sa
DB_PASSWORD=your_db_password

# Thông tin gửi Gmail OTP
MAIL_USERNAME=your_gmail@gmail.com
MAIL_PASSWORD=your_google_app_password
```

Hoặc sao chép file cấu hình nội bộ (đã được cấu hình trong `.gitignore` để không bị push lên mạng):
```bash
cp src/main/resources/mail.properties.example src/main/resources/mail.properties
```
Sau đó điền thông tin App Password của tài khoản Google của bạn vào file `mail.properties`.

### 4. Build và Chạy dự án
Build gói `.war` bằng Maven:
```bash
mvn clean package
```
Deploy file `target/24110330_04.war` lên Apache Tomcat hoặc cấu hình trực tiếp trên Eclipse / IntelliJ IDEA / VS Code:
- URL người dùng: `http://localhost:8080/24110330_04/`
- Trang quản trị: `http://localhost:8080/24110330_04/admin/home`

### 5. Kiểm thử 8 Trạng thái Đơn hàng trong Database
Để quan sát trạng thái đơn hàng thay đổi theo thời gian thực:
1. Đăng nhập tài khoản `user01` (mật khẩu `123456`).
2. Vào mục **Xin chào, Trần Văn An** -> **Lịch sử đặt hàng** (hoặc URL: `http://localhost:8080/24110330_04/order-history`).
3. Mở file `database/test_order_status.sql` trong SSMS và chạy các lệnh `UPDATE Orders SET Status = ... WHERE OrderId = 1;`.
4. Nhấn **F5** trên trình duyệt hoặc chuyển đổi giữa các Tab trạng thái để thấy đơn hàng hiển thị chính xác theo từng trạng thái tương ứng.

---

## Tài khoản mặc định

| Vai trò | Tên đăng nhập | Mật khẩu | Ghi chú |
| :--- | :--- | :--- | :--- |
| **Admin** | `admin` | `123456` | Toàn quyền quản trị |
| **Admin** | `thainguyen` | `123456` | Quản trị viên |
| **User** | `user01` | `123456` | Người dùng đã kích hoạt |
| **User** | `user02` | `123456` | Người dùng đã kích hoạt |
