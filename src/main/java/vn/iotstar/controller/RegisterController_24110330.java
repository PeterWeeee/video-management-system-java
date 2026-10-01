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
import vn.iotstar.util.EmailUtil_24110330;
import vn.iotstar.util.OtpUtil_24110330;

@WebServlet(name = "RegisterController_24110330", urlPatterns = {"/register"})
public class RegisterController_24110330 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IUserService_24110330 userService = new UserServiceImpl_24110330();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/web/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()
                || email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ Tên đăng nhập, Mật khẩu và Email!");
            request.getRequestDispatcher("/WEB-INF/views/web/register.jsp").forward(request, response);
            return;
        }

        username = username.trim();
        email = email.trim();

        if (!EmailUtil_24110330.isValidEmail(email)) {
            request.setAttribute("error", "Địa chỉ email '" + email + "' không đúng định dạng hợp lệ!");
            request.getRequestDispatcher("/WEB-INF/views/web/register.jsp").forward(request, response);
            return;
        }

        if (userService.getById(username) != null) {
            request.setAttribute("error", "Tên đăng nhập '" + username + "' đã tồn tại! Vui lòng chọn tên khác.");
            request.getRequestDispatcher("/WEB-INF/views/web/register.jsp").forward(request, response);
            return;
        }

        if (userService.getByEmail(email) != null) {
            request.setAttribute("error", "Email '" + email + "' đã được sử dụng! Vui lòng chọn email khác.");
            request.getRequestDispatcher("/WEB-INF/views/web/register.jsp").forward(request, response);
            return;
        }

        // Sinh mã OTP 6 chữ số và gửi qua email trước
        String otp = OtpUtil_24110330.generateOtp();
        boolean sent = EmailUtil_24110330.sendOtpEmail(email, otp);

        if (!sent) {
            request.setAttribute("error", "Không thể gửi mã OTP tới email '" + email + "' (email không tồn tại hoặc lỗi máy chủ thư). Chưa lưu thông tin vào database. Vui lòng kiểm tra lại địa chỉ email!");
            request.getRequestDispatcher("/WEB-INF/views/web/register.jsp").forward(request, response);
            return;
        }

        // Chuẩn bị thông tin tài khoản, lưu tạm vào Session (CHƯA LƯU VÀO DATABASE cho tới khi xác nhận đúng OTP)
        UserModel_24110330 pendingUser = new UserModel_24110330();
        pendingUser.setUsername(username);
        pendingUser.setPassword(password);
        pendingUser.setFullname(fullname != null ? fullname.trim() : "");
        pendingUser.setEmail(email);
        pendingUser.setPhone(phone != null ? phone.trim() : "");
        pendingUser.setAdmin(false);
        pendingUser.setActive(true);
        pendingUser.setImages("https://ui-avatars.com/api/?name=" + (fullname != null && !fullname.trim().isEmpty() ? fullname.trim().replace(" ", "+") : username));

        HttpSession session = request.getSession();
        session.setAttribute("pendingUser", pendingUser);
        session.setAttribute("otpCode", otp);
        session.setAttribute("otpUsername", username);
        session.setAttribute("otpEmail", email);
        session.setAttribute("message", "Mã OTP đã được gửi thành công đến email " + email + ". Vui lòng kiểm tra hộp thư để kích hoạt tài khoản!");

        response.sendRedirect(request.getContextPath() + "/verify-otp");
    }
}
