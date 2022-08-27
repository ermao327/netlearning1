package com.service.impl;

import com.dao.PraiseDao;
import com.entity.Praise;
import com.service.PraiseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class PraiseServiceImpl implements PraiseService {

    @Autowired
    PraiseDao dao;

    @Override
    public Praise findPraise(Integer uid, Integer commentId) {
        return dao.selectPraise(uid,commentId);
    }

    @Override
    public int addPraise(Integer uid, Integer commentId, Date createDate) {
        return dao.insertPraise(uid,commentId,createDate);
    }

    @Override
    public int delPraise(Integer uid, Integer commentId) {
        return dao.deletePraise(uid,commentId);
    }
}
