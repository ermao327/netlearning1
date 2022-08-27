package com.service.impl;

import com.constant.Constant;
import com.dao.UserLoginDao;
import com.entity.GoldPoints;
import com.entity.User;
import com.exception.ServiceException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.service.UserLoginService;
import com.service.UserResourceService;
import com.vo.UserBackVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * date:2021/3/8
 * autor:JY
 */

@Service
public class UserLoginServiceImpl implements UserLoginService{
    @Autowired
    UserLoginDao dao;
    @Override
    public User findUserBylogin_name(User u) throws ServiceException {
        User user = dao.findUserByLogin_name(u);
        if(user==null){
            throw new ServiceException("用户名/密码错误");
        }
        return user;
    }

    @Override
    public PageInfo<User> findAllUser(int pageNo, UserBackVo u) throws ServiceException {
        PageHelper.startPage(pageNo, 2);
        List<User> list = dao.findAllUsers(u);
        if (null == list) {
            throw new ServiceException("没有记录...");
        }
        return new PageInfo<User>(list);
    }

    @Override
    public User findUserById(int id) throws ServiceException {
        User user = dao.findUserByid(id);
        if(user==null){
            throw new ServiceException("没有记录...");
        }
        return user;
    }

    @Override
    public int updateUserInfo(User u) throws ServiceException {
        int i = dao.updateUserInfoByid(u);
        if(i==0){
            throw new ServiceException("修改用户信息失败");
        }
        return i;
    }

    @Override
    public int findUidByName(String name) {
        int userid = dao.findUseridByUserName(name);
        return userid;
    }

}
