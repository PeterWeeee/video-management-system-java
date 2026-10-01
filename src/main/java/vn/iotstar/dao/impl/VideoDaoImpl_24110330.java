package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import vn.iotstar.connection.DBConnect_24110330;
import vn.iotstar.dao.IVideoDao_24110330;
import vn.iotstar.model.VideoModel_24110330;

public class VideoDaoImpl_24110330 implements IVideoDao_24110330 {

    @Override
    public VideoModel_24110330 findByIdWithDetails(String videoId) {
        String sql = "SELECT v.*, c.Categoryname, "
                   + "       (SELECT COUNT(*) FROM Shares s WHERE s.VideoId = v.VideoId) AS ShareCount, "
                   + "       (SELECT COUNT(*) FROM Favorites f WHERE f.VideoId = v.VideoId) AS LikeCount "
                   + "FROM Videos v "
                   + "LEFT JOIN Category c ON v.CategoryId = c.CategoryId "
                   + "WHERE v.VideoId = ?";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, videoId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToVideoWithDetails(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<VideoModel_24110330> findByCategoryIdPaged(int categoryId, int page, int pageSize) {
        List<VideoModel_24110330> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        if (offset < 0) offset = 0;

        String sql = "SELECT v.*, c.Categoryname, "
                   + "       (SELECT COUNT(*) FROM Shares s WHERE s.VideoId = v.VideoId) AS ShareCount, "
                   + "       (SELECT COUNT(*) FROM Favorites f WHERE f.VideoId = v.VideoId) AS LikeCount "
                   + "FROM Videos v "
                   + "LEFT JOIN Category c ON v.CategoryId = c.CategoryId "
                   + "WHERE v.CategoryId = ? "
                   + "ORDER BY v.VideoId ASC "
                   + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToVideoWithDetails(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countByCategoryId(int categoryId) {
        String sql = "SELECT COUNT(*) FROM Videos WHERE CategoryId = ?";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<VideoModel_24110330> findAllPaged(int page, int pageSize) {
        List<VideoModel_24110330> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        if (offset < 0) offset = 0;

        String sql = "SELECT v.*, c.Categoryname, "
                   + "       (SELECT COUNT(*) FROM Shares s WHERE s.VideoId = v.VideoId) AS ShareCount, "
                   + "       (SELECT COUNT(*) FROM Favorites f WHERE f.VideoId = v.VideoId) AS LikeCount "
                   + "FROM Videos v "
                   + "LEFT JOIN Category c ON v.CategoryId = c.CategoryId "
                   + "ORDER BY v.VideoId ASC "
                   + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToVideoWithDetails(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM Videos";
        try (Connection conn = DBConnect_24110330.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private VideoModel_24110330 mapResultSetToVideoWithDetails(ResultSet rs) throws Exception {
        VideoModel_24110330 video = new VideoModel_24110330();
        video.setVideoId(rs.getString("VideoId"));
        video.setTitle(rs.getString("Title"));
        video.setPoster(rs.getString("Poster"));
        video.setViews(rs.getObject("Views") != null ? rs.getInt("Views") : 0);
        video.setDescription(rs.getString("Description"));
        video.setActive(rs.getObject("Active") != null ? rs.getBoolean("Active") : true);
        video.setCategoryId(rs.getObject("CategoryId") != null ? rs.getInt("CategoryId") : null);
        video.setCategoryName(rs.getString("Categoryname"));
        video.setShareCount(rs.getInt("ShareCount"));
        video.setLikeCount(rs.getInt("LikeCount"));
        return video;
    }
}
