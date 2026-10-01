package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import vn.iotstar.connection.DBConnect_24110330;
import vn.iotstar.dao.ICategoryDao_24110330;
import vn.iotstar.model.CategoryModel_24110330;
import vn.iotstar.model.CategoryVideoCountDto_24110330;

public class CategoryDaoImpl_24110330 implements ICategoryDao_24110330 {

    @Override
    public List<CategoryModel_24110330> findAll() {
        List<CategoryModel_24110330> list = new ArrayList<>();
        String sql = "SELECT * FROM Category ORDER BY CategoryId ASC";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CategoryModel_24110330 cat = new CategoryModel_24110330();
                cat.setCategoryId(rs.getInt("CategoryId"));
                cat.setCategoryname(rs.getString("Categoryname"));
                cat.setCategorycode(rs.getString("Categorycode"));
                cat.setImages(rs.getString("Images"));
                cat.setStatus(rs.getObject("Status") != null ? rs.getBoolean("Status") : null);
                list.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public CategoryModel_24110330 findById(int id) {
        String sql = "SELECT * FROM Category WHERE CategoryId = ?";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CategoryModel_24110330 cat = new CategoryModel_24110330();
                    cat.setCategoryId(rs.getInt("CategoryId"));
                    cat.setCategoryname(rs.getString("Categoryname"));
                    cat.setCategorycode(rs.getString("Categorycode"));
                    cat.setImages(rs.getString("Images"));
                    cat.setStatus(rs.getObject("Status") != null ? rs.getBoolean("Status") : null);
                    return cat;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<CategoryVideoCountDto_24110330> findCategoryVideoCounts() {
        List<CategoryVideoCountDto_24110330> list = new ArrayList<>();
        String sql = "SELECT c.CategoryId, c.Categoryname, c.Categorycode, COUNT(v.VideoId) AS VideoCount "
                   + "FROM Category c "
                   + "LEFT JOIN Videos v ON c.CategoryId = v.CategoryId "
                   + "GROUP BY c.CategoryId, c.Categoryname, c.Categorycode "
                   + "ORDER BY c.CategoryId ASC";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CategoryVideoCountDto_24110330 dto = new CategoryVideoCountDto_24110330();
                dto.setCategoryId(rs.getInt("CategoryId"));
                dto.setCategoryname(rs.getString("Categoryname"));
                dto.setCategorycode(rs.getString("Categorycode"));
                dto.setVideoCount(rs.getInt("VideoCount"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
