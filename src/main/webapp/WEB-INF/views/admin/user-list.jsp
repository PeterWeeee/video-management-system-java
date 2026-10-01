<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Trị Người Dùng (Users)</title>
</head>
<body class="bg-light">
    <!-- Admin Header -->
    <jsp:include page="/WEB-INF/views/common/admin-header.jsp" />

    <div class="container-fluid px-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h3 class="fw-bold text-dark mb-0">
                    <i class="fa-solid fa-users-gear text-primary"></i> Quản Trị Người Dùng
                </h3>
                <span class="text-muted small">Quản lý danh sách, thêm, sửa, xóa Users - Phân trang 6 user/trang</span>
            </div>
            <a href="${pageContext.request.contextPath}/admin/user/create" class="btn btn-success">
                <i class="fa-solid fa-plus-circle"></i> Thêm User Mới
            </a>
        </div>

        <!-- Thông báo kết quả thao tác -->
        <c:if test="${param.message == 'created'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-circle-check"></i> Thêm người dùng mới thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.message == 'updated'}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-circle-check"></i> Cập nhật thông tin người dùng thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.message == 'deleted'}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-trash-can"></i> Đã xóa người dùng khỏi hệ thống!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Bảng danh sách Users -->
        <div class="card border-0 shadow-sm">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th scope="col" style="width: 50px;">#</th>
                                <th scope="col" style="width: 70px;">Avatar</th>
                                <th scope="col">Username</th>
                                <th scope="col">Họ và tên</th>
                                <th scope="col">Email</th>
                                <th scope="col">Số điện thoại</th>
                                <th scope="col" class="text-center">Vai trò</th>
                                <th scope="col" class="text-center">Trạng thái</th>
                                <th scope="col" class="text-center" style="width: 150px;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty userList}">
                                    <c:forEach items="${userList}" var="u" varStatus="loop">
                                        <tr>
                                            <td>${(currentPage - 1) * 6 + loop.index + 1}</td>
                                            <td>
                                                <img src="${u.images != null ? u.images : 'https://ui-avatars.com/api/?name=User'}" 
                                                     alt="avatar" class="rounded-circle" width="40" height="40" style="object-fit: cover;">
                                            </td>
                                            <td><strong>${u.username}</strong></td>
                                            <td>${u.fullname != null ? u.fullname : '<span class=\"text-muted\">Chưa cập nhật</span>'}</td>
                                            <td>${u.email}</td>
                                            <td>${u.phone != null ? u.phone : '-'}</td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${u.admin == true}">
                                                        <span class="badge bg-danger">Admin</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">User</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${u.active == true}">
                                                        <span class="badge bg-success">Đã kích hoạt</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning text-dark">Chưa kích hoạt</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/admin/user/edit?username=${u.username}" 
                                                   class="btn btn-sm btn-outline-primary me-1" title="Chỉnh sửa">
                                                    <i class="fa-solid fa-pen-to-square"></i> Sửa
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/user/delete?username=${u.username}" 
                                                   class="btn btn-sm btn-outline-danger" 
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa user [${u.username}] không?');" 
                                                   title="Xóa">
                                                    <i class="fa-solid fa-trash"></i> Xóa
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="9" class="text-center py-4 text-muted">Không có người dùng nào.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Phân trang (6 users trên 01 trang) -->
            <div class="card-footer bg-white d-flex justify-content-between align-items-center py-3">
                <span class="text-muted small">
                    Hiển thị trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong> (Tổng cộng <strong>${totalUsers}</strong> users - 6 users/trang)
                </span>

                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-sm mb-0">
                        <!-- Nút Previous -->
                        <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage - 1}">
                                <i class="fa-solid fa-chevron-left"></i>
                            </a>
                        </li>

                        <!-- Các số trang -->
                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <li class="page-item ${p == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${p}">${p}</a>
                            </li>
                        </c:forEach>

                        <!-- Nút Next -->
                        <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage + 1}">
                                <i class="fa-solid fa-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <!-- Admin Footer -->
    <jsp:include page="/WEB-INF/views/common/admin-footer.jsp" />
</body>
</html>
