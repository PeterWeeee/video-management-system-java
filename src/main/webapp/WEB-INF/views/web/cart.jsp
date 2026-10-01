<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ Hàng - WebDe04</title>
</head>
<body class="bg-light">
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container my-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-house"></i> Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/videos/category">Sản phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">Giỏ hàng</li>
            </ol>
        </nav>

        <h2 class="fw-bold mb-4 text-dark">
            <i class="fa-solid fa-cart-shopping text-primary me-2"></i> Giỏ Hàng Của Bạn
        </h2>

        <!-- Thông báo Flash Messages -->
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i> ${param.msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i> ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:choose>
            <%-- GIỎ HÀNG TRỐNG --%>
            <c:when test="${empty cartItems or cartItems.size() == 0}">
                <div class="card shadow-sm border-0 text-center py-5">
                    <div class="card-body">
                        <i class="fa-solid fa-cart-arrow-down text-muted" style="font-size: 5rem;"></i>
                        <h4 class="mt-4 fw-bold text-secondary">Giỏ hàng của bạn đang trống!</h4>
                        <p class="text-muted">Hãy khám phá các video bài giảng và khóa học chất lượng để thêm vào giỏ.</p>
                        <a href="${pageContext.request.contextPath}/videos/category" class="btn btn-primary px-4 py-2 mt-2">
                            <i class="fa-solid fa-bag-shopping me-2"></i> Xem danh sách sản phẩm
                        </a>
                    </div>
                </div>
            </c:when>

            <%-- CÓ SẢN PHẨM TRONG GIỎ --%>
            <c:otherwise>
                <div class="row g-4">
                    <!-- Danh sách sản phẩm -->
                    <div class="col-lg-8">
                        <div class="card shadow-sm border-0">
                            <div class="card-header bg-white py-3">
                                <h5 class="mb-0 fw-bold text-dark">
                                    Danh sách sản phẩm (<span class="text-primary">${sessionScope.cartTotalItems}</span>)
                                </h5>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th style="min-width: 250px;">Sản phẩm</th>
                                                <th class="text-center" style="width: 130px;">Đơn giá</th>
                                                <th class="text-center" style="width: 170px;">Số lượng</th>
                                                <th class="text-center" style="width: 140px;">Thành tiền</th>
                                                <th class="text-center" style="width: 60px;"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${cartItems}" var="item">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <img src="${item.poster}" alt="${item.title}" class="rounded shadow-sm me-3" style="width: 75px; height: 50px; object-fit: cover;" onerror="this.src='https://placehold.co/100x65?text=Video'">
                                                            <div>
                                                                <a href="${pageContext.request.contextPath}/video/detail?id=${item.videoId}" class="fw-bold text-decoration-none text-dark d-block">
                                                                    ${item.title}
                                                                </a>
                                                                <small class="text-muted">Mã: <span class="badge bg-secondary">${item.videoId}</span></small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-center fw-semibold text-primary">
                                                        ${item.formattedPrice}
                                                    </td>
                                                    <td class="text-center">
                                                        <!-- Bộ điều khiển số lượng -->
                                                        <div class="d-flex align-items-center justify-content-center">
                                                            <!-- Nút giảm -->
                                                            <a href="${pageContext.request.contextPath}/cart?action=update&videoId=${item.videoId}&quantity=${item.quantity - 1}" 
                                                               class="btn btn-outline-secondary btn-sm ${item.quantity <= 1 ? 'disabled' : ''}">
                                                                <i class="fa-solid fa-minus"></i>
                                                            </a>
                                                            <!-- Ô nhập số lượng trực tiếp -->
                                                            <form action="${pageContext.request.contextPath}/cart" method="get" class="d-inline-block mx-1" style="width: 65px;">
                                                                <input type="hidden" name="action" value="update">
                                                                <input type="hidden" name="videoId" value="${item.videoId}">
                                                                <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.stock}" 
                                                                       class="form-control form-control-sm text-center fw-bold"
                                                                       onchange="this.form.submit()">
                                                            </form>
                                                            <!-- Nút tăng (bị disabled nếu chạm giới hạn tồn kho) -->
                                                            <a href="${pageContext.request.contextPath}/cart?action=update&videoId=${item.videoId}&quantity=${item.quantity + 1}" 
                                                               class="btn btn-outline-secondary btn-sm ${item.quantity >= item.stock ? 'disabled' : ''}">
                                                                <i class="fa-solid fa-plus"></i>
                                                            </a>
                                                        </div>
                                                        <!-- Giới hạn tồn kho -->
                                                        <div class="mt-1">
                                                            <c:choose>
                                                                <c:when test="${item.quantity >= item.stock}">
                                                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle" style="font-size: 0.72rem;">
                                                                        <i class="fa-solid fa-triangle-exclamation"></i> Đạt tối đa (${item.stock})
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <small class="text-muted" style="font-size: 0.75rem;">
                                                                        Còn trong kho: <strong>${item.stock}</strong>
                                                                    </small>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </td>
                                                    <td class="text-center fw-bold text-success">
                                                        ${item.formattedTotalPrice}
                                                    </td>
                                                    <td class="text-center">
                                                        <a href="${pageContext.request.contextPath}/cart?action=remove&videoId=${item.videoId}" 
                                                           class="btn btn-sm btn-outline-danger" 
                                                           title="Xóa khỏi giỏ"
                                                           onclick="return confirm('Bạn muốn xóa sản phẩm này khỏi giỏ hàng?');">
                                                            <i class="fa-solid fa-trash-can"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer bg-white py-3 d-flex justify-content-between align-items-center">
                                <a href="${pageContext.request.contextPath}/videos/category" class="btn btn-outline-secondary">
                                    <i class="fa-solid fa-arrow-left me-1"></i> Tiếp tục mua hàng
                                </a>
                                <a href="${pageContext.request.contextPath}/cart?action=clear" 
                                   class="btn btn-outline-danger btn-sm"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa toàn bộ giỏ hàng?');">
                                    <i class="fa-solid fa-trash-arrow-up me-1"></i> Xóa tất cả
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Tổng kết & Nút thanh toán -->
                    <div class="col-lg-4">
                        <div class="card shadow-sm border-0 sticky-top" style="top: 80px;">
                            <div class="card-header bg-white py-3">
                                <h5 class="mb-0 fw-bold text-dark">
                                    <i class="fa-solid fa-receipt text-primary me-2"></i> Tóm Tắt Đơn Hàng
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Tổng số lượng:</span>
                                    <span class="fw-bold">${sessionScope.cartTotalItems} sản phẩm</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Tạm tính:</span>
                                    <span class="fw-bold">${formattedTotalAmount}</span>
                                </div>
                                <div class="d-flex justify-content-between mb-3">
                                    <span class="text-muted">Phí giao hàng:</span>
                                    <span class="text-success fw-bold">Miễn phí (COD)</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <span class="fs-5 fw-bold text-dark">Tổng cộng:</span>
                                    <span class="fs-4 fw-bold text-danger">${formattedTotalAmount}</span>
                                </div>

                                <!-- Nút chuyển sang trang thanh toán COD -->
                                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success btn-lg w-100 py-3 fw-bold shadow-sm">
                                    <i class="fa-solid fa-truck-fast me-2"></i> ĐẶT HÀNG THANH TOÁN COD
                                </a>
                                <p class="text-muted text-center small mt-2 mb-0">
                                    <i class="fa-solid fa-shield-halved text-success"></i> Nhận hàng kiểm tra rồi mới thanh toán tiền mặt.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
