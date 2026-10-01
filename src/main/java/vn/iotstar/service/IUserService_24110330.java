package vn.iotstar.service;

import java.util.List;
import vn.iotstar.model.UserModel_24110330;

public interface IUserService_24110330 {
    UserModel_24110330 login(String username, String password);
    UserModel_24110330 getById(String username);
    UserModel_24110330 getByEmail(String email);
    void insert(UserModel_24110330 user);
    void update(UserModel_24110330 user);
    void delete(String username);
    List<UserModel_24110330> getAll();
    List<UserModel_24110330> getPage(int page, int pageSize);
    int countUsers();
    int getTotalPages(int pageSize);
    void activateUser(String username);
}
