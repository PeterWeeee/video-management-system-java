<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Video Portal</title>
</head>
<body class="bg-light">
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">
        <!-- Hero Banner (Căn giữa tiêu đề và bỏ các nút theo yêu cầu) -->
        <div class="p-5 mb-4 bg-white rounded-3 shadow-sm border text-center">
            <div class="container-fluid py-2">
                <h1 class="display-6 fw-bold text-primary mb-3">Hệ Thống Video & Khóa Học Trực Tuyến</h1>
            </div>
        </div>

        <!-- Categories Section -->
        <div class="mb-5">
            <h3 class="fw-bold mb-3 border-bottom pb-2 text-dark">
                <i class="fa-solid fa-layer-group text-primary"></i> Danh Mục Chuyên Đề
            </h3>
            <div class="row g-3">
                <c:forEach items="${categoryCounts}" var="cat">
                    <div class="col-md-3 col-sm-6">
                        <div class="card h-100 shadow-sm border-0 bg-white">
                            <div class="card-body text-center">
                                <i class="fa-solid fa-folder-open fa-2x text-warning mb-2"></i>
                                <h5 class="card-title fw-bold">${cat.categoryname}</h5>
                                <span class="badge bg-primary rounded-pill mb-2">
                                    ${cat.videoCount} video(s)
                                </span>
                                <div class="mt-2">
                                    <a href="${pageContext.request.contextPath}/videos/category?id=${cat.categoryId}" class="btn btn-outline-primary btn-sm">
                                        Xem video &raquo;
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Featured Videos Section -->
        <div>
            <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                <h3 class="fw-bold text-dark mb-0">
                    <i class="fa-solid fa-fire text-danger"></i> Video Nổi Bật Mới Nhất
                </h3>
                <a href="${pageContext.request.contextPath}/videos/category" class="text-decoration-none">
                    Xem tất cả <i class="fa-solid fa-chevron-right"></i>
                </a>
            </div>

            <div class="row g-4">
                <c:forEach items="${featuredVideos}" var="v">
                    <div class="col-md-4 col-sm-6">
                        <div class="card h-100 shadow-sm border-0">
                            <img src="${v.poster}" class="card-img-top" alt="${v.title}" style="height: 180px; object-fit: cover;">
                            <div class="card-body d-flex flex-column justify-content-between">
                                <div>
                                    <span class="badge bg-secondary mb-2">${v.categoryName}</span>
                                    <h6 class="card-title fw-bold">
                                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="text-dark text-decoration-none">
                                            ${v.title}
                                        </a>
                                    </h6>
                                    <p class="card-text text-muted small" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                        ${v.description}
                                    </p>
                                </div>
                                <div class="d-flex justify-content-between align-items-center my-2 pt-2 border-top">
                                    <span class="fw-bold text-danger">${v.formattedPrice}</span>
                                    <c:choose>
                                        <c:when test="${v.stock > 0}">
                                            <span class="badge bg-success-subtle text-success border border-success-subtle">Còn ${v.stock} suất</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger-subtle text-danger">Hết hàng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="d-flex justify-content-between align-items-center text-muted small">
                                    <span><i class="fa-solid fa-eye"></i> ${v.views} views</span>
                                    <span><i class="fa-solid fa-thumbs-up text-primary"></i> ${v.likeCount}</span>
                                    <span><i class="fa-solid fa-share text-success"></i> ${v.shareCount}</span>
                                </div>
                            </div>
                            <div class="card-footer bg-transparent border-0 pt-0 pb-3 d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="btn btn-sm btn-outline-secondary w-50">
                                    <i class="fa-solid fa-circle-info"></i> Chi tiết
                                </a>
                                <c:choose>
                                    <c:when test="${v.stock > 0}">
                                        <a href="${pageContext.request.contextPath}/cart?action=add&videoId=${v.videoId}" class="btn btn-sm btn-primary w-50">
                                            <i class="fa-solid fa-cart-plus"></i> Mua ngay
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-sm btn-secondary w-50" disabled>Hết hàng</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
