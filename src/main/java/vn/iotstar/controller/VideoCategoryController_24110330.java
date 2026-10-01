package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.model.CategoryModel_24110330;
import vn.iotstar.model.VideoModel_24110330;
import vn.iotstar.service.ICategoryService_24110330;
import vn.iotstar.service.IVideoService_24110330;
import vn.iotstar.service.impl.CategoryServiceImpl_24110330;
import vn.iotstar.service.impl.VideoServiceImpl_24110330;

@WebServlet(name = "VideoCategoryController_24110330", urlPatterns = {"/videos/category"})
public class VideoCategoryController_24110330 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 3; // Yêu cầu đề thi Câu 5: phân trang 3 video / trang

    private ICategoryService_24110330 categoryService = new CategoryServiceImpl_24110330();
    private IVideoService_24110330 videoService = new VideoServiceImpl_24110330();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int categoryId = 1;
        String catParam = request.getParameter("id");
        if (catParam != null) {
            try {
                categoryId = Integer.parseInt(catParam);
            } catch (NumberFormatException ignored) {}
        }

        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException ignored) {}
        }

        CategoryModel_24110330 currentCategory = categoryService.getById(categoryId);
        if (currentCategory == null) {
            List<CategoryModel_24110330> allCats = categoryService.getAll();
            if (!allCats.isEmpty()) {
                currentCategory = allCats.get(0);
                categoryId = currentCategory.getCategoryId();
            }
        }

        // Câu 6: Đếm số lượng Video theo Category hiển thị ở câu 5
        int totalVideos = videoService.countVideosByCategory(categoryId);
        int totalPages = (int) Math.ceil((double) totalVideos / PAGE_SIZE);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;

        // Câu 5: Lấy danh sách video theo category phân trang 3 video / trang
        List<VideoModel_24110330> videoList = videoService.getVideosByCategoryPaged(categoryId, page, PAGE_SIZE);

        List<CategoryModel_24110330> categories = categoryService.getAll();

        request.setAttribute("currentCategory", currentCategory);
        request.setAttribute("totalVideos", totalVideos);
        request.setAttribute("videoList", videoList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/WEB-INF/views/web/videos-by-category.jsp").forward(request, response);
    }
}
