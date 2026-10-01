package vn.iotstar.service.impl;

import java.util.List;

import vn.iotstar.dao.IOrderDao_24110330;
import vn.iotstar.dao.IVideoDao_24110330;
import vn.iotstar.dao.impl.OrderDaoImpl_24110330;
import vn.iotstar.dao.impl.VideoDaoImpl_24110330;
import vn.iotstar.model.CartItemModel_24110330;
import vn.iotstar.model.OrderItemModel_24110330;
import vn.iotstar.model.OrderModel_24110330;
import vn.iotstar.service.IOrderService_24110330;

public class OrderServiceImpl_24110330 implements IOrderService_24110330 {

    private IOrderDao_24110330 orderDao = new OrderDaoImpl_24110330();
    private IVideoDao_24110330 videoDao = new VideoDaoImpl_24110330();

    @Override
    public int createOrderCOD(OrderModel_24110330 order, List<CartItemModel_24110330> cartItems) {
        if (cartItems == null || cartItems.isEmpty()) {
            return -1;
        }

        // Tính tổng tiền từ giỏ hàng
        double total = 0;
        for (CartItemModel_24110330 item : cartItems) {
            total += item.getTotalPrice();
        }
        order.setTotalAmount(total);
        order.setPaymentMethod("COD");
        order.setStatus("Đơn hàng mới");

        int orderId = orderDao.insertOrder(order);
        if (orderId > 0) {
            for (CartItemModel_24110330 cItem : cartItems) {
                OrderItemModel_24110330 oItem = new OrderItemModel_24110330();
                oItem.setOrderId(orderId);
                oItem.setVideoId(cItem.getVideoId());
                oItem.setPrice(cItem.getPrice());
                oItem.setQuantity(cItem.getQuantity());

                orderDao.insertOrderItem(oItem);

                // Trừ số lượng tồn kho của video tương ứng
                videoDao.updateStock(cItem.getVideoId(), cItem.getQuantity());
            }
            return orderId;
        }
        return -1;
    }

    @Override
    public List<OrderModel_24110330> getOrdersByUsername(String username, String statusFilter) {
        List<OrderModel_24110330> orders = orderDao.findOrdersByUsername(username, statusFilter);
        for (OrderModel_24110330 order : orders) {
            order.setItems(orderDao.findOrderItemsByOrderId(order.getOrderId()));
        }
        return orders;
    }

    @Override
    public OrderModel_24110330 getOrderById(int orderId) {
        return orderDao.findOrderById(orderId);
    }

    @Override
    public boolean cancelOrder(int orderId, String username) {
        OrderModel_24110330 order = orderDao.findOrderById(orderId);
        if (order != null && order.getUsername().equals(username)) {
            // Chỉ cho phép hủy khi đơn hàng ở trạng thái 'Đơn hàng mới'
            if ("Đơn hàng mới".equalsIgnoreCase(order.getStatus())) {
                boolean updated = orderDao.updateOrderStatus(orderId, "Đơn hàng hủy");
                if (updated) {
                    // Hoàn lại tồn kho cho từng video đã đặt
                    List<OrderItemModel_24110330> items = orderDao.findOrderItemsByOrderId(orderId);
                    for (OrderItemModel_24110330 it : items) {
                        videoDao.updateStock(it.getVideoId(), -it.getQuantity()); // trừ số âm = cộng lại
                    }
                }
                return updated;
            }
        }
        return false;
    }

    @Override
    public int getOrderCount(String username, String status) {
        return orderDao.countOrdersByStatus(username, status);
    }
}
