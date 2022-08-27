package com.dao;

import com.entity.User;
import com.exception.ServiceException;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;


import java.util.Date;
import java.util.List;


public interface UserDao {
   public User selectByLoginNameAndPassword(@Param("login_name") String login_name ,@Param("password") String password);

    public void insertUser(User u);

    public List<User> selectAllUsers();

    public int updateUser(User u);

}
