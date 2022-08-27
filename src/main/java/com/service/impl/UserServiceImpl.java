package com.service.impl;

import com.dao.UserDao;
import com.entity.User;
import com.exception.ServiceException;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao dao;

 @Override
    public User findUser(String login_name ,String password) throws ServiceException {

     User  user = dao.selectByLoginNameAndPassword(login_name, password);
    if( user == null){
        throw  new ServiceException("用户名name或者pass密码不存在");
    }
     return user;
    }

    @Override
    public void regist(User u) throws ServiceException {
        System.out.println(u);
        try{
            dao.insertUser(u);
        } catch(Exception e) {
            throw new ServiceException("该用户名已注册");
        }
    }

    @Override
    public List<String> getNames()throws ServiceException {
        String name;
        List<String> names= new ArrayList<>();
         List<User> users = dao.selectAllUsers();
        System.out.println("users=="+users);
        if (users !=null) {
            for (User user : users) {
                name = user.getLogin_name();
                names.add(name);
            }
        }
        return names;
    }

    @Override
    public List<String> getEmails()throws ServiceException {
        String email;
        List<String> emails= new ArrayList<>();
        List<User> users = dao.selectAllUsers();
        if (users !=null) {
            for (User user : users) {
                email = user.getEmail();
                emails.add(email);
            }
        }
        return emails;
    }

    @Override
    public List<User> getAllUser() throws ServiceException {
        return dao.selectAllUsers();
    }

    @Override
    public int updateUser(User u) throws ServiceException{
       return  dao.updateUser(u);
    }

    @Override
    public Date getLoginDateByUser(User u) throws ServiceException {
        return null;
    }
}
