package com.dao;

import com.entity.GoldPoints;

import com.entity.User;
import org.springframework.stereotype.Repository;

import java.util.Date;


public interface GoldPointDao {
    public Date selectLastLoginDate(int user_id);
    public  int insertGP(GoldPoints gp);

}
