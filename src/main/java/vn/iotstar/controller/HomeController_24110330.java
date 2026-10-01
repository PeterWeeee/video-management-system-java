package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.model.CategoryModel_24110330;
import vn.iotstar.model.CategoryVideoCountDto_24110330;
import vn.iotstar.model.VideoModel_24110330;
import vn.iotstar.service.ICategoryService_24110330;
import vn.iotstar.service.IVideoService_24110330;
import vn.iotstar.service.impl.CategoryServiceImpl_24110330;
import vn.iotstar.service.impl.VideoServiceImpl_24110330;

@WebServlet(name = "HomeController_24110330", urlPatterns = {"/home", ""})
public class HomeController_24110330 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ICategoryService_24110330 categoryService = new CategoryServiceImpl_24110330();
    private IVideoService_24110330 videoService = new VideoServiceImpl_24110330();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<CategoryModel_24110330> categories = categoryService.getAll();
            List<CategoryVideoCountDto_24110330> categoryCounts = categoryService.getCategoryVideoCounts();
            List<VideoModel_24110330> featuredVideos = videoService.getAllPaged(1, 6);

            request.setAttribute("categories", categories);
            request.setAttribute("categoryCounts", categoryCounts);
            request.setAttribute("featuredVideos", featuredVideos);

            request.getRequestDispatcher("/WEB-INF/views/web/home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<h3>Đã xảy ra lỗi tại HomeController:</h3><pre>" + e.getMessage() + "</pre>");
        }
    }
}
