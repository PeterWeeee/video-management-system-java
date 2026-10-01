package vn.iotstar.service.impl;

import java.util.List;

import vn.iotstar.dao.IUserDao_24110330;
import vn.iotstar.dao.impl.UserDaoImpl_24110330;
import vn.iotstar.model.UserModel_24110330;
import vn.iotstar.service.IUserService_24110330;

public class UserServiceImpl_24110330 implements IUserService_24110330 {

    private IUserDao_24110330 userDao = new UserDaoImpl_24110330();

    @Override
    public UserModel_24110330 login(String username, String password) {
        UserModel_24110330 user = userDao.findById(username);
        if (user != null && password != null && password.equals(user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public UserModel_24110330 getById(String username) {
        return userDao.findById(username);
    }

    @Override
    public UserModel_24110330 getByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public void insert(UserModel_24110330 user) {
        userDao.insert(user);
    }

    @Override
    public void update(UserModel_24110330 user) {
        userDao.update(user);
    }

    @Override
    public void delete(String username) {
        userDao.delete(username);
    }

    @Override
    public List<UserModel_24110330> getAll() {
        return userDao.findAll();
    }

    @Override
    public List<UserModel_24110330> getPage(int page, int pageSize) {
        return userDao.findPage(page, pageSize);
    }

    @Override
    public int countUsers() {
        return userDao.countUsers();
    }

    @Override
    public int getTotalPages(int pageSize) {
        int total = userDao.countUsers();
        return (int) Math.ceil((double) total / pageSize);
    }

    @Override
    public void activateUser(String username) {
        userDao.updateActive(username, true);
    }
}
