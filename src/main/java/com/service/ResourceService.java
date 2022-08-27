package com.service;

import com.entity.GoldPoints;
import com.entity.Resource;
import com.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;


public interface ResourceService {
    public Resource findResourceByResourceId(Integer resourceId);
    public User findUserByNameAndPass(String userName,String passWord);
    public GoldPoints findGoldPointsByUserId(Integer id);
    public int modifyPointOrGold(GoldPoints goldPoints);
}
