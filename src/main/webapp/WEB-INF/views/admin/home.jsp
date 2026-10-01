<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bảng Điều Khiển Quản Trị</title>
</head>
<body class="bg-light">
    <!-- Admin Header -->
    <jsp:include page="/WEB-INF/views/common/admin-header.jsp" />

    <div class="container-fluid px-4">
        <div class="row mb-4">
            <div class="col-12">
                <h3 class="fw-bold text-dark">
                    <i class="fa-solid fa-gauge-high text-primary"></i> Tổng Quan Hệ Thống Quản Trị
                </h3>
                <p class="text-muted">Chào mừng Quản trị viên! Hệ thống đang hoạt động ổn định.</p>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm bg-primary text-white">
                    <div class="card-body p-4 d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase fw-semibold mb-2">Tổng số Users</h6>
                            <h2 class="display-6 fw-bold mb-0">${totalUsers}</h2>
                        </div>
                        <i class="fa-solid fa-users fa-3x opacity-50"></i>
                    </div>
                    <div class="card-footer bg-transparent border-0 pt-0">
                        <a href="${pageContext.request.contextPath}/admin/users" class="text-white text-decoration-none small">
                            Quản lý Users &raquo;
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-0 shadow-sm bg-success text-white">
                    <div class="card-body p-4 d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase fw-semibold mb-2">Tổng số Videos</h6>
                            <h2 class="display-6 fw-bold mb-0">${totalVideos}</h2>
                        </div>
                        <i class="fa-solid fa-video fa-3x opacity-50"></i>
                    </div>
                    <div class="card-footer bg-transparent border-0 pt-0">
                        <a href="${pageContext.request.contextPath}/videos/category" target="_blank" class="text-white text-decoration-none small">
                            Xem trang Video &raquo;
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-0 shadow-sm bg-warning text-dark">
                    <div class="card-body p-4 d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase fw-semibold mb-2">Tổng Danh Mục</h6>
                            <h2 class="display-6 fw-bold mb-0">${totalCategories}</h2>
                        </div>
                        <i class="fa-solid fa-folder-tree fa-3x opacity-50"></i>
                    </div>
                    <div class="card-footer bg-transparent border-0 pt-0">
                        <span class="small text-dark">Hệ thống phân mục chuyên đề</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick action links -->
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white py-3">
                <h5 class="fw-bold mb-0 text-dark"><i class="fa-solid fa-bolt"></i> Thao Tác Nhanh</h5>
            </div>
            <div class="card-body">
                <div class="d-flex gap-3 flex-wrap">
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-primary">
                        <i class="fa-solid fa-users-gear"></i> Quản lý Users
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/user/create" class="btn btn-outline-success">
                        <i class="fa-solid fa-user-plus"></i> Thêm User Mới
                    </a>
                    <a href="${pageContext.request.contextPath}/home" target="_blank" class="btn btn-outline-secondary">
                        <i class="fa-solid fa-globe"></i> Xem Giao Diện Khách
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Admin Footer -->
    <jsp:include page="/WEB-INF/views/common/admin-footer.jsp" />
</body>
</html>
