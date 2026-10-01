<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch Sử Đặt Hàng - WebDe04</title>
    <style>
        .nav-pills-custom .nav-link {
            border-radius: 20px;
            padding: 8px 16px;
            font-size: 0.9rem;
            font-weight: 500;
            color: #495057;
            background-color: #fff;
            border: 1px solid #dee2e6;
            margin-right: 8px;
            margin-bottom: 8px;
            transition: all 0.2s ease;
            white-space: nowrap;
        }
        .nav-pills-custom .nav-link:hover {
            background-color: #f1f3f5;
            color: #0d6efd;
        }
        .nav-pills-custom .nav-link.active {
            background-color: #0d6efd;
            color: #fff;
            border-color: #0d6efd;
            box-shadow: 0 2px 6px rgba(13, 110, 253, 0.3);
        }
        .order-card {
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }
        .order-card:hover {
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08) !important;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container my-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-house"></i> Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Lịch sử đặt hàng</li>
            </ol>
        </nav>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold text-dark mb-0">
                <i class="fa-solid fa-clock-rotate-left text-primary me-2"></i> Lịch Sử Đặt Hàng Của Bạn
            </h2>
            <a href="${pageContext.request.contextPath}/videos/category" class="btn btn-outline-primary btn-sm">
                <i class="fa-solid fa-cart-plus me-1"></i> Tiếp tục mua hàng
            </a>
        </div>

        <!-- Flash messages -->
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

        <!-- BỘ LỌC 8 TRẠNG THÁI ĐƠN HÀNG (Tab Navigation) -->
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body py-3">
                <div class="nav nav-pills nav-pills-custom d-flex flex-wrap align-items-center">
                    <!-- Tab Tất cả -->
                    <a class="nav-link ${currentStatus == 'all' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/order-history?status=all">
                        Tất cả <span class="badge ${currentStatus == 'all' ? 'bg-light text-primary' : 'bg-secondary'} ms-1">${countAll}</span>
                    </a>

                    <!-- 1. Đơn hàng mới -->
                    <a class="nav-link ${currentStatus == 'Đơn hàng mới' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/order-history?status=Đơn hàng mới">
                        <i class="fa-solid fa-sparkles text-primary"></i> Đơn hàng mới 
                        <span class="badge ${currentStatus == 'Đơn hàng mới' ? 'bg-light text-primary' : 'bg-primary'} ms-1">${countNew}</span>
                    </a>

                    <!-- 2. Đã xác nhận -->
                    <a class="nav-link ${currentStatus == 'Đã xác nhận' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/order-history?status=Đã xác nhận">
                        <i class="fa-solid fa-check text-info"></i> Đã xác nhận 
                        <span class="badge ${currentStatus == 'Đã xác nhận' ? 'bg-light text-dark' : 'bg-info text-dark'} ms-1">${countConfirmed}</span>
                    </a>

                    <!-- 3. Chuẩn bị hàng -->
                    <a class="nav-link ${currentStatus == 'Chuẩn bị hàng' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/order-history?status=Chuẩn bị hàng">
                        <i class="fa-solid fa-box-open text-warning"></i> Chuẩn bị hàng 
                        <span class="badge ${currentStatus == 'Chuẩn bị hàng' ? 'bg-light text-dark' : 'bg-warning text-dark'} ms-1">${countPreparing}</span>
                    </a>

                    <!-- 4. Vận chuyển -->
                    <a class="nav-link ${currentStatus == 'Vận chuyển' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/order-history?status=Vận chuyển">
                        <i class="fa-solid fa-dolly text-info"></i> Vận chuyển 
                        <span class="badge ${currentStatus == 'Vận chuyển' ? 'bg-light text-dark' : 'bg-dark'} ms-1">${countShipping}</span>
                    </a>

                    <!-- 5. Giao hàng -->
                    <a class="nav-link ${currentStatus == 'Giao hàng' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/order-history?status=Giao hàng">
                        <i class="fa-solid fa-truck-fast text-primary"></i> Giao hàng 
                        <span class="badge ${currentStatus == 'Giao hàng' ? 'bg-light text-dark' : 'bg-secondary'} ms-1">${countDelivering}</span>
                    </a>

                    <!-- 6. Đã giao -->
                    <a class="nav-link ${currentStatus == 'Đã giao' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/order-history?status=Đã giao">
                        <i class="fa-solid fa-circle-check text-success"></i> Đã giao 
                        <span class="badge ${currentStatus == 'Đã giao' ? 'bg-light text-success' : 'bg-success'} ms-1">${countDelivered}</span>
                    </a>

                    <!-- 7. Đơn hàng hủy -->
                    <a class="nav-link ${currentStatus == 'Đơn hàng hủy' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/order-history?status=Đơn hàng hủy">
                        <i class="fa-solid fa-ban text-danger"></i> Đơn hàng hủy 
                        <span class="badge ${currentStatus == 'Đơn hàng hủy' ? 'bg-light text-danger' : 'bg-danger'} ms-1">${countCancelled}</span>
                    </a>

                    <!-- 8. Đơn hàng hoàn -->
                    <a class="nav-link ${currentStatus == 'Đơn hàng hoàn' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/order-history?status=Đơn hàng hoàn">
                        <i class="fa-solid fa-rotate-left text-secondary"></i> Đơn hàng hoàn 
                        <span class="badge ${currentStatus == 'Đơn hàng hoàn' ? 'bg-light text-secondary' : 'bg-secondary'} ms-1">${countReturned}</span>
                    </a>
                </div>
            </div>
        </div>

        <!-- DANH SÁCH ĐƠN HÀNG -->
        <c:choose>
            <c:when test="${empty orders or orders.size() == 0}">
                <div class="card shadow-sm border-0 text-center py-5">
                    <div class="card-body">
                        <i class="fa-solid fa-clipboard-list text-muted" style="font-size: 4rem;"></i>
                        <h4 class="mt-3 fw-bold text-secondary">Không có đơn hàng nào ở trạng thái này!</h4>
                        <p class="text-muted">Bạn có thể chọn tab trạng thái khác hoặc đặt hàng ngay hôm nay.</p>
                        <a href="${pageContext.request.contextPath}/videos/category" class="btn btn-primary px-4 py-2 mt-2">
                            <i class="fa-solid fa-bag-shopping me-2"></i> Mua sắm ngay
                        </a>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <div class="d-flex flex-column gap-3">
                    <c:forEach items="${orders}" var="ord">
                        <div class="card order-card shadow-sm border-0">
                            <!-- Card Header: Mã đơn, Ngày đặt & Trạng thái -->
                            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
                                <div>
                                    <span class="fw-bold text-primary fs-6 me-2">#ORD-${ord.orderId}</span>
                                    <span class="text-muted small">
                                        <i class="fa-regular fa-clock me-1"></i> Ngày đặt: ${ord.formattedOrderDate}
                                    </span>
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="badge bg-light text-dark border">
                                        <i class="fa-solid fa-money-bill-wave text-success me-1"></i> ${ord.paymentMethod}
                                    </span>
                                    <!-- Badge trạng thái 8 màu -->
                                    <span class="badge ${ord.statusBadgeClass} px-3 py-2 fs-6">
                                        ${ord.status}
                                    </span>
                                </div>
                            </div>

                            <!-- Card Body: Danh sách món hàng trong đơn -->
                            <div class="card-body py-2">
                                <div class="list-group list-group-flush">
                                    <c:forEach items="${ord.items}" var="it">
                                        <div class="list-group-item px-0 py-3 d-flex justify-content-between align-items-center flex-wrap">
                                            <div class="d-flex align-items-center">
                                                <img src="${it.videoPoster}" alt="${it.videoTitle}" class="rounded me-3 shadow-sm" style="width: 80px; height: 50px; object-fit: cover;" onerror="this.src='https://placehold.co/80x50?text=Video'">
                                                <div>
                                                    <h6 class="mb-1 fw-bold">
                                                        <a href="${pageContext.request.contextPath}/video/detail?id=${it.videoId}" class="text-dark text-decoration-none">
                                                            ${it.videoTitle}
                                                        </a>
                                                    </h6>
                                                    <small class="text-muted">Mã video: <span class="badge bg-light text-secondary border">${it.videoId}</span> | Đơn giá: ${it.formattedPrice} | SL: <strong>x${it.quantity}</strong></small>
                                                </div>
                                            </div>
                                            <div class="text-end mt-2 mt-sm-0">
                                                <span class="fw-bold text-primary">${it.formattedTotalPrice}</span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Card Footer: Thông tin người nhận, Tổng tiền & Nút thao tác -->
                            <div class="card-footer bg-light py-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
                                <div class="small text-muted">
                                    <div><i class="fa-solid fa-user me-1"></i> Người nhận: <strong>${ord.receiverName}</strong> - SĐT: <strong>${ord.receiverPhone}</strong></div>
                                    <div><i class="fa-solid fa-location-dot me-1"></i> Địa chỉ giao: ${ord.receiverAddress}</div>
                                    <c:if test="${not empty ord.notes}">
                                        <div><i class="fa-solid fa-comment-dots me-1"></i> Ghi chú: <em>${ord.notes}</em></div>
                                    </c:if>
                                </div>
                                <div class="d-flex align-items-center gap-3">
                                    <div class="text-end">
                                        <span class="text-muted small d-block">Tổng tiền COD:</span>
                                        <span class="fs-5 fw-bold text-danger">${ord.formattedTotalAmount}</span>
                                    </div>

                                    <!-- Nút Hủy đơn chỉ hiển thị khi đơn đang ở trạng thái 'Đơn hàng mới' -->
                                    <c:if test="${ord.status == 'Đơn hàng mới'}">
                                        <a href="${pageContext.request.contextPath}/order-history?action=cancel&id=${ord.orderId}" 
                                           class="btn btn-outline-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #ORD-${ord.orderId} không? Số lượng sản phẩm sẽ được tự động hoàn lại vào kho.');">
                                            <i class="fa-solid fa-ban me-1"></i> Hủy đơn
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Hộp hướng dẫn kiểm thử database cho người dùng / giảng viên -->
        <div class="alert alert-info border-info-subtle mt-4 shadow-sm" role="alert">
            <h6 class="alert-heading fw-bold mb-2">
                <i class="fa-solid fa-database me-2"></i> Hướng dẫn kiểm thử thay đổi 8 trạng thái đơn hàng trong Database
            </h6>
            <p class="small mb-1">
                Để quan sát trạng thái đơn hàng thay đổi theo thời gian thực, bạn có thể thực thi lệnh SQL trong file 
                <code>database/test_order_status.sql</code> trên SSMS:
            </p>
            <pre class="bg-dark text-light p-2 rounded small mb-0"><code>UPDATE Orders SET Status = N'Đã xác nhận' WHERE OrderId = [Mã_Đơn];
-- Các trạng thái: N'Đơn hàng mới', N'Đã xác nhận', N'Chuẩn bị hàng', N'Vận chuyển', N'Giao hàng', N'Đã giao', N'Đơn hàng hủy', N'Đơn hàng hoàn'</code></pre>
            <p class="small mb-0 mt-1">Sau khi chạy lệnh SQL, bấm <strong>F5 (Refresh)</strong> hoặc bấm vào các Tab phía trên để kiểm tra kết quả lọc tương ứng.</p>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
