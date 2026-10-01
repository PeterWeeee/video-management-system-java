<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán Đơn Hàng (COD) - WebDe04</title>
</head>
<body class="bg-light">
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container my-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-house"></i> Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">Thanh toán COD</li>
            </ol>
        </nav>

        <h2 class="fw-bold mb-4 text-dark">
            <i class="fa-solid fa-credit-card text-success me-2"></i> Thanh Toán Đơn Hàng COD
        </h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/checkout" method="post">
            <div class="row g-4">
                <!-- Cột trái: Thông tin nhận hàng & Phương thức thanh toán -->
                <div class="col-lg-7">
                    <!-- Thông tin người nhận -->
                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold text-dark">
                                <i class="fa-solid fa-location-dot text-danger me-2"></i> 1. Thông Tin Nhận Hàng
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label for="receiverName" class="form-label fw-bold">Họ và tên người nhận <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="receiverName" name="receiverName" 
                                       value="${user.fullname != null ? user.fullname : ''}" required placeholder="VD: Nguyễn Văn A">
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="receiverPhone" class="form-label fw-bold">Số điện thoại liên hệ <span class="text-danger">*</span></label>
                                    <input type="tel" class="form-control" id="receiverPhone" name="receiverPhone" 
                                           value="${user.phone != null ? user.phone : ''}" required placeholder="VD: 0987654321">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Email tài khoản</label>
                                    <input type="email" class="form-control bg-light" value="${user.email}" readonly>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="receiverAddress" class="form-label fw-bold">Địa chỉ giao hàng chi tiết <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="receiverAddress" name="receiverAddress" rows="2" 
                                          required placeholder="VD: Số 01 Võ Văn Ngân, Phường Linh Chiểu, TP. Thủ Đức, TP. Hồ Chí Minh"></textarea>
                            </div>

                            <div class="mb-0">
                                <label for="notes" class="form-label fw-bold">Ghi chú cho shipper (Tùy chọn)</label>
                                <input type="text" class="form-control" id="notes" name="notes" placeholder="VD: Giao vào giờ hành chính, gọi trước 15 phút...">
                            </div>
                        </div>
                    </div>

                    <!-- Phương thức thanh toán COD -->
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold text-dark">
                                <i class="fa-solid fa-money-bill-wave text-success me-2"></i> 2. Phương Thức Thanh Toán
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="form-check p-3 border rounded bg-light d-flex align-items-center mb-2">
                                <input class="form-check-input ms-0 me-3" type="radio" name="paymentMethod" id="paymentCOD" value="COD" checked>
                                <label class="form-check-label w-100 cursor-pointer" for="paymentCOD">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <strong class="text-success"><i class="fa-solid fa-truck-ramp-box me-1"></i> Thanh toán khi nhận hàng (Ship COD)</strong>
                                            <div class="small text-muted mt-1">Khách hàng được kiểm tra hàng trước khi thanh toán tiền mặt cho shipper.</div>
                                        </div>
                                        <span class="badge bg-success">Mặc định</span>
                                    </div>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Cột phải: Tóm tắt đơn hàng & Nút Xác nhận -->
                <div class="col-lg-5">
                    <div class="card shadow-sm border-0 sticky-top" style="top: 80px;">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold text-dark">
                                <i class="fa-solid fa-box-open text-primary me-2"></i> Đơn Hàng Của Bạn
                            </h5>
                        </div>
                        <div class="card-body">
                            <!-- Danh sách món hàng tóm tắt -->
                            <div class="list-group list-group-flush mb-3" style="max-height: 280px; overflow-y: auto;">
                                <c:forEach items="${cartItems}" var="item">
                                    <div class="list-group-item px-0 d-flex justify-content-between align-items-center">
                                        <div class="d-flex align-items-center">
                                            <img src="${item.poster}" alt="${item.title}" class="rounded me-2" style="width: 50px; height: 35px; object-fit: cover;" onerror="this.src='https://placehold.co/80x50?text=Video'">
                                            <div>
                                                <h6 class="mb-0 fw-bold small text-truncate" style="max-width: 180px;">${item.title}</h6>
                                                <small class="text-muted">SL: x${item.quantity}</small>
                                            </div>
                                        </div>
                                        <span class="fw-semibold text-primary small">${item.formattedTotalPrice}</span>
                                    </div>
                                </c:forEach>
                            </div>

                            <hr>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Tạm tính:</span>
                                <span class="fw-bold">${formattedTotalAmount}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-muted">Phí vận chuyển COD:</span>
                                <span class="text-success fw-bold">Miễn phí 0 đ</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <span class="fs-5 fw-bold text-dark">Tổng thanh toán COD:</span>
                                <span class="fs-4 fw-bold text-danger">${formattedTotalAmount}</span>
                            </div>

                            <button type="submit" class="btn btn-success btn-lg w-100 py-3 fw-bold shadow">
                                <i class="fa-solid fa-check-circle me-2"></i> XÁC NHẬN ĐẶT HÀNG (COD)
                            </button>
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary w-100 mt-2">
                                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại giỏ hàng
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
