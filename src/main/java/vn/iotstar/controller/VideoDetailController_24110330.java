package vn.iotstar.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.model.VideoModel_24110330;
import vn.iotstar.service.IVideoService_24110330;
import vn.iotstar.service.impl.VideoServiceImpl_24110330;

@WebServlet(name = "VideoDetailController_24110330", urlPatterns = {"/video/detail"})
public class VideoDetailController_24110330 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IVideoService_24110330 videoService = new VideoServiceImpl_24110330();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String videoId = request.getParameter("id");
        if (videoId == null || videoId.trim().isEmpty()) {
            videoId = "V01"; // Mặc định hiển thị video V01 nếu không truyền id
        }

        VideoModel_24110330 video = videoService.getVideoDetail(videoId);
        if (video == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.setAttribute("video", video);
        request.getRequestDispatcher("/WEB-INF/views/web/video-detail.jsp").forward(request, response);
    }
}
