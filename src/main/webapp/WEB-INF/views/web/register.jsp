<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản (Kích hoạt OTP) - Đề số 04</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 15px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .register-card {
            width: 100%;
            max-width: 500px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.25);
            background: #ffffff;
            padding: 32px;
        }
    </style>
</head>
<body>
    <div class="register-card">
        <div class="text-center mb-4">
            <h3 class="fw-bold text-success"><i class="fa-solid fa-user-plus"></i> ĐĂNG KÝ TÀI KHOẢN</h3>
            <p class="text-muted small">Kích hoạt tài khoản bằng mã OTP gửi về Email</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2 small" role="alert">
                <i class="fa-solid fa-triangle-exclamation"></i> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                    <input type="text" class="form-control" id="username" name="username" value="${param.username}" placeholder="Nhập username" required autofocus>
                </div>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                </div>
            </div>

            <div class="mb-3">
                <label for="fullname" class="form-label fw-semibold">Họ và tên</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-id-card"></i></span>
                    <input type="text" class="form-control" id="fullname" name="fullname" value="${param.fullname}" placeholder="Ví dụ: Nguyễn Văn A">
                </div>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label fw-semibold">Email nhận OTP <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                    <input type="email" class="form-control" id="email" name="email" value="${param.email}" placeholder="example@gmail.com" required>
                </div>
                <div class="form-text text-muted">Mã OTP 6 số sẽ được gửi về địa chỉ này để kích hoạt.</div>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                    <input type="text" class="form-control" id="phone" name="phone" value="${param.phone}" placeholder="09xxxxxxxx">
                </div>
            </div>

            <button type="submit" class="btn btn-success w-100 py-2 fw-semibold">
                <i class="fa-solid fa-paper-plane"></i> Đăng ký & Gửi OTP qua Email
            </button>
        </form>

        <div class="mt-4 text-center">
            <p class="mb-1 text-muted small">Đã có tài khoản?</p>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary btn-sm">
                <i class="fa-solid fa-sign-in"></i> Đăng nhập ngay
            </a>
        </div>
    </div>
</body>
</html>
