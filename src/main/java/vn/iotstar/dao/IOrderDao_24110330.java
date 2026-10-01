package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.model.OrderItemModel_24110330;
import vn.iotstar.model.OrderModel_24110330;

public interface IOrderDao_24110330 {
    int insertOrder(OrderModel_24110330 order);
    boolean insertOrderItem(OrderItemModel_24110330 item);
    List<OrderModel_24110330> findOrdersByUsername(String username, String statusFilter);
    OrderModel_24110330 findOrderById(int orderId);
    List<OrderItemModel_24110330> findOrderItemsByOrderId(int orderId);
    boolean updateOrderStatus(int orderId, String newStatus);
    int countOrdersByStatus(String username, String status);
}
