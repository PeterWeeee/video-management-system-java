package vn.iotstar.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class OrderModel_24110330 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int orderId;
    private String username;
    private Timestamp orderDate;
    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;
    private String paymentMethod;
    private double totalAmount;
    private String status;
    private String notes;

    private List<OrderItemModel_24110330> items = new ArrayList<>();

    public OrderModel_24110330() {
        this.paymentMethod = "COD";
        this.status = "Đơn hàng mới";
    }

    public OrderModel_24110330(int orderId, String username, Timestamp orderDate, String receiverName,
            String receiverPhone, String receiverAddress, String paymentMethod, double totalAmount, String status,
            String notes) {
        this.orderId = orderId;
        this.username = username;
        this.orderDate = orderDate;
        this.receiverName = receiverName;
        this.receiverPhone = receiverPhone;
        this.receiverAddress = receiverAddress;
        this.paymentMethod = paymentMethod;
        this.totalAmount = totalAmount;
        this.status = status;
        this.notes = notes;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public List<OrderItemModel_24110330> getItems() {
        return items;
    }

    public void setItems(List<OrderItemModel_24110330> items) {
        this.items = items;
    }

    public String getFormattedTotalAmount() {
        return String.format("%,.0f đ", totalAmount);
    }

    public String getFormattedOrderDate() {
        if (orderDate != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            return sdf.format(orderDate);
        }
        return "";
    }

    public String getStatusBadgeClass() {
        if (status == null) return "bg-secondary";
        return switch (status.trim()) {
            case "Đơn hàng mới" -> "bg-primary";
            case "Đã xác nhận" -> "bg-info text-dark";
            case "Chuẩn bị hàng" -> "bg-warning text-dark";
            case "Vận chuyển" -> "bg-indigo text-white";
            case "Giao hàng" -> "bg-cyan text-dark";
            case "Đã giao" -> "bg-success";
            case "Đơn hàng hủy" -> "bg-danger";
            case "Đơn hàng hoàn" -> "bg-secondary";
            default -> "bg-light text-dark";
        };
    }
}
