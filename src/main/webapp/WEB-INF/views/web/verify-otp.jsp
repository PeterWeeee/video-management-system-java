<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác thực mã OTP - Đề số 04</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .otp-card {
            width: 100%;
            max-width: 440px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.25);
            background: #ffffff;
            padding: 32px;
            text-align: center;
        }
        .otp-input {
            letter-spacing: 8px;
            font-size: 26px;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="otp-card">
        <div class="mb-3 text-primary">
            <i class="fa-solid fa-envelope-open-text fa-3x"></i>
        </div>
        <h4 class="fw-bold mb-2">XÁC THỰC MÃ OTP</h4>
        <p class="text-muted small">
            Mã OTP đã được gửi đến email: <strong>${sessionScope.otpEmail}</strong>.<br/>
            Vui lòng nhập mã 6 số để kích hoạt tài khoản <strong>${sessionScope.otpUsername}</strong>.
        </p>

        <div class="alert alert-light border py-2 small text-muted text-start my-2">
            <i class="fa-solid fa-circle-info text-primary"></i> <strong>Lưu ý:</strong> Vui lòng kiểm tra cả mục <strong>Thư rác (Spam)</strong> hoặc <strong>Quảng cáo</strong> nếu không thấy trong Hộp thư chính.
        </div>

        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-info py-2 small" role="alert">
                <i class="fa-solid fa-info-circle"></i> ${sessionScope.message}
            </div>
            <% session.removeAttribute("message"); %>
        </c:if>

        <c:if test="${not empty warning}">
            <div class="alert alert-warning py-2 small" role="alert">
                <i class="fa-solid fa-triangle-exclamation"></i> ${warning}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2 small" role="alert">
                <i class="fa-solid fa-circle-xmark"></i> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/verify-otp" method="post">
            <div class="mb-4">
                <label for="otp" class="form-label fw-semibold">Nhập mã OTP (6 số)</label>
                <input type="text" class="form-control otp-input" id="otp" name="otp" maxlength="6" placeholder="000000" required autofocus>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                <i class="fa-solid fa-check-double"></i> Xác nhận & Kích hoạt tài khoản
            </button>
        </form>

        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/register" class="text-decoration-none small text-muted">
                <i class="fa-solid fa-arrow-left"></i> Đăng ký lại bằng email khác
            </a>
        </div>
    </div>
</body>
</html>
