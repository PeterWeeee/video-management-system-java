# Video Management System (Java Web MVC)

Dự án Hệ thống Quản lý và Chia sẻ Video trực tuyến xây dựng trên nền tảng **Java Web (Jakarta EE 10, Servlet 6.1, JSP 4.0)** theo mô hình kiến trúc MVC 3 lớp, kết hợp giao diện Bootstrap hiện đại và bộ trang trí SiteMesh 3.

---

## 🚀 Tính năng nổi bật

### 1. Phân hệ Người dùng (User)
- **Xem & Khám phá Video**: Xem danh sách video theo danh mục, xem chi tiết video, tăng lượt xem.
- **Tương tác**: Yêu thích (Favorites), chia sẻ video qua email (Shares).
- **Xác thực an toàn (Authentication)**:
  - Đăng ký tài khoản gửi mã OTP tự động qua Gmail (sử dụng **Jakarta Angus Mail**).
  - Xác thực OTP kích hoạt tài khoản.
  - Đăng nhập, Ghi nhớ đăng nhập (Remember Me) bằng Cookie và Session.
- **Thương mại điện tử & Đặt hàng (Đang phát triển)**:
  - Giỏ hàng: Thêm, xóa, cập nhật số lượng giới hạn theo tồn kho.
  - Thanh toán đơn hàng phương thức COD (Ship COD).
  - Tra cứu lịch sử đơn hàng với bộ lọc 8 trạng thái.

### 2. Phân hệ Quản trị (Admin)
- **Admin Dashboard**: Thống kê số lượng video, danh mục, người dùng, lượt tương tác.
- **Quản lý Người dùng**: Xem danh sách, thêm, sửa thông tin, phân quyền Admin, khóa/mở kích hoạt tài khoản.
- **Quản trị nội dung**: Quản lý Video và Danh mục.

---

## 🛠️ Công nghệ sử dụng (Tech Stack)

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

## 📂 Cấu trúc thư mục

```text
├── database/
│   ├── create_database.sql       # Script khởi tạo cơ sở dữ liệu WebDe04
│   └── insert_records.sql        # Dữ liệu mẫu (Users, Categories, Videos...)
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

## ⚙️ Hướng dẫn cài đặt & Khởi chạy

### 1. Chuẩn bị môi trường
- Cài đặt **JDK 21**
- Cài đặt **Apache Tomcat 10.1** (hỗ trợ Jakarta EE 10 / Servlet 6.0+)
- Cài đặt **Microsoft SQL Server**

### 2. Thiết lập Cơ sở dữ liệu
1. Mở **SQL Server Management Studio (SSMS)**.
2. Mở và thực thi file `database/create_database.sql` để tạo CSDL `WebDe04`.
3. Mở và thực thi file `database/insert_records.sql` để nạp dữ liệu mẫu ban đầu.

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

---

## 👥 Tài khoản mặc định

| Vai trò | Tên đăng nhập | Mật khẩu | Ghi chú |
| :--- | :--- | :--- | :--- |
| **Admin** | `admin` | `123456` | Toàn quyền quản trị |
| **Admin** | `thainguyen` | `123456` | Quản trị viên |
| **User** | `user01` | `123456` | Người dùng đã kích hoạt |
| **User** | `user02` | `123456` | Người dùng đã kích hoạt |
