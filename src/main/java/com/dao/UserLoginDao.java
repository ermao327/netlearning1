package com.dao;

import com.entity.User;
import com.vo.UserBackVo;

import java.util.List;

public interface UserLoginDao {
    public User findUserByLogin_name(User user);
    public List<User> findAllUsers(UserBackVo u);
    public User findUserByid(int id);
    public int updateUserInfoByid(User user);
    public String findUsernameByid(int id);
    public int findUseridByUserName(String username);
}
