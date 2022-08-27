package com.service.impl;

import com.dao.ResourceDao;
import com.dao.UserDao;
import com.dao.UserGpDao;
import com.entity.GoldPoints;
import com.entity.Resource;
import com.entity.User;
import com.service.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResourceServiceImpl implements ResourceService {

    @Autowired
    ResourceDao dao;
    @Autowired
    UserGpDao gpdao;
    @Override
    public Resource findResourceByResourceId(Integer resourceId) {
        return dao.selectResourceByResourceId(resourceId);
    }

    @Override
    public User findUserByNameAndPass(String userName, String passWord) {
        return dao.selectUserByNameAndPass(userName,passWord);
    }

    @Override
    public GoldPoints findGoldPointsByUserId(Integer id) {
        return dao.selectGoldPointsByUserId(id);
    }

    @Override
    public int modifyPointOrGold(GoldPoints goldPoints) {
        return gpdao.addGoldById(goldPoints);
    }
}
