package com.dao;

import com.entity.Praise;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface PraiseDao {
    public Praise selectPraise(@Param("uid") Integer uid, @Param("commentId") Integer commentId);
    public int insertPraise(@Param("uid") Integer uid, @Param("commentId")Integer commentId, @Param("createDate") Date createDate);
    public int deletePraise(@Param("uid") Integer uid, @Param("commentId")Integer commentId);
}
