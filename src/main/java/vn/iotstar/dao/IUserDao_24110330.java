package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.model.UserModel_24110330;

public interface IUserDao_24110330 {
    UserModel_24110330 findById(String username);
    UserModel_24110330 findByEmail(String email);
    void insert(UserModel_24110330 user);
    void update(UserModel_24110330 user);
    void delete(String username);
    List<UserModel_24110330> findAll();
    List<UserModel_24110330> findPage(int page, int pageSize);
    int countUsers();
    void updateActive(String username, boolean active);
}
