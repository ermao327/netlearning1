package com.dao;

import com.entity.GoldPoints;
import com.entity.Resource;
import com.entity.User;
import org.apache.ibatis.annotations.Param;

public interface ResourceDao {
    //根据resourceId查询资源
    public Resource selectResourceByResourceId(Integer resourceId);
    //根据用户名密码查询用户
    public User selectUserByNameAndPass(@Param("userName") String userName,@Param("passWord") String passWord);
    //根据用户id查询积分金币表
    public GoldPoints selectGoldPointsByUserId(Integer id);

    //根据id修改积分或金币
    public int updatePointOrGold(@Param("id") Integer id,@Param("point")Integer point,@Param("gold")Integer gold);

}
