package com.dao;

import com.entity.GoldPoints;
import com.entity.User;
import com.vo.GoldPointsVo;
import org.omg.CORBA.PUBLIC_MEMBER;

import java.util.List;

public interface UserGpDao {
    public List<GoldPoints> findRecord(User user);
    public GoldPointsVo getGoldPointsVo(int uid);
    public int addGoldById(GoldPoints goldPoints);


}
