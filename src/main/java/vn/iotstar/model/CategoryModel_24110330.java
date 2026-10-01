package vn.iotstar.model;

import java.io.Serializable;

public class CategoryModel_24110330 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int categoryId;
    private String categoryname;
    private String categorycode;
    private String images;
    private Boolean status;

    public CategoryModel_24110330() {
    }

    public CategoryModel_24110330(int categoryId, String categoryname, String categorycode, String images,
            Boolean status) {
        this.categoryId = categoryId;
        this.categoryname = categoryname;
        this.categorycode = categorycode;
        this.images = images;
        this.status = status;
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

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "CategoryModel_24110330 [categoryId=" + categoryId + ", categoryname=" + categoryname + "]";
    }
}
