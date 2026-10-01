package vn.iotstar.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.OrderModel_24110330;
import vn.iotstar.model.UserModel_24110330;
import vn.iotstar.service.IOrderService_24110330;
import vn.iotstar.service.impl.OrderServiceImpl_24110330;

@WebServlet(urlPatterns = { "/order-history" })
public class OrderHistoryController_24110330 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IOrderService_24110330 orderService = new OrderServiceImpl_24110330();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserModel_24110330 currentUser = (UserModel_24110330) session.getAttribute("currentUser");
        if (currentUser == null) {
            String msg = URLEncoder.encode("Vui lòng đăng nhập để xem lịch sử đặt hàng!", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/login?msg=" + msg);
            return;
        }

        String action = req.getParameter("action");
        if ("cancel".equals(action)) {
            cancelOrder(req, resp, currentUser.getUsername());
            return;
        }

        // Lấy tham số bộ lọc trạng thái (mặc định 'all' hoặc tên trạng thái)
        String statusFilter = req.getParameter("status");
        if (statusFilter == null || statusFilter.trim().isEmpty()) {
            statusFilter = "all";
        } else {
            statusFilter = statusFilter.trim();
        }

        // Lấy danh sách đơn hàng theo trạng thái lọc
        List<OrderModel_24110330> orders = orderService.getOrdersByUsername(currentUser.getUsername(), statusFilter);

        // Đếm số lượng đơn theo từng trạng thái để hiển thị Badge trên Tab
        String username = currentUser.getUsername();
        req.setAttribute("countAll", orderService.getOrderCount(username, "all"));
        req.setAttribute("countNew", orderService.getOrderCount(username, "Đơn hàng mới"));
        req.setAttribute("countConfirmed", orderService.getOrderCount(username, "Đã xác nhận"));
        req.setAttribute("countPreparing", orderService.getOrderCount(username, "Chuẩn bị hàng"));
        req.setAttribute("countShipping", orderService.getOrderCount(username, "Vận chuyển"));
        req.setAttribute("countDelivering", orderService.getOrderCount(username, "Giao hàng"));
        req.setAttribute("countDelivered", orderService.getOrderCount(username, "Đã giao"));
        req.setAttribute("countCancelled", orderService.getOrderCount(username, "Đơn hàng hủy"));
        req.setAttribute("countReturned", orderService.getOrderCount(username, "Đơn hàng hoàn"));

        req.setAttribute("currentStatus", statusFilter);
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/WEB-INF/views/web/order-history.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    private void cancelOrder(HttpServletRequest req, HttpServletResponse resp, String username) throws IOException {
        String orderIdStr = req.getParameter("id");
        try {
            int orderId = Integer.parseInt(orderIdStr);
            boolean cancelled = orderService.cancelOrder(orderId, username);
            if (cancelled) {
                String msg = URLEncoder.encode("Đã hủy đơn hàng #" + orderId + " thành công và hoàn trả số lượng tồn kho!", StandardCharsets.UTF_8);
                resp.sendRedirect(req.getContextPath() + "/order-history?msg=" + msg);
            } else {
                String err = URLEncoder.encode("Không thể hủy đơn hàng này (chỉ đơn hàng ở trạng thái 'Đơn hàng mới' mới được phép hủy)!", StandardCharsets.UTF_8);
                resp.sendRedirect(req.getContextPath() + "/order-history?error=" + err);
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/order-history");
        }
    }
}
