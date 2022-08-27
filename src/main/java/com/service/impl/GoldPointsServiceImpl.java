package com.service.impl;

import com.dao.GoldPointDao;
import com.entity.GoldPoints;
import com.entity.User;
import com.exception.DataAccessException;
import com.exception.ServiceException;
import com.service.GoldPointsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class GoldPointsServiceImpl implements GoldPointsService {

    @Autowired
    GoldPointDao gpDao;

    @Override
    public Date getLastLoginDate(User u){
        Date date = null;
        try {
            date = gpDao.selectLastLoginDate(u.getId());
        } catch (Exception e) {
            e.printStackTrace();
            throw new DataAccessException("查询最近一次签到记录失败");
        }
        return date;
    }

    @Override
    public int insertGoldPoint(GoldPoints gp) {
        System.out.println(gp);
        int i = 0;
        try {
            i = gpDao.insertGP(gp);
        } catch (Exception e) {

            e.printStackTrace();
            throw  new DataAccessException("数据插入异常");
        }
        if (i != 1){
            throw new ServiceException("插入签到记录失败");
        }
        return i;
    }


}
