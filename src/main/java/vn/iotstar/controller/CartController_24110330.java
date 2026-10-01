package vn.iotstar.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.CartItemModel_24110330;
import vn.iotstar.model.VideoModel_24110330;
import vn.iotstar.service.IVideoService_24110330;
import vn.iotstar.service.impl.VideoServiceImpl_24110330;

@WebServlet(urlPatterns = { "/cart" })
public class CartController_24110330 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IVideoService_24110330 videoService = new VideoServiceImpl_24110330();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "view";
        }

        switch (action) {
            case "add":
                addToCart(req, resp);
                break;
            case "update":
                updateCart(req, resp);
                break;
            case "remove":
                removeFromCart(req, resp);
                break;
            case "clear":
                clearCart(req, resp);
                break;
            case "view":
            default:
                viewCart(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @SuppressWarnings("unchecked")
    private Map<String, CartItemModel_24110330> getCartFromSession(HttpSession session) {
        Map<String, CartItemModel_24110330> cart = (Map<String, CartItemModel_24110330>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private void updateSessionCartCount(HttpSession session, Map<String, CartItemModel_24110330> cart) {
        int totalItems = 0;
        double totalAmount = 0;
        for (CartItemModel_24110330 item : cart.values()) {
            totalItems += item.getQuantity();
            totalAmount += item.getTotalPrice();
        }
        session.setAttribute("cartTotalItems", totalItems);
        session.setAttribute("cartTotalAmount", totalAmount);
    }

    private void viewCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Map<String, CartItemModel_24110330> cart = getCartFromSession(session);
        updateSessionCartCount(session, cart);

        double totalAmount = 0;
        for (CartItemModel_24110330 item : cart.values()) {
            totalAmount += item.getTotalPrice();
        }

        req.setAttribute("cartItems", cart.values());
        req.setAttribute("totalAmount", totalAmount);
        req.setAttribute("formattedTotalAmount", String.format("%,.0f đ", totalAmount));
        req.getRequestDispatcher("/WEB-INF/views/web/cart.jsp").forward(req, resp);
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String videoId = req.getParameter("videoId");
        int quantity = 1;
        try {
            if (req.getParameter("quantity") != null) {
                quantity = Integer.parseInt(req.getParameter("quantity"));
            }
        } catch (NumberFormatException ignored) {}

        if (videoId == null || videoId.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        VideoModel_24110330 video = videoService.getVideoDetail(videoId);
        if (video == null) {
            resp.sendRedirect(req.getContextPath() + "/cart?error=" + URLEncoder.encode("Video không tồn tại!", StandardCharsets.UTF_8));
            return;
        }

        if (video.getStock() <= 0) {
            resp.sendRedirect(req.getContextPath() + "/cart?error=" + URLEncoder.encode("Video này hiện đã hết hàng!", StandardCharsets.UTF_8));
            return;
        }

        HttpSession session = req.getSession();
        Map<String, CartItemModel_24110330> cart = getCartFromSession(session);

        String message = "";
        if (cart.containsKey(videoId)) {
            CartItemModel_24110330 existingItem = cart.get(videoId);
            int newQty = existingItem.getQuantity() + quantity;
            if (newQty > video.getStock()) {
                existingItem.setQuantity(video.getStock());
                message = "Đã cập nhật đến số lượng tối đa hiện có (" + video.getStock() + ")!";
            } else {
                existingItem.setQuantity(newQty);
                message = "Đã cập nhật số lượng trong giỏ hàng!";
            }
        } else {
            int finalQty = Math.min(quantity, video.getStock());
            CartItemModel_24110330 newItem = new CartItemModel_24110330(
                video.getVideoId(),
                video.getTitle(),
                video.getPoster(),
                video.getPrice(),
                video.getStock(),
                finalQty
            );
            cart.put(videoId, newItem);
            message = "Đã thêm vào giỏ hàng thành công!";
        }

        updateSessionCartCount(session, cart);

        // Chuyển hướng đến giỏ hàng kèm thông báo
        resp.sendRedirect(req.getContextPath() + "/cart?msg=" + URLEncoder.encode(message, StandardCharsets.UTF_8));
    }

    private void updateCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String videoId = req.getParameter("videoId");
        int quantity = 1;
        try {
            quantity = Integer.parseInt(req.getParameter("quantity"));
        } catch (NumberFormatException ignored) {}

        HttpSession session = req.getSession();
        Map<String, CartItemModel_24110330> cart = getCartFromSession(session);

        String message = "";
        String error = "";

        if (cart.containsKey(videoId)) {
            CartItemModel_24110330 item = cart.get(videoId);
            if (quantity <= 0) {
                cart.remove(videoId);
                message = "Đã xóa sản phẩm khỏi giỏ hàng!";
            } else if (quantity > item.getStock()) {
                item.setQuantity(item.getStock());
                error = "Số lượng yêu cầu vượt quá tồn kho. Đã tự động điều chỉnh về tối đa (" + item.getStock() + ")!";
            } else {
                item.setQuantity(quantity);
                message = "Cập nhật số lượng thành công!";
            }
        }

        updateSessionCartCount(session, cart);

        if (!error.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart?error=" + URLEncoder.encode(error, StandardCharsets.UTF_8));
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart?msg=" + URLEncoder.encode(message, StandardCharsets.UTF_8));
        }
    }

    private void removeFromCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String videoId = req.getParameter("videoId");
        HttpSession session = req.getSession();
        Map<String, CartItemModel_24110330> cart = getCartFromSession(session);

        if (videoId != null && cart.containsKey(videoId)) {
            cart.remove(videoId);
        }

        updateSessionCartCount(session, cart);
        resp.sendRedirect(req.getContextPath() + "/cart?msg=" + URLEncoder.encode("Đã xóa sản phẩm khỏi giỏ hàng!", StandardCharsets.UTF_8));
    }

    private void clearCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.removeAttribute("cart");
        session.removeAttribute("cartTotalItems");
        session.removeAttribute("cartTotalAmount");
        resp.sendRedirect(req.getContextPath() + "/cart?msg=" + URLEncoder.encode("Đã làm trống giỏ hàng!", StandardCharsets.UTF_8));
    }
}
