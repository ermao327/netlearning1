package com.service;

import com.entity.Praise;
import org.apache.ibatis.annotations.Param;

import java.util.Date;


public interface PraiseService {
    public Praise findPraise(Integer uid, Integer commentId);
    public int addPraise(Integer uid, Integer commentId, Date createDate);
    public int delPraise(Integer uid,Integer commentId);
}
