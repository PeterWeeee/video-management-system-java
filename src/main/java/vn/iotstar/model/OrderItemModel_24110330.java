package vn.iotstar.model;

import java.io.Serializable;

public class OrderItemModel_24110330 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int orderItemId;
    private int orderId;
    private String videoId;
    private double price;
    private int quantity;

    // Các trường hỗ trợ hiển thị
    private String videoTitle;
    private String videoPoster;

    public OrderItemModel_24110330() {
    }

    public OrderItemModel_24110330(int orderItemId, int orderId, String videoId, double price, int quantity) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.videoId = videoId;
        this.price = price;
        this.quantity = quantity;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getVideoTitle() {
        return videoTitle;
    }

    public void setVideoTitle(String videoTitle) {
        this.videoTitle = videoTitle;
    }

    public String getVideoPoster() {
        return videoPoster;
    }

    public void setVideoPoster(String videoPoster) {
        this.videoPoster = videoPoster;
    }

    public double getTotalPrice() {
        return price * quantity;
    }

    public String getFormattedPrice() {
        return String.format("%,.0f đ", price);
    }

    public String getFormattedTotalPrice() {
        return String.format("%,.0f đ", getTotalPrice());
    }
}
