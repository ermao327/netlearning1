package com.controller;

import com.constant.Constant;
import com.entity.GoldPoints;
import com.entity.User;
import com.github.pagehelper.PageInfo;
import com.mysql.cj.exceptions.CJOperationNotSupportedException;
import com.util.AjaxResult;
import com.util.StringUtil;
import com.vo.GoldPointsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.service.UserGpService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * date:2021/3/3
 * autor:JY
 */
//处理积分页面的展示 积分记录 兑换积分的类
@Controller
@RequestMapping("/gp")
public class UserGpController {
    @Autowired
    UserGpService service;
    //访问积分金币记录页面将该用户的积分金币信息对象存入session作用域
    @RequestMapping("/front_record.do")
    public String toRecordPage(HttpServletRequest request){
        User user =(User) request.getSession().getAttribute(Constant.SESSION_USER);
        GoldPointsVo goldPoint = service.findGoldPointsVoByUid(user.getId());
        System.out.println(goldPoint);
        request.getSession().setAttribute("userGpInfo",goldPoint);
        return "/front/front_record";
    }
    //查询该用户的所有积分金币记录
    @RequestMapping("/findAllRecords")
    @ResponseBody
    public AjaxResult toRecord( HttpServletRequest request){
        AjaxResult result = new AjaxResult(true, "查询成功", null);
        Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));
        System.out.println(pageNo);
        User user =(User)request.getSession().getAttribute(Constant.SESSION_USER);
        PageInfo<GoldPoints> userRecord = service.findUserRecord(user, pageNo);
        result.setObj(userRecord);
        return result;
    }
    //积分兑换金币功能判断该用户的积分是否足够
    @PostMapping("/exchangePoints")
    public String pointsToGold(String pointscount,HttpServletRequest request){
        Integer count = Integer.valueOf(pointscount);
        GoldPointsVo gpinfo =(GoldPointsVo) request.getSession().getAttribute("userGpInfo");
        if(gpinfo.getSum_point_count()<=0||count>gpinfo.getSum_point_count()){
            request.getSession().setAttribute("pointsmsg"," 余额不足");
        }else{
            request.getSession().removeAttribute("pointsmsg");
            User user=(User)request.getSession().getAttribute(Constant.SESSION_USER);
            int i = service.updatePAG(user.getId(), count);
            if(i!=2){
                request.getSession().setAttribute("pointsmsg","兑换失败");
            }
        }
        return "redirect:front_record.do";

    }
    //根据用户ID 查询该用户的积分金币总数
    @PostMapping("findFrontSumByUid.do")
    @ResponseBody
    public AjaxResult findFrontSumByUid(HttpServletRequest request){
       User user =(User) request.getSession().getAttribute(Constant.SESSION_USER);
       GoldPointsVo goldPointsVoByUid = service.findGoldPointsVoByUid(user.getId());
       AjaxResult ajaxResult = new AjaxResult(true, "查询成功", null);
       ajaxResult.setObj(goldPointsVoByUid);
        return ajaxResult;
    }
}
