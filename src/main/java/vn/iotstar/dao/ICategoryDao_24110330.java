package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.model.CategoryModel_24110330;
import vn.iotstar.model.CategoryVideoCountDto_24110330;

public interface ICategoryDao_24110330 {
    List<CategoryModel_24110330> findAll();
    CategoryModel_24110330 findById(int id);
    List<CategoryVideoCountDto_24110330> findCategoryVideoCounts();
}
