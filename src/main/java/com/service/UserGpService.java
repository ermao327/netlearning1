package com.service;

import com.entity.GoldPoints;
import com.entity.Resource;
import com.entity.User;
import com.github.pagehelper.PageInfo;
import com.vo.GoldPointsVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface UserGpService {
    public PageInfo<GoldPoints> findUserRecord(User user, Integer pageNo);
    public int updatePAG(int Uid, Integer points);
    public GoldPointsVo findGoldPointsVoByUid(int uid);
}
