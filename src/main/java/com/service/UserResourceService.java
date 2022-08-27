package com.service;

import com.entity.Resource;
import com.entity.User;
import com.github.pagehelper.PageInfo;
import com.vo.ResourceVo;

import javax.jws.soap.SOAPBinding;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;

public interface UserResourceService {
    public PageInfo<ResourceVo> findResource(ResourceVo rs, int page);
    public int createResource(HttpSession session,Resource rs, File file);
    public int isExsitResourceTitle(String title);
    public int updateUserResource(HttpSession session,Resource resource,File file) throws IOException;
    public int deleteResourceById(int id);
    public int updateUserResourceStatus(Resource rs);
    public Resource findResourceByid(int id);
}
