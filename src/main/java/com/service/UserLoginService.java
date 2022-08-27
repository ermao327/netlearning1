package com.service;

import com.entity.User;
import com.exception.ServiceException;
import com.github.pagehelper.PageInfo;
import com.vo.UserBackVo;

public interface UserLoginService {
    public User findUserBylogin_name(User user)throws ServiceException;
    public PageInfo<User> findAllUser(int pageNo, UserBackVo u)throws ServiceException;
    public User findUserById(int id)throws ServiceException;
    public int updateUserInfo(User u)throws ServiceException;
    public int findUidByName(String name);
 }
