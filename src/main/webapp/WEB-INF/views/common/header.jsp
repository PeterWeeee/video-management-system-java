<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<!-- HEADER NAV -->
<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-play-circle text-primary"></i> WebDe04
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarMain">
                <!-- Menu điều hướng chính bên trái -->
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fa-solid fa-house"></i> Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/videos/category">
                            <i class="fa-solid fa-box-archive"></i> Sản phẩm
                        </a>
                    </li>
                    <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.admin == true}">
                        <li class="nav-item">
                            <a class="nav-link text-warning fw-bold" href="${pageContext.request.contextPath}/admin/home">
                                <i class="fa-solid fa-user-shield"></i> Trang quản trị
                            </a>
                        </li>
                    </c:if>
                </ul>

                <!-- Khu vực đăng nhập / đăng ký góc phải -->
                <ul class="navbar-nav ms-auto align-items-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.currentUser}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle text-light" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fa-solid fa-circle-user"></i> Xin chào, <strong>${sessionScope.currentUser.fullname != null ? sessionScope.currentUser.fullname : sessionScope.currentUser.username}</strong>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <c:if test="${sessionScope.currentUser.admin == true}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/home"><i class="fa-solid fa-gear"></i> Quản trị hệ thống</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <!-- Nút Đăng nhập viền xanh dương -->
                            <li class="nav-item me-2">
                                <a class="btn btn-outline-primary btn-sm px-3" href="${pageContext.request.contextPath}/login">
                                    <i class="fa-solid fa-right-to-bracket"></i> Đăng nhập
                                </a>
                            </li>
                            <!-- Nút Đăng ký viền xanh lá -->
                            <li class="nav-item">
                                <a class="btn btn-outline-success btn-sm px-3" href="${pageContext.request.contextPath}/register">
                                    <i class="fa-solid fa-user-plus"></i> Đăng ký
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
</header>
