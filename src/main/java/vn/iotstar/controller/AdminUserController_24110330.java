package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.model.UserModel_24110330;
import vn.iotstar.service.IUserService_24110330;
import vn.iotstar.service.impl.UserServiceImpl_24110330;

@WebServlet(name = "AdminUserController_24110330", urlPatterns = {
        "/admin/users",
        "/admin/user/create",
        "/admin/user/edit",
        "/admin/user/delete"
})
public class AdminUserController_24110330 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 6; // Yêu cầu đề thi: phân trang 6 user trên 01 trang

    private IUserService_24110330 userService = new UserServiceImpl_24110330();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!checkAdmin(request, response)) return;

        String path = request.getServletPath();

        if ("/admin/user/create".equals(path)) {
            request.setAttribute("isEdit", false);
            request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
        } else if ("/admin/user/edit".equals(path)) {
            String username = request.getParameter("username");
            UserModel_24110330 user = userService.getById(username);
            if (user != null) {
                request.setAttribute("user", user);
                request.setAttribute("isEdit", true);
                request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users");
            }
        } else if ("/admin/user/delete".equals(path)) {
            String username = request.getParameter("username");
            if (username != null) {
                userService.delete(username);
            }
            response.sendRedirect(request.getContextPath() + "/admin/users?message=deleted");
        } else {
            // Mặc định là xem danh sách có phân trang 6 users / trang (Câu 3)
            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException ignored) {}
            }

            int totalUsers = userService.countUsers();
            int totalPages = (int) Math.ceil((double) totalUsers / PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;

            List<UserModel_24110330> list = userService.getPage(page, PAGE_SIZE);

            request.setAttribute("userList", list);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalUsers", totalUsers);
            request.getRequestDispatcher("/WEB-INF/views/admin/user-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!checkAdmin(request, response)) return;

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String path = request.getServletPath();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        boolean admin = "true".equalsIgnoreCase(request.getParameter("admin")) || "on".equalsIgnoreCase(request.getParameter("admin"));
        boolean active = "true".equalsIgnoreCase(request.getParameter("active")) || "on".equalsIgnoreCase(request.getParameter("active"));
        String images = request.getParameter("images");
        if (images == null || images.trim().isEmpty()) {
            images = "https://ui-avatars.com/api/?name=" + (fullname != null ? fullname.replace(" ", "+") : username);
        }

        if ("/admin/user/create".equals(path)) {
            if (userService.getById(username) != null) {
                request.setAttribute("error", "Username '" + username + "' đã tồn tại!");
                request.setAttribute("isEdit", false);
                request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
                return;
            }
            UserModel_24110330 newUser = new UserModel_24110330(username, password, phone, fullname, email, admin, active, images);
            userService.insert(newUser);
            response.sendRedirect(request.getContextPath() + "/admin/users?message=created");
        } else if ("/admin/user/edit".equals(path)) {
            UserModel_24110330 existingUser = userService.getById(username);
            if (existingUser != null) {
                existingUser.setPassword(password);
                existingUser.setFullname(fullname);
                existingUser.setEmail(email);
                existingUser.setPhone(phone);
                existingUser.setAdmin(admin);
                existingUser.setActive(active);
                existingUser.setImages(images);
                userService.update(existingUser);
            }
            response.sendRedirect(request.getContextPath() + "/admin/users?message=updated");
        }
    }

    private boolean checkAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        UserModel_24110330 currentUser = (session != null) ? (UserModel_24110330) session.getAttribute("currentUser") : null;
        if (currentUser == null || !Boolean.TRUE.equals(currentUser.getAdmin())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}
