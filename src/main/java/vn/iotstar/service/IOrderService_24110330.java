package vn.iotstar.service;

import java.util.List;
import vn.iotstar.model.CartItemModel_24110330;
import vn.iotstar.model.OrderModel_24110330;

public interface IOrderService_24110330 {
    int createOrderCOD(OrderModel_24110330 order, List<CartItemModel_24110330> cartItems);
    List<OrderModel_24110330> getOrdersByUsername(String username, String statusFilter);
    OrderModel_24110330 getOrderById(int orderId);
    boolean cancelOrder(int orderId, String username);
    int getOrderCount(String username, String status);
}
