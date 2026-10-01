package vn.iotstar.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.CartItemModel_24110330;
import vn.iotstar.model.OrderModel_24110330;
import vn.iotstar.model.UserModel_24110330;
import vn.iotstar.model.VideoModel_24110330;
import vn.iotstar.service.IOrderService_24110330;
import vn.iotstar.service.IVideoService_24110330;
import vn.iotstar.service.impl.OrderServiceImpl_24110330;
import vn.iotstar.service.impl.VideoServiceImpl_24110330;

@WebServlet(urlPatterns = { "/checkout", "/order-success" })
public class CheckoutController_24110330 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IOrderService_24110330 orderService = new OrderServiceImpl_24110330();
    private IVideoService_24110330 videoService = new VideoServiceImpl_24110330();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();
        if ("/order-success".equals(servletPath)) {
            showOrderSuccess(req, resp);
            return;
        }

        // Kiểm tra đăng nhập
        HttpSession session = req.getSession();
        UserModel_24110330 currentUser = (UserModel_24110330) session.getAttribute("currentUser");
        if (currentUser == null) {
            String msg = URLEncoder.encode("Vui lòng đăng nhập để tiến hành thanh toán đơn hàng!", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/login?msg=" + msg);
            return;
        }

        // Kiểm tra giỏ hàng
        @SuppressWarnings("unchecked")
        Map<String, CartItemModel_24110330> cart = (Map<String, CartItemModel_24110330>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            String error = URLEncoder.encode("Giỏ hàng của bạn đang trống! Vui lòng chọn sản phẩm.", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/cart?error=" + error);
            return;
        }

        double totalAmount = 0;
        for (CartItemModel_24110330 item : cart.values()) {
            totalAmount += item.getTotalPrice();
        }

        req.setAttribute("user", currentUser);
        req.setAttribute("cartItems", cart.values());
        req.setAttribute("totalAmount", totalAmount);
        req.setAttribute("formattedTotalAmount", String.format("%,.0f đ", totalAmount));
        req.getRequestDispatcher("/WEB-INF/views/web/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserModel_24110330 currentUser = (UserModel_24110330) session.getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        @SuppressWarnings("unchecked")
        Map<String, CartItemModel_24110330> cart = (Map<String, CartItemModel_24110330>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String receiverName = req.getParameter("receiverName");
        String receiverPhone = req.getParameter("receiverPhone");
        String receiverAddress = req.getParameter("receiverAddress");
        String notes = req.getParameter("notes");
        String paymentMethod = req.getParameter("paymentMethod");

        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "COD";
        }

        // Kiểm tra hợp lệ dữ liệu giao nhận
        if (receiverName == null || receiverName.trim().isEmpty() ||
            receiverPhone == null || receiverPhone.trim().isEmpty() ||
            receiverAddress == null || receiverAddress.trim().isEmpty()) {
            
            req.setAttribute("error", "Vui lòng điền đầy đủ họ tên, số điện thoại và địa chỉ nhận hàng!");
            req.setAttribute("user", currentUser);
            req.setAttribute("cartItems", cart.values());
            req.getRequestDispatcher("/WEB-INF/views/web/checkout.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra tồn kho trước khi đặt hàng
        for (CartItemModel_24110330 cItem : cart.values()) {
            VideoModel_24110330 vid = videoService.getVideoDetail(cItem.getVideoId());
            if (vid == null || vid.getStock() < cItem.getQuantity()) {
                int available = (vid == null) ? 0 : vid.getStock();
                String err = "Sản phẩm \"" + cItem.getTitle() + "\" chỉ còn " + available + " suất. Vui lòng điều chỉnh lại giỏ hàng!";
                req.setAttribute("error", err);
                req.setAttribute("user", currentUser);
                req.setAttribute("cartItems", cart.values());
                req.getRequestDispatcher("/WEB-INF/views/web/checkout.jsp").forward(req, resp);
                return;
            }
        }

        // Khởi tạo đối tượng đơn hàng
        OrderModel_24110330 order = new OrderModel_24110330();
        order.setUsername(currentUser.getUsername());
        order.setReceiverName(receiverName.trim());
        order.setReceiverPhone(receiverPhone.trim());
        order.setReceiverAddress(receiverAddress.trim());
        order.setPaymentMethod(paymentMethod);
        order.setNotes(notes != null ? notes.trim() : "");
        order.setStatus("Đơn hàng mới");

        List<CartItemModel_24110330> items = new ArrayList<>(cart.values());
        int createdOrderId = orderService.createOrderCOD(order, items);

        if (createdOrderId > 0) {
            // Xóa sạch giỏ hàng trong session
            session.removeAttribute("cart");
            session.removeAttribute("cartTotalItems");
            session.removeAttribute("cartTotalAmount");

            // Chuyển hướng đến trang thành công
            resp.sendRedirect(req.getContextPath() + "/order-success?orderId=" + createdOrderId);
        } else {
            req.setAttribute("error", "Đã có lỗi xảy ra khi tạo đơn hàng. Vui lòng thử lại!");
            req.setAttribute("user", currentUser);
            req.setAttribute("cartItems", cart.values());
            req.getRequestDispatcher("/WEB-INF/views/web/checkout.jsp").forward(req, resp);
        }
    }

    private void showOrderSuccess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderIdStr = req.getParameter("orderId");
        if (orderIdStr != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                OrderModel_24110330 order = orderService.getOrderById(orderId);
                if (order != null) {
                    req.setAttribute("order", order);
                    req.getRequestDispatcher("/WEB-INF/views/web/order-success.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException ignored) {}
        }
        resp.sendRedirect(req.getContextPath() + "/home");
    }
}
