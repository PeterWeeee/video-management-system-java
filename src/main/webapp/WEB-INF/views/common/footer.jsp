<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- FOOTER -->
<footer class="footer text-center bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <p class="mb-0 fs-5 fw-semibold text-white">
                    Họ tên: Nguyễn Trí Thái | MSSV: 24110330 | Mã đề: 04
                </p>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Đảm bảo tất cả dropdown Bootstrap hoạt động ổn định
    document.addEventListener("DOMContentLoaded", function () {
        var dropdownTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="dropdown"]'));
        dropdownTriggerList.forEach(function (dropdownTriggerEl) {
            new bootstrap.Dropdown(dropdownTriggerEl);
        });
    });
</script>
