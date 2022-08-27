package com.service.impl;

import com.constant.Constant;
import com.dao.UserGpDao;
import com.entity.GoldPoints;
import com.entity.User;
import com.exception.ServiceException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.vo.GoldPointsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.service.UserGpService;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * date:2021/3/3
 * autor:JY
 */

@Service
public class UserGpServiceImpl implements UserGpService {
    @Autowired
    UserGpDao dao;
    @Override
    public PageInfo<GoldPoints> findUserRecord(User user ,Integer pageNo) {
        PageHelper.startPage(pageNo, Constant.PAGE_SIZE);
        List<GoldPoints> list = dao.findRecord(user);
        if (null == list) {
            throw new ServiceException("没有记录...");
        }
        return new PageInfo<GoldPoints>(list);
    }
    @Transactional
    @Override
    public int updatePAG(int Uid, Integer points) {
        Integer id = Integer.valueOf(Uid);
        GoldPoints goldPoints = new GoldPoints(id,0,points/10,"积分换金币",new Date());
        GoldPoints goldPoints1 = new GoldPoints(id,-points,0,"积分换金币",new Date());
        int i = dao.addGoldById(goldPoints1);
        int j=dao.addGoldById(goldPoints);
        return i+j;
    }

    @Override
    public GoldPointsVo findGoldPointsVoByUid(int uid) {
        GoldPointsVo goldPointsVo = dao.getGoldPointsVo(uid);
        System.out.println(goldPointsVo);
        return goldPointsVo;
    }
}
