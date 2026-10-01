<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${currentCategory.categoryname} (${totalVideos}) - Danh sách Video</title>
    <style>
        .category-header-title {
            background-color: #fffa65;
            padding: 8px 16px;
            font-size: 20px;
            font-weight: bold;
            border: 1px solid #d4c000;
            display: inline-block;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .video-grid-table {
            width: 100%;
            border-collapse: collapse;
            border: 2px solid #333;
            background: #fff;
        }
        .video-grid-table td {
            border: 2px solid #333;
            padding: 15px;
            vertical-align: top;
            width: 33.333%;
        }
        .video-item-poster {
            width: 100%;
            height: 160px;
            object-fit: cover;
            border: 1px solid #ccc;
            margin-bottom: 12px;
        }
        .video-info-line {
            margin-bottom: 6px;
            font-size: 15px;
        }
        .pagination-container {
            margin-top: 25px;
            text-align: center;
        }
        .pagination-custom {
            display: inline-flex;
            gap: 6px;
            align-items: center;
        }
        .pagination-custom a, .pagination-custom span {
            padding: 6px 12px;
            text-decoration: none;
            border: 1px solid #333;
            color: #333;
            font-weight: bold;
            background: #fff;
        }
        .pagination-custom .active {
            background: #0d6efd;
            color: #fff;
            border-color: #0d6efd;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container my-4">
        <!-- Chuyển đổi Danh mục Category -->
        <div class="mb-4">
            <span class="fw-bold me-2"><i class="fa-solid fa-filter"></i> Chọn danh mục:</span>
            <div class="btn-group flex-wrap" role="group">
                <c:forEach items="${categories}" var="c">
                    <a href="${pageContext.request.contextPath}/videos/category?id=${c.categoryId}" 
                       class="btn btn-sm ${c.categoryId == currentCategory.categoryId ? 'btn-primary' : 'btn-outline-primary'}">
                        ${c.categoryname}
                    </a>
                </c:forEach>
            </div>
        </div>

        <!-- Tiêu đề Category Name (Số lượng) -->
        <div>
            <div class="category-header-title shadow-sm">
                ${currentCategory.categoryname} (${totalVideos})
            </div>
        </div>

        <!-- Bảng hiển thị 3 video / trang -->
        <c:choose>
            <c:when test="${not empty videoList}">
                <table class="video-grid-table shadow-sm">
                    <tbody>
                        <tr>
                            <c:forEach items="${videoList}" var="v">
                                <td>
                                    <!-- [poster] -->
                                    <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}">
                                        <img src="${v.poster}" alt="[poster] ${v.title}" class="video-item-poster">
                                    </a>

                                    <!-- Thông tin chi tiết theo mẫu đề -->
                                    <div class="video-info-line">
                                        <strong>Tiêu đề:</strong> 
                                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="text-decoration-none text-dark fw-bold">
                                            ${v.title}
                                        </a>
                                    </div>
                                    <div class="video-info-line">
                                        <strong>Mã video:</strong> ${v.videoId}
                                    </div>
                                    <div class="video-info-line">
                                        <strong>Category name:</strong> ${v.categoryName != null ? v.categoryName : currentCategory.categoryname}
                                    </div>
                                    <div class="video-info-line">
                                        <strong>View:</strong> ${v.views}
                                    </div>
                                    <div class="video-info-line">
                                        <span class="badge bg-success">Share(${v.shareCount})</span>
                                    </div>
                                    <div class="video-info-line">
                                        <span class="badge bg-primary">Like(${v.likeCount})</span>
                                    </div>
                                    <div class="mt-2 text-end">
                                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="btn btn-sm btn-outline-info">
                                            Xem chi tiết &raquo;
                                        </a>
                                    </div>
                                </td>
                            </c:forEach>

                            <!-- Bù ô trống nếu số video < 3 để giữ bảng 3 cột -->
                            <c:if test="${videoList.size() < 3}">
                                <c:forEach begin="1" end="${3 - videoList.size()}">
                                    <td class="bg-light text-center text-muted" style="vertical-align: middle;">
                                        <em>(Trống)</em>
                                    </td>
                                </c:forEach>
                            </c:if>
                        </tr>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning">
                    Chưa có video nào trong danh mục <strong>${currentCategory.categoryname}</strong>.
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Phân trang: << 1 2 3 4 5 >> -->
        <div class="pagination-container">
            <div class="pagination-custom">
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/videos/category?id=${currentCategory.categoryId}&page=${currentPage - 1}">&lt;&lt;</a>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="active">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/videos/category?id=${currentCategory.categoryId}&page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/videos/category?id=${currentCategory.categoryId}&page=${currentPage + 1}">&gt;&gt;</a>
                </c:if>
            </div>
            <div class="mt-2 text-muted small">
                Trang ${currentPage} / ${totalPages} (Tổng số ${totalVideos} video - 3 video/trang)
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
