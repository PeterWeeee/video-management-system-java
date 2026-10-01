package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.model.VideoModel_24110330;

public interface IVideoDao_24110330 {
    VideoModel_24110330 findByIdWithDetails(String videoId);
    List<VideoModel_24110330> findByCategoryIdPaged(int categoryId, int page, int pageSize);
    int countByCategoryId(int categoryId);
    List<VideoModel_24110330> findAllPaged(int page, int pageSize);
    int countAll();
}
