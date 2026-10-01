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

@WebServlet(name = "LoginController_24110330", urlPatterns = {"/login"})
public class LoginController_24110330 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IUserService_24110330 userService = new UserServiceImpl_24110330();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/web/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserModel_24110330 user = userService.login(username, password);

        // Kiểm tra đăng nhập
        if (user == null) {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/WEB-INF/views/web/login.jsp").forward(request, response);
            return;
        }

        if (Boolean.FALSE.equals(user.getActive())) {
            request.setAttribute("error", "Tài khoản chưa được kích hoạt qua OTP. Vui lòng kích hoạt tài khoản!");
            request.getRequestDispatcher("/WEB-INF/views/web/login.jsp").forward(request, response);
            return;
        }

        // Lưu thông tin người dùng vào Session
        HttpSession session = request.getSession();
        session.setAttribute("currentUser", user);

        // Phân quyền điều hướng: Admin vào /admin/home, User thường vào /home
        if (Boolean.TRUE.equals(user.getAdmin())) {
            response.sendRedirect(request.getContextPath() + "/admin/home");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
