<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${isEdit ? 'Cập Nhật Người Dùng' : 'Thêm Người Dùng Mới'}</title>
</head>
<body class="bg-light">
    <!-- Admin Header -->
    <jsp:include page="/WEB-INF/views/common/admin-header.jsp" />

    <div class="container-fluid px-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h4 class="fw-bold mb-0 text-dark">
                            <c:choose>
                                <c:when test="${isEdit}">
                                    <i class="fa-solid fa-user-pen text-primary"></i> Cập Nhật Thông Tin User: <strong>${user.username}</strong>
                                </c:when>
                                <c:otherwise>
                                    <i class="fa-solid fa-user-plus text-success"></i> Thêm Người Dùng Mới
                                </c:otherwise>
                            </c:choose>
                        </h4>
                    </div>

                    <div class="card-body p-4">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger py-2 small" role="alert">
                                <i class="fa-solid fa-triangle-exclamation"></i> ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}${isEdit ? '/admin/user/edit' : '/admin/user/create'}" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label fw-semibold">Tên đăng nhập (Username) <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="username" name="username" 
                                       value="${user.username}" ${isEdit ? 'readonly' : 'required'}>
                                <c:if test="${isEdit}">
                                    <div class="form-text text-muted">Username là khóa chính, không thể thay đổi.</div>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="password" name="password" 
                                       value="${user.password}" required>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="fullname" class="form-label fw-semibold">Họ và tên</label>
                                    <input type="text" class="form-control" id="fullname" name="fullname" 
                                           value="${user.fullname}">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                                    <input type="text" class="form-control" id="phone" name="phone" 
                                           value="${user.phone}">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label fw-semibold">Email <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="${user.email}" required>
                            </div>

                            <div class="mb-3">
                                <label for="images" class="form-label fw-semibold">Đường dẫn ảnh đại diện (Images URL)</label>
                                <input type="text" class="form-control" id="images" name="images" 
                                       value="${user.images}" placeholder="https://example.com/avatar.jpg">
                            </div>

                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" id="admin" name="admin" value="true" 
                                               ${user.admin == true ? 'checked' : ''}>
                                        <label class="form-check-label fw-semibold" for="admin">Quyền Quản trị viên (Admin)</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" id="active" name="active" value="true" 
                                               ${user.active == true || !isEdit ? 'checked' : ''}>
                                        <label class="form-check-label fw-semibold" for="active">Trạng thái kích hoạt (Active)</label>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary px-4">
                                    <i class="fa-solid fa-floppy-disk"></i> ${isEdit ? 'Lưu Cập Nhật' : 'Thêm User'}
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary px-4">
                                    <i class="fa-solid fa-xmark"></i> Hủy Bỏ
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Admin Footer -->
    <jsp:include page="/WEB-INF/views/common/admin-footer.jsp" />
</body>
</html>
