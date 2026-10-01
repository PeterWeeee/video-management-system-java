package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import vn.iotstar.connection.DBConnect_24110330;
import vn.iotstar.dao.IOrderDao_24110330;
import vn.iotstar.model.OrderItemModel_24110330;
import vn.iotstar.model.OrderModel_24110330;

public class OrderDaoImpl_24110330 implements IOrderDao_24110330 {

    @Override
    public int insertOrder(OrderModel_24110330 order) {
        String sql = "INSERT INTO Orders (Username, OrderDate, ReceiverName, ReceiverPhone, ReceiverAddress, PaymentMethod, TotalAmount, Status, Notes) "
                   + "VALUES (?, GETDATE(), ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, order.getUsername());
            ps.setString(2, order.getReceiverName());
            ps.setString(3, order.getReceiverPhone());
            ps.setString(4, order.getReceiverAddress());
            ps.setString(5, order.getPaymentMethod() != null ? order.getPaymentMethod() : "COD");
            ps.setDouble(6, order.getTotalAmount());
            ps.setString(7, order.getStatus() != null ? order.getStatus() : "Đơn hàng mới");
            ps.setString(8, order.getNotes());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public boolean insertOrderItem(OrderItemModel_24110330 item) {
        String sql = "INSERT INTO OrderItems (OrderId, VideoId, Price, Quantity) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, item.getOrderId());
            ps.setString(2, item.getVideoId());
            ps.setDouble(3, item.getPrice());
            ps.setInt(4, item.getQuantity());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<OrderModel_24110330> findOrdersByUsername(String username, String statusFilter) {
        List<OrderModel_24110330> list = new ArrayList<>();
        boolean hasFilter = statusFilter != null && !statusFilter.trim().isEmpty() && !statusFilter.equalsIgnoreCase("all");

        String sql = hasFilter 
            ? "SELECT * FROM Orders WHERE Username = ? AND Status = ? ORDER BY OrderDate DESC"
            : "SELECT * FROM Orders WHERE Username = ? ORDER BY OrderDate DESC";

        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            if (hasFilter) {
                ps.setString(2, statusFilter.trim());
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderModel_24110330 order = mapResultSetToOrder(rs);
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public OrderModel_24110330 findOrderById(int orderId) {
        String sql = "SELECT * FROM Orders WHERE OrderId = ?";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    OrderModel_24110330 order = mapResultSetToOrder(rs);
                    order.setItems(findOrderItemsByOrderId(orderId));
                    return order;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<OrderItemModel_24110330> findOrderItemsByOrderId(int orderId) {
        List<OrderItemModel_24110330> items = new ArrayList<>();
        String sql = "SELECT oi.*, v.Title, v.Poster "
                   + "FROM OrderItems oi "
                   + "LEFT JOIN Videos v ON oi.VideoId = v.VideoId "
                   + "WHERE oi.OrderId = ?";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItemModel_24110330 item = new OrderItemModel_24110330();
                    item.setOrderItemId(rs.getInt("OrderItemId"));
                    item.setOrderId(rs.getInt("OrderId"));
                    item.setVideoId(rs.getString("VideoId"));
                    item.setPrice(rs.getDouble("Price"));
                    item.setQuantity(rs.getInt("Quantity"));
                    item.setVideoTitle(rs.getString("Title"));
                    item.setVideoPoster(rs.getString("Poster"));
                    items.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

    @Override
    public boolean updateOrderStatus(int orderId, String newStatus) {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderId = ?";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public int countOrdersByStatus(String username, String status) {
        String sql = (status == null || status.equalsIgnoreCase("all"))
            ? "SELECT COUNT(*) FROM Orders WHERE Username = ?"
            : "SELECT COUNT(*) FROM Orders WHERE Username = ? AND Status = ?";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            if (status != null && !status.equalsIgnoreCase("all")) {
                ps.setString(2, status);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private OrderModel_24110330 mapResultSetToOrder(ResultSet rs) throws Exception {
        OrderModel_24110330 order = new OrderModel_24110330();
        order.setOrderId(rs.getInt("OrderId"));
        order.setUsername(rs.getString("Username"));
        order.setOrderDate(rs.getTimestamp("OrderDate"));
        order.setReceiverName(rs.getString("ReceiverName"));
        order.setReceiverPhone(rs.getString("ReceiverPhone"));
        order.setReceiverAddress(rs.getString("ReceiverAddress"));
        order.setPaymentMethod(rs.getString("PaymentMethod"));
        order.setTotalAmount(rs.getDouble("TotalAmount"));
        order.setStatus(rs.getString("Status"));
        order.setNotes(rs.getString("Notes"));
        return order;
    }
}
