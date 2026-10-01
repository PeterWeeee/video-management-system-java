package vn.iotstar.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.model.UserModel_24110330;
import vn.iotstar.service.ICategoryService_24110330;
import vn.iotstar.service.IUserService_24110330;
import vn.iotstar.service.IVideoService_24110330;
import vn.iotstar.service.impl.CategoryServiceImpl_24110330;
import vn.iotstar.service.impl.UserServiceImpl_24110330;
import vn.iotstar.service.impl.VideoServiceImpl_24110330;

@WebServlet(name = "AdminHomeController_24110330", urlPatterns = {"/admin/home", "/admin"})
public class AdminHomeController_24110330 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IUserService_24110330 userService = new UserServiceImpl_24110330();
    private ICategoryService_24110330 categoryService = new CategoryServiceImpl_24110330();
    private IVideoService_24110330 videoService = new VideoServiceImpl_24110330();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserModel_24110330 currentUser = (session != null) ? (UserModel_24110330) session.getAttribute("currentUser") : null;

        if (currentUser == null || !Boolean.TRUE.equals(currentUser.getAdmin())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int totalUsers = userService.countUsers();
        int totalVideos = videoService.countAll();
        int totalCategories = categoryService.getAll().size();

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalVideos", totalVideos);
        request.setAttribute("totalCategories", totalCategories);

        request.getRequestDispatcher("/WEB-INF/views/admin/home.jsp").forward(request, response);
    }
}
