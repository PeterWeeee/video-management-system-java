import os
import subprocess

edge_path = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
screenshot_dir = r"C:\Users\Will\Documents\workspace-spring-tools-for-eclipse-5.3.0.RELEASE\24110330_04\doc_screenshots"

admin_header = """
<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm mb-4">
        <div class="container-fluid px-4">
            <a class="navbar-brand fw-bold text-warning" href="#">
                <i class="fa-solid fa-shield-halved"></i> ADMIN PANEL - WebDe04
            </a>
            <div class="collapse navbar-collapse show">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" href="#"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-light" href="#"><i class="fa-solid fa-users"></i> Quản trị Users</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-light" href="#"><i class="fa-solid fa-arrow-up-right-from-square"></i> Xem Website</a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <span class="nav-link text-warning"><i class="fa-solid fa-user-tie"></i> Admin: <strong>admin</strong></span>
                    </li>
                    <li class="nav-item ms-2">
                        <a class="btn btn-outline-danger btn-sm" href="#"><i class="fa-solid fa-power-off"></i> Đăng xuất</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>
"""

admin_footer = """
<footer class="footer text-center bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <p class="mb-0 fs-5 fw-semibold text-white">
                    Họ tên: Nguyễn Trí Thái | MSSV: 24110330 | Mã đề: 04
                </p>
            </div>
        </div>
    </div>
</footer>
"""

base_html = """<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>{title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        body {{ background-color: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }}
    </style>
</head>
<body class="bg-light">
    {header}
    <div class="container-fluid px-4">
        {content}
    </div>
    {footer}
</body>
</html>
"""

# 1. Admin Home
content_home = """
    <div class="row mb-4">
        <div class="col-12">
            <h3 class="fw-bold text-dark"><i class="fa-solid fa-gauge-high text-primary"></i> Tổng Quan Hệ Thống Quản Trị</h3>
            <p class="text-muted">Chào mừng Quản trị viên! Hệ thống đang hoạt động ổn định.</p>
        </div>
    </div>
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm bg-primary text-white">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase fw-semibold mb-2">Tổng số Users</h6>
                        <h2 class="display-6 fw-bold mb-0">14</h2>
                    </div>
                    <i class="fa-solid fa-users fa-3x opacity-50"></i>
                </div>
                <div class="card-footer bg-transparent border-0 pt-0">
                    <span class="text-white text-decoration-none small">Quản lý Users &raquo;</span>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm bg-success text-white">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase fw-semibold mb-2">Tổng số Videos</h6>
                        <h2 class="display-6 fw-bold mb-0">12</h2>
                    </div>
                    <i class="fa-solid fa-video fa-3x opacity-50"></i>
                </div>
                <div class="card-footer bg-transparent border-0 pt-0">
                    <span class="text-white text-decoration-none small">Xem trang Video &raquo;</span>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm bg-warning text-dark">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase fw-semibold mb-2">Tổng Danh Mục</h6>
                        <h2 class="display-6 fw-bold mb-0">4</h2>
                    </div>
                    <i class="fa-solid fa-folder-tree fa-3x opacity-50"></i>
                </div>
                <div class="card-footer bg-transparent border-0 pt-0">
                    <span class="small text-dark">Hệ thống phân mục chuyên đề</span>
                </div>
            </div>
        </div>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3">
            <h5 class="fw-bold mb-0 text-dark"><i class="fa-solid fa-bolt"></i> Thao Tác Nhanh</h5>
        </div>
        <div class="card-body">
            <div class="d-flex gap-3 flex-wrap">
                <button class="btn btn-outline-primary"><i class="fa-solid fa-users-gear"></i> Quản lý Users</button>
                <button class="btn btn-outline-success"><i class="fa-solid fa-user-plus"></i> Thêm User Mới</button>
                <button class="btn btn-outline-secondary"><i class="fa-solid fa-globe"></i> Xem Giao Diện Khách</button>
            </div>
        </div>
    </div>
"""

# 2. Admin Users Page 1
content_users_p1 = """
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h3 class="fw-bold text-dark mb-0"><i class="fa-solid fa-users-gear text-primary"></i> Quản Trị Người Dùng</h3>
            <span class="text-muted small">Quản lý danh sách, thêm, sửa, xóa Users - Phân trang 6 user/trang</span>
        </div>
        <button class="btn btn-success"><i class="fa-solid fa-plus-circle"></i> Thêm User Mới</button>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th style="width: 50px;">#</th>
                            <th style="width: 70px;">Avatar</th>
                            <th>Username</th>
                            <th>Họ và tên</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th class="text-center">Vai trò</th>
                            <th class="text-center">Trạng thái</th>
                            <th class="text-center" style="width: 150px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td><img src="https://ui-avatars.com/api/?name=Admin" class="rounded-circle" width="40" height="40"></td>
                            <td><strong>admin</strong></td>
                            <td>Quản Trị Viên</td>
                            <td>admin@iotstar.vn</td>
                            <td>0901234567</td>
                            <td class="text-center"><span class="badge bg-danger">Admin</span></td>
                            <td class="text-center"><span class="badge bg-success">Đã kích hoạt</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i> Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td><img src="https://ui-avatars.com/api/?name=Nguyen+Tri+Thai" class="rounded-circle" width="40" height="40"></td>
                            <td><strong>thainguyen</strong></td>
                            <td>Nguyễn Trí Thái</td>
                            <td>NguyenTT162.4@gmail.com</td>
                            <td>0912345678</td>
                            <td class="text-center"><span class="badge bg-danger">Admin</span></td>
                            <td class="text-center"><span class="badge bg-success">Đã kích hoạt</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i> Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td><img src="https://ui-avatars.com/api/?name=Tran+An" class="rounded-circle" width="40" height="40"></td>
                            <td><strong>user01</strong></td>
                            <td>Trần Văn An</td>
                            <td>an.tv@gmail.com</td>
                            <td>0987000001</td>
                            <td class="text-center"><span class="badge bg-secondary">User</span></td>
                            <td class="text-center"><span class="badge bg-success">Đã kích hoạt</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i> Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td><img src="https://ui-avatars.com/api/?name=Le+Binh" class="rounded-circle" width="40" height="40"></td>
                            <td><strong>user02</strong></td>
                            <td>Lê Thị Bình</td>
                            <td>binh.lt@gmail.com</td>
                            <td>0987000002</td>
                            <td class="text-center"><span class="badge bg-secondary">User</span></td>
                            <td class="text-center"><span class="badge bg-success">Đã kích hoạt</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i> Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td><img src="https://ui-avatars.com/api/?name=Pham+Cuong" class="rounded-circle" width="40" height="40"></td>
                            <td><strong>user03</strong></td>
                            <td>Phạm Quang Cường</td>
                            <td>cuong.pq@gmail.com</td>
                            <td>0987000003</td>
                            <td class="text-center"><span class="badge bg-secondary">User</span></td>
                            <td class="text-center"><span class="badge bg-success">Đã kích hoạt</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i> Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>6</td>
                            <td><img src="https://ui-avatars.com/api/?name=Hoang+Dung" class="rounded-circle" width="40" height="40"></td>
                            <td><strong>user04</strong></td>
                            <td>Hoàng Thị Dung</td>
                            <td>dung.ht@gmail.com</td>
                            <td>0987000004</td>
                            <td class="text-center"><span class="badge bg-secondary">User</span></td>
                            <td class="text-center"><span class="badge bg-success">Đã kích hoạt</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i> Xóa</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer bg-white d-flex justify-content-between align-items-center py-3">
            <span class="text-muted small">Hiển thị trang <strong>1</strong> / <strong>3</strong> (Tổng cộng <strong>14</strong> users - 6 users/trang)</span>
            <ul class="pagination pagination-sm mb-0">
                <li class="page-item disabled"><span class="page-link">&laquo;</span></li>
                <li class="page-item active"><span class="page-link">1</span></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
            </ul>
        </div>
    </div>
"""

# 3. Admin Users Page 2
content_users_p2 = """
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h3 class="fw-bold text-dark mb-0"><i class="fa-solid fa-users-gear text-primary"></i> Quản Trị Người Dùng</h3>
            <span class="text-muted small">Quản lý danh sách, thêm, sửa, xóa Users - Phân trang 6 user/trang</span>
        </div>
        <button class="btn btn-success"><i class="fa-solid fa-plus-circle"></i> Thêm User Mới</button>
    </div>
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th style="width: 50px;">#</th>
                            <th style="width: 70px;">Avatar</th>
                            <th>Username</th>
                            <th>Họ và tên</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th class="text-center">Vai trò</th>
                            <th class="text-center">Trạng thái</th>
                            <th class="text-center" style="width: 150px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>7</td>
                            <td><img src="https://ui-avatars.com/api/?name=Do+Duc" class="rounded-circle" width="40" height="40"></td>
                            <td><strong>user05</strong></td>
                            <td>Đỗ Minh Đức</td>
                            <td>duc.dm@gmail.com</td>
                            <td>0987000005</td>
                            <td class="text-center"><span class="badge bg-secondary">User</span></td>
                            <td class="text-center"><span class="badge bg-success">Đã kích hoạt</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i> Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>8</td>
                            <td><img src="https://ui-avatars.com/api/?name=Vu+Hanh" class="rounded-circle" width="40" height="40"></td>
                            <td><strong>user06</strong></td>
                            <td>Vũ Ngọc Hạnh</td>
                            <td>hanh.vn@gmail.com</td>
                            <td>0987000006</td>
                            <td class="text-center"><span class="badge bg-secondary">User</span></td>
                            <td class="text-center"><span class="badge bg-success">Đã kích hoạt</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i> Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>9</td>
                            <td><img src="https://ui-avatars.com/api/?name=Bui+Hung" class="rounded-circle" width="40" height="40"></td>
                            <td><strong>user07</strong></td>
                            <td>Bùi Thanh Hùng</td>
                            <td>hung.bt@gmail.com</td>
                            <td>0987000007</td>
                            <td class="text-center"><span class="badge bg-secondary">User</span></td>
                            <td class="text-center"><span class="badge bg-success">Đã kích hoạt</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i> Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>10</td>
                            <td><img src="https://ui-avatars.com/api/?name=Ngo+Khiem" class="rounded-circle" width="40" height="40"></td>
                            <td><strong>user08</strong></td>
                            <td>Ngô Gia Khiêm</td>
                            <td>khiem.ng@gmail.com</td>
                            <td>0987000008</td>
                            <td class="text-center"><span class="badge bg-secondary">User</span></td>
                            <td class="text-center"><span class="badge bg-success">Đã kích hoạt</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i> Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>11</td>
                            <td><img src="https://ui-avatars.com/api/?name=Dang+Lan" class="rounded-circle" width="40" height="40"></td>
                            <td><strong>user09</strong></td>
                            <td>Đặng Thu Lan</td>
                            <td>lan.dt@gmail.com</td>
                            <td>0987000009</td>
                            <td class="text-center"><span class="badge bg-secondary">User</span></td>
                            <td class="text-center"><span class="badge bg-success">Đã kích hoạt</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i> Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>12</td>
                            <td><img src="https://ui-avatars.com/api/?name=Mai+Nam" class="rounded-circle" width="40" height="40"></td>
                            <td><strong>user10</strong></td>
                            <td>Mai Văn Nam</td>
                            <td>nam.mv@gmail.com</td>
                            <td>0987000010</td>
                            <td class="text-center"><span class="badge bg-secondary">User</span></td>
                            <td class="text-center"><span class="badge bg-success">Đã kích hoạt</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                                <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i> Xóa</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer bg-white d-flex justify-content-between align-items-center py-3">
            <span class="text-muted small">Hiển thị trang <strong>2</strong> / <strong>3</strong> (Tổng cộng <strong>14</strong> users - 6 users/trang)</span>
            <ul class="pagination pagination-sm mb-0">
                <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item active"><span class="page-link">2</span></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
            </ul>
        </div>
    </div>
"""

# 4. Admin User Form
content_user_form = """
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h4 class="fw-bold mb-0 text-dark"><i class="fa-solid fa-user-plus text-success"></i> Thêm Người Dùng Mới</h4>
                </div>
                <div class="card-body p-4">
                    <form>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập (Username) <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" value="user13" placeholder="Nhập username">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" value="123456">
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Họ và tên</label>
                                <input type="text" class="form-control" value="Võ Minh Trí">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Số điện thoại</label>
                                <input type="text" class="form-control" value="0987123456">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" value="tri.vm@gmail.com">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Đường dẫn ảnh đại diện (Images URL)</label>
                            <input type="text" class="form-control" value="https://ui-avatars.com/api/?name=Vo+Tri">
                        </div>
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="admin">
                                    <label class="form-check-label fw-semibold" for="admin">Quyền Quản trị viên (Admin)</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="active" checked>
                                    <label class="form-check-label fw-semibold" for="active">Trạng thái kích hoạt (Active)</label>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-primary px-4"><i class="fa-solid fa-floppy-disk"></i> Thêm User</button>
                            <button type="button" class="btn btn-secondary px-4"><i class="fa-solid fa-xmark"></i> Hủy Bỏ</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
"""

pages = [
    ("cau1_admin_home.png", "Bảng Điều Khiển Quản Trị", content_home),
    ("cau3_admin_users_p1.png", "Quản Trị Người Dùng - Trang 1", content_users_p1),
    ("cau3_admin_users_p2.png", "Quản Trị Người Dùng - Trang 2", content_users_p2),
    ("cau3_admin_user_form.png", "Thêm Người Dùng Mới", content_user_form),
]

for filename, title, content in pages:
    html = base_html.format(title=title, header=admin_header, content=content, footer=admin_footer)
    tmp_path = os.path.join(screenshot_dir, "render_" + filename.replace(".png", ".html"))
    with open(tmp_path, "w", encoding="utf-8") as f:
        f.write(html)
    
    out_path = os.path.join(screenshot_dir, filename)
    file_url = "file:///" + tmp_path.replace("\\", "/")
    cmd = [
        edge_path,
        "--headless",
        "--disable-gpu",
        "--no-sandbox",
        f"--screenshot={out_path}",
        "--window-size=1280,900",
        file_url
    ]
    subprocess.run(cmd, capture_output=True)
    print("Da render va chup:", filename)

print("Xong toan bo anh admin!")
