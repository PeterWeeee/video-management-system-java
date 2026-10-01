package vn.iotstar.model;

import java.io.Serializable;

public class VideoModel_24110330 implements Serializable {
    private static final long serialVersionUID = 1L;

    private String videoId;
    private String title;
    private String poster;
    private Integer views;
    private String description;
    private Boolean active;
    private Integer categoryId;
    private double price = 150000;
    private int stock = 10;

    // Các trường hỗ trợ hiển thị giao diện Câu 4 và Câu 5
    private String categoryName;
    private int shareCount;
    private int likeCount;

    public VideoModel_24110330() {
    }

    public VideoModel_24110330(String videoId, String title, String poster, Integer views, String description,
            Boolean active, Integer categoryId) {
        this.videoId = videoId;
        this.title = title;
        this.poster = poster;
        this.views = views;
        this.description = description;
        this.active = active;
        this.categoryId = categoryId;
    }

    public VideoModel_24110330(String videoId, String title, String poster, Integer views, String description,
            Boolean active, Integer categoryId, double price, int stock) {
        this.videoId = videoId;
        this.title = title;
        this.poster = poster;
        this.views = views;
        this.description = description;
        this.active = active;
        this.categoryId = categoryId;
        this.price = price;
        this.stock = stock;
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

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getShareCount() {
        return shareCount;
    }

    public void setShareCount(int shareCount) {
        this.shareCount = shareCount;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
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

    public String getFormattedPrice() {
        return String.format("%,.0f đ", price);
    }

    @Override
    public String toString() {
        return "VideoModel_24110330 [videoId=" + videoId + ", title=" + title + ", categoryName=" + categoryName
                + ", views=" + views + ", price=" + price + ", stock=" + stock + "]";
    }
}
