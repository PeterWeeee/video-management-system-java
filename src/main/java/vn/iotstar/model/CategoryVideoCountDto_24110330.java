package vn.iotstar.model;

import java.io.Serializable;

public class CategoryVideoCountDto_24110330 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int categoryId;
    private String categoryname;
    private String categorycode;
    private int videoCount;

    public CategoryVideoCountDto_24110330() {
    }

    public CategoryVideoCountDto_24110330(int categoryId, String categoryname, String categorycode, int videoCount) {
        this.categoryId = categoryId;
        this.categoryname = categoryname;
        this.categorycode = categorycode;
        this.videoCount = videoCount;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getCategorycode() {
        return categorycode;
    }

    public void setCategorycode(String categorycode) {
        this.categorycode = categorycode;
    }

    public int getVideoCount() {
        return videoCount;
    }

    public void setVideoCount(int videoCount) {
        this.videoCount = videoCount;
    }
}
