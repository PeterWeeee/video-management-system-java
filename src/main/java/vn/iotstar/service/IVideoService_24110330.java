package vn.iotstar.service;

import java.util.List;
import vn.iotstar.model.VideoModel_24110330;

public interface IVideoService_24110330 {
    VideoModel_24110330 getVideoDetail(String videoId);
    List<VideoModel_24110330> getVideosByCategoryPaged(int categoryId, int page, int pageSize);
    int countVideosByCategory(int categoryId);
    int getTotalPagesByCategory(int categoryId, int pageSize);
    List<VideoModel_24110330> getAllPaged(int page, int pageSize);
    int countAll();
}
