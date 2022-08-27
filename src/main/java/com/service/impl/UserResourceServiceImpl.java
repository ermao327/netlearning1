package com.service.impl;

import com.constant.Constant;
import com.dao.UserResouceDao;
import com.entity.Resource;
import com.entity.User;
import com.exception.ServiceException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.service.UserResourceService;
import com.vo.ResourceVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * date:2021/3/4
 * autor:JY
 */

@Service
public class UserResourceServiceImpl  implements UserResourceService {
    @Autowired
    UserResouceDao dao;
    @Override
    public PageInfo<ResourceVo> findResource(ResourceVo rs,int page) {
        PageHelper.startPage(page, Constant.PAGE_SIZE);
        List<ResourceVo> resource = dao.findResource(rs);
        //System.out.println(resource);
        if (null == resource) {
            throw new ServiceException("没有记录...");
        }
        return new PageInfo<ResourceVo>(resource);
    }

    @Override
    public int createResource(HttpSession session,Resource rs, File file) {
        String path = file.getPath();
        String name = file.getName();
        path = path.substring(path.indexOf("upload"),path.length());
        name=name.substring(name.indexOf('.')+1,name.length());
        String filetype=name;
        User user = (User)session.getAttribute(Constant.SESSION_USER);
        int uid=user.getId();
        Date date=new Date();
        rs.setPath(path);
        rs.setUser_id(uid);
        rs.setFile_type(filetype);
        rs.setCreate_date(date);
        System.out.println(rs);
        int i = dao.insertResource(rs);
        return i;
    }

    @Override
    public int isExsitResourceTitle(String title) {
        int res = dao.findResourceByTitle(title);
        return res;
    }

    @Override
    public int updateUserResource(HttpSession session,Resource resource,File file) throws IOException {
        long size = file.length();
        String path =file.getPath();
        path = path.substring(path.indexOf("upload"),path.length());
        String name = file.getName();
        name=name.substring(name.indexOf('.')+1,name.length());
        String filetype=name;
        User user = (User)session.getAttribute(Constant.SESSION_USER);
        int uid=user.getId();
        Date date=new Date();
        resource.setFile_size(size);
        resource.setPath(path);
        resource.setUser_id(uid);
        resource.setFile_type(filetype);
        resource.setCreate_date(date);
        int i = dao.updateResourceById(resource);
        return i;
    }

    @Override
    public int deleteResourceById(int id) {
        int i = dao.deleteResourceById(id);
        return i;
    }

    @Override
    public int updateUserResourceStatus(Resource rs) {
        int i=0;
        try {
            i = dao.updateResourceStatus(rs);
        }catch (Exception e){
            new ServiceException("查询数据库异常");
        }
        return i;
    }

    @Override
    public Resource findResourceByid(int id) {
        Resource res = dao.findById(id);
        return res;
    }


}
