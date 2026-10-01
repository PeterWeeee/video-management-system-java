package vn.iotstar.model;

import java.io.Serializable;

public class CartItemModel_24110330 implements Serializable {
    private static final long serialVersionUID = 1L;

    private String videoId;
    private String title;
    private String poster;
    private double price;
    private int stock;
    private int quantity;

    public CartItemModel_24110330() {
    }

    public CartItemModel_24110330(String videoId, String title, String poster, double price, int stock, int quantity) {
        this.videoId = videoId;
        this.title = title;
        this.poster = poster;
        this.price = price;
        this.stock = stock;
        this.quantity = quantity;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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
