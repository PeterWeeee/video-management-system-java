package vn.iotstar.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.model.UserModel_24110330;
import vn.iotstar.service.IUserService_24110330;
import vn.iotstar.service.impl.UserServiceImpl_24110330;

@WebServlet(name = "VerifyOtpController_24110330", urlPatterns = {"/verify-otp"})
public class VerifyOtpController_24110330 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IUserService_24110330 userService = new UserServiceImpl_24110330();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("pendingUser") == null || session.getAttribute("otpCode") == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/web/verify-otp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String enteredOtp = request.getParameter("otp");
        HttpSession session = request.getSession();
        UserModel_24110330 pendingUser = (UserModel_24110330) session.getAttribute("pendingUser");
        String sessionOtp = (String) session.getAttribute("otpCode");

        if (pendingUser == null || sessionOtp == null) {
            request.setAttribute("error", "Phiên xác thực đã hết hạn hoặc không tồn tại. Vui lòng đăng ký lại!");
            request.getRequestDispatcher("/WEB-INF/views/web/register.jsp").forward(request, response);
            return;
        }

        if (enteredOtp != null && enteredOtp.trim().equals(sessionOtp.trim())) {
            // Xác thực OTP THÀNH CÔNG: LƯU VÀO DATABASE TẠI ĐÂY
            if (userService.getById(pendingUser.getUsername()) != null) {
                request.setAttribute("error", "Tên đăng nhập '" + pendingUser.getUsername() + "' đã tồn tại!");
                request.getRequestDispatcher("/WEB-INF/views/web/register.jsp").forward(request, response);
                return;
            }
            if (userService.getByEmail(pendingUser.getEmail()) != null) {
                request.setAttribute("error", "Email '" + pendingUser.getEmail() + "' đã được sử dụng!");
                request.getRequestDispatcher("/WEB-INF/views/web/register.jsp").forward(request, response);
                return;
            }

            pendingUser.setActive(true);
            userService.insert(pendingUser);

            // Dọn dẹp session tạm
            session.removeAttribute("pendingUser");
            session.removeAttribute("otpCode");
            session.removeAttribute("otpUsername");
            session.removeAttribute("otpEmail");
            session.removeAttribute("message");

            session.setAttribute("successMessage", "Xác thực OTP thành công! Tài khoản " + pendingUser.getUsername() + " đã được tạo và kích hoạt. Bạn có thể đăng nhập ngay.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Nhập sai OTP: TUYỆT ĐỐI KHÔNG LƯU VÀO DATABASE
            request.setAttribute("error", "Mã OTP không chính xác. Vui lòng kiểm tra lại hộp thư và nhập đúng mã 6 chữ số!");
            request.getRequestDispatcher("/WEB-INF/views/web/verify-otp.jsp").forward(request, response);
        }
    }
}
