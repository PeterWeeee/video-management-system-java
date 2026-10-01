package vn.iotstar.service.impl;

import java.util.List;

import vn.iotstar.dao.IVideoDao_24110330;
import vn.iotstar.dao.impl.VideoDaoImpl_24110330;
import vn.iotstar.model.VideoModel_24110330;
import vn.iotstar.service.IVideoService_24110330;

public class VideoServiceImpl_24110330 implements IVideoService_24110330 {

    private IVideoDao_24110330 videoDao = new VideoDaoImpl_24110330();

    @Override
    public VideoModel_24110330 getVideoDetail(String videoId) {
        return videoDao.findByIdWithDetails(videoId);
    }

    @Override
    public List<VideoModel_24110330> getVideosByCategoryPaged(int categoryId, int page, int pageSize) {
        return videoDao.findByCategoryIdPaged(categoryId, page, pageSize);
    }

    @Override
    public int countVideosByCategory(int categoryId) {
        return videoDao.countByCategoryId(categoryId);
    }

    @Override
    public int getTotalPagesByCategory(int categoryId, int pageSize) {
        int total = videoDao.countByCategoryId(categoryId);
        return (int) Math.ceil((double) total / pageSize);
    }

    @Override
    public List<VideoModel_24110330> getAllPaged(int page, int pageSize) {
        return videoDao.findAllPaged(page, pageSize);
    }

    @Override
    public int countAll() {
        return videoDao.countAll();
    }
}
