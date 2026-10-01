package vn.iotstar.service.impl;

import java.util.List;

import vn.iotstar.dao.ICategoryDao_24110330;
import vn.iotstar.dao.impl.CategoryDaoImpl_24110330;
import vn.iotstar.model.CategoryModel_24110330;
import vn.iotstar.model.CategoryVideoCountDto_24110330;
import vn.iotstar.service.ICategoryService_24110330;

public class CategoryServiceImpl_24110330 implements ICategoryService_24110330 {

    private ICategoryDao_24110330 categoryDao = new CategoryDaoImpl_24110330();

    @Override
    public List<CategoryModel_24110330> getAll() {
        return categoryDao.findAll();
    }

    @Override
    public CategoryModel_24110330 getById(int id) {
        return categoryDao.findById(id);
    }

    @Override
    public List<CategoryVideoCountDto_24110330> getCategoryVideoCounts() {
        return categoryDao.findCategoryVideoCounts();
    }
}
