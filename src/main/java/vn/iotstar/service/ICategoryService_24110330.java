package vn.iotstar.service;

import java.util.List;
import vn.iotstar.model.CategoryModel_24110330;
import vn.iotstar.model.CategoryVideoCountDto_24110330;

public interface ICategoryService_24110330 {
    List<CategoryModel_24110330> getAll();
    CategoryModel_24110330 getById(int id);
    List<CategoryVideoCountDto_24110330> getCategoryVideoCounts();
}
