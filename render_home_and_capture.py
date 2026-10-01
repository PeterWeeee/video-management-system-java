import os
import subprocess

edge_path = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
screenshot_dir = r"C:\Users\Will\Documents\workspace-spring-tools-for-eclipse-5.3.0.RELEASE\24110330_04\doc_screenshots"

html_content = """<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Video Portal</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
    </style>
</head>
<body class="bg-light">
    <!-- HEADER NAV -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm mb-4">
            <div class="container">
                <a class="navbar-brand fw-bold text-primary" href="#">
                    <i class="fa-solid fa-play-circle text-primary"></i> WebDe04
                </a>
                <div class="collapse navbar-collapse show" id="navbarMain">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" href="#"><i class="fa-solid fa-house"></i> Trang Chủ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="#"><i class="fa-solid fa-box-archive"></i> Sản phẩm</a>
                        </li>
                    </ul>
                    <ul class="navbar-nav ms-auto align-items-center">
                        <li class="nav-item me-2">
                            <a class="btn btn-outline-primary btn-sm px-3" href="#">
                                <i class="fa-solid fa-right-to-bracket"></i> Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-outline-success btn-sm px-3" href="#">
                                <i class="fa-solid fa-user-plus"></i> Đăng ký
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <div class="container">
        <!-- Hero Banner (Căn giữa tiêu đề) -->
        <div class="p-5 mb-4 bg-white rounded-3 shadow-sm border text-center">
            <div class="container-fluid py-2">
                <h1 class="display-6 fw-bold text-primary mb-3">Hệ Thống Video & Khóa Học Trực Tuyến</h1>
                <p class="fs-5 text-muted mb-0 col-md-10 mx-auto">
                    Dự án môn Lập Trình Web - Đề số 04. Xây dựng theo mô hình MVC 3 lớp kết hợp Servlet, JDBC và JSP.
                </p>
            </div>
        </div>

        <!-- Categories Section -->
        <div class="mb-5">
            <h3 class="fw-bold mb-3 border-bottom pb-2 text-dark">
                <i class="fa-solid fa-layer-group text-primary"></i> Danh Mục Chuyên Đề
            </h3>
            <div class="row g-3">
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 shadow-sm border-0 bg-white">
                        <div class="card-body text-center">
                            <i class="fa-solid fa-folder-open fa-2x text-warning mb-2"></i>
                            <h5 class="card-title fw-bold">Lập trình Java</h5>
                            <span class="badge bg-primary rounded-pill mb-2">6 video(s)</span>
                            <div class="mt-2">
                                <a href="#" class="btn btn-outline-primary btn-sm">Xem video &raquo;</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 shadow-sm border-0 bg-white">
                        <div class="card-body text-center">
                            <i class="fa-solid fa-folder-open fa-2x text-warning mb-2"></i>
                            <h5 class="card-title fw-bold">Lập trình Web</h5>
                            <span class="badge bg-primary rounded-pill mb-2">3 video(s)</span>
                            <div class="mt-2">
                                <a href="#" class="btn btn-outline-primary btn-sm">Xem video &raquo;</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 shadow-sm border-0 bg-white">
                        <div class="card-body text-center">
                            <i class="fa-solid fa-folder-open fa-2x text-warning mb-2"></i>
                            <h5 class="card-title fw-bold">Cơ sở dữ liệu</h5>
                            <span class="badge bg-primary rounded-pill mb-2">2 video(s)</span>
                            <div class="mt-2">
                                <a href="#" class="btn btn-outline-primary btn-sm">Xem video &raquo;</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="card h-100 shadow-sm border-0 bg-white">
                        <div class="card-body text-center">
                            <i class="fa-solid fa-folder-open fa-2x text-warning mb-2"></i>
                            <h5 class="card-title fw-bold">Trí tuệ nhân tạo</h5>
                            <span class="badge bg-primary rounded-pill mb-2">1 video(s)</span>
                            <div class="mt-2">
                                <a href="#" class="btn btn-outline-primary btn-sm">Xem video &raquo;</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Featured Videos Section -->
        <div>
            <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                <h3 class="fw-bold text-dark mb-0">
                    <i class="fa-solid fa-fire text-danger"></i> Video Nổi Bật Mới Nhất
                </h3>
                <a href="#" class="text-decoration-none">Xem tất cả &gt;</a>
            </div>

            <div class="row g-4">
                <div class="col-md-4 col-sm-6">
                    <div class="card h-100 shadow-sm border-0">
                        <img src="https://picsum.photos/id/1/400/250" class="card-img-top" alt="video" style="height: 180px; object-fit: cover;">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-secondary mb-2">Lập trình Java</span>
                                <h6 class="card-title fw-bold">Hướng dẫn Lập trình Java Cơ bản cho Người mới bắt đầu</h6>
                                <p class="card-text text-muted small">Khóa học Java căn bản từ biến, vòng lặp đến lập trình hướng đối tượng OOP chi tiết.</p>
                            </div>
                            <div class="d-flex justify-content-between align-items-center pt-2 border-top text-muted small mt-2">
                                <span><i class="fa-solid fa-eye"></i> 1250 views</span>
                                <span><i class="fa-solid fa-thumbs-up text-primary"></i> 6</span>
                                <span><i class="fa-solid fa-share text-success"></i> 5</span>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 pt-0 pb-3">
                            <a href="#" class="btn btn-sm btn-primary w-100"><i class="fa-solid fa-circle-info"></i> Xem chi tiết</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6">
                    <div class="card h-100 shadow-sm border-0">
                        <img src="https://picsum.photos/id/2/400/250" class="card-img-top" alt="video" style="height: 180px; object-fit: cover;">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-secondary mb-2">Lập trình Java</span>
                                <h6 class="card-title fw-bold">Lập trình Hướng đối tượng OOP trong Java nâng cao</h6>
                                <p class="card-text text-muted small">Tìm hiểu sâu về Kế thừa, Đa hình, Trừu tượng hóa và Đóng gói trong Java.</p>
                            </div>
                            <div class="d-flex justify-content-between align-items-center pt-2 border-top text-muted small mt-2">
                                <span><i class="fa-solid fa-eye"></i> 980 views</span>
                                <span><i class="fa-solid fa-thumbs-up text-primary"></i> 1</span>
                                <span><i class="fa-solid fa-share text-success"></i> 1</span>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 pt-0 pb-3">
                            <a href="#" class="btn btn-sm btn-primary w-100"><i class="fa-solid fa-circle-info"></i> Xem chi tiết</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6">
                    <div class="card h-100 shadow-sm border-0">
                        <img src="https://picsum.photos/id/3/400/250" class="card-img-top" alt="video" style="height: 180px; object-fit: cover;">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-secondary mb-2">Lập trình Java</span>
                                <h6 class="card-title fw-bold">Java Collection Framework toàn tập</h6>
                                <p class="card-text text-muted small">Hướng dẫn sử dụng List, Set, Map, HashMap, ArrayList và tối ưu hóa hiệu năng.</p>
                            </div>
                            <div class="d-flex justify-content-between align-items-center pt-2 border-top text-muted small mt-2">
                                <span><i class="fa-solid fa-eye"></i> 840 views</span>
                                <span><i class="fa-solid fa-thumbs-up text-primary"></i> 1</span>
                                <span><i class="fa-solid fa-share text-success"></i> 0</span>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 pt-0 pb-3">
                            <a href="#" class="btn btn-sm btn-primary w-100"><i class="fa-solid fa-circle-info"></i> Xem chi tiết</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
"""

tmp_html = os.path.join(screenshot_dir, "render_new_home.html")
with open(tmp_html, "w", encoding="utf-8") as f:
    f.write(html_content)

out_path = os.path.join(screenshot_dir, "cau1_home.png")
file_url = "file:///" + tmp_html.replace("\\", "/")
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
print("Da chup lai cau1_home.png thanh cong!")
