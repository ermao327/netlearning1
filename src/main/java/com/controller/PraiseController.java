package com.controller;

import com.constant.Constant;
import com.entity.Comment;
import com.entity.Praise;
import com.entity.User;
import com.service.PraiseService;
import com.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/praise")
public class PraiseController {

    @Autowired
    PraiseService service;

    @RequestMapping("/tgPraise.do")
    @ResponseBody
    public AjaxResult selPraise(@RequestParam("comment_id") Integer commentId, HttpSession session){
        User user = (User)session.getAttribute(Constant.SESSION_USER);
        Integer uid = user.getId();
        System.out.println("userId="+uid+",commentId="+commentId);

        Praise praise = service.findPraise(uid, commentId);
        System.out.println("prise="+praise);

        AjaxResult ajaxResult = null;
        if (praise==null){  //查询数据库没有该对象，则增加点赞，返回ture
            System.out.println("等于null了,进入增加点赞");
            int i = service.addPraise(uid, commentId, new Date());
            if (i==1){
            return new AjaxResult(true,null,true);
            }
        }
        service.delPraise(uid, commentId);
        return new AjaxResult(false,null,false);
    }
}
