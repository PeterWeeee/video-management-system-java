<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt Hàng Thành Công - WebDe04</title>
</head>
<body class="bg-light">
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow border-0 text-center p-4">
                    <div class="card-body">
                        <div class="mb-3">
                            <i class="fa-solid fa-circle-check text-success" style="font-size: 4.5rem;"></i>
                        </div>
                        <h3 class="fw-bold text-success mb-2">ĐẶT HÀNG THÀNH CÔNG!</h3>
                        <p class="text-muted mb-4">
                            Cảm ơn bạn đã tin tưởng. Đơn hàng của bạn đã được tiếp nhận và đang ở trạng thái 
                            <span class="badge bg-primary">Đơn hàng mới</span>.
                        </p>

                        <!-- Khung chi tiết đơn hàng -->
                        <div class="text-start bg-light p-4 rounded-3 border mb-4">
                            <h6 class="fw-bold border-bottom pb-2 mb-3 text-dark">
                                <i class="fa-solid fa-receipt text-primary me-2"></i> Thông Tin Đơn Hàng
                            </h6>
                            <div class="row mb-2">
                                <span class="col-5 text-muted">Mã đơn hàng:</span>
                                <span class="col-7 fw-bold text-primary">#ORD-${order.orderId}</span>
                            </div>
                            <div class="row mb-2">
                                <span class="col-5 text-muted">Ngày đặt:</span>
                                <span class="col-7">${order.formattedOrderDate}</span>
                            </div>
                            <div class="row mb-2">
                                <span class="col-5 text-muted">Người nhận:</span>
                                <span class="col-7 fw-bold">${order.receiverName} (${order.receiverPhone})</span>
                            </div>
                            <div class="row mb-2">
                                <span class="col-5 text-muted">Địa chỉ nhận:</span>
                                <span class="col-7">${order.receiverAddress}</span>
                            </div>
                            <div class="row mb-2">
                                <span class="col-5 text-muted">Thanh toán:</span>
                                <span class="col-7 text-success fw-bold">
                                    <i class="fa-solid fa-hand-holding-dollar me-1"></i> Tiền mặt khi nhận hàng (COD)
                                </span>
                            </div>
                            <div class="row mb-2">
                                <span class="col-5 text-muted">Trạng thái:</span>
                                <span class="col-7">
                                    <span class="badge ${order.statusBadgeClass}">${order.status}</span>
                                </span>
                            </div>
                            <hr class="my-2">
                            <div class="row pt-1">
                                <span class="col-5 fw-bold fs-6 text-dark">Tổng tiền COD:</span>
                                <span class="col-7 fw-bold fs-5 text-danger">${order.formattedTotalAmount}</span>
                            </div>
                        </div>

                        <!-- Các nút điều hướng -->
                        <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                            <a href="${pageContext.request.contextPath}/order-history" class="btn btn-primary px-4 py-2">
                                <i class="fa-solid fa-clock-rotate-left me-1"></i> Xem lịch sử đơn hàng
                            </a>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary px-4 py-2">
                                <i class="fa-solid fa-house me-1"></i> Về trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
