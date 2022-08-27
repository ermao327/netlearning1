package com.dao;

import com.entity.Resource;
import com.vo.ResourceVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface UserResouceDao {
    public List<ResourceVo> findResource(ResourceVo rs);
    public int insertResource(Resource resource);
    public int findResourceByTitle(String title);
    public int updateResourceById(Resource resource);
    public int deleteResourceById(int id);
    public int  updateResourceStatus(Resource rs);
    public Resource findById(int id);
}

