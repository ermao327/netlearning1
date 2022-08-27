package com.controller;

import com.constant.Constant;
import com.entity.CourseType;
import com.entity.GoldPoints;
import com.entity.User;
import com.exception.ServiceException;
import com.github.pagehelper.PageInfo;
import com.service.*;
import com.util.AjaxResult;
import com.util.CommonUtil;
import com.util.DateUtil;
import com.util.StringUtil;
import com.vo.UserBackVo;
import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * date:2021/3/8
 * autor:JY
 */

@Controller
@RequestMapping("/user")
public class UserLogin {
    @Autowired
    UserLoginService service;
    @Autowired
    CourseService courseService;
    @Autowired
    UserService userService;
    @Autowired
    GoldPointsService gpService;


    @RequestMapping("/regist.do")
    @ResponseBody
    public AjaxResult register (HttpServletRequest request,User u, HttpServletResponse response){
        u.setCreate_date(new Date());
        userService.regist(u);
        return new AjaxResult(true, "注册成功",u );
    }

    @RequestMapping("/loginFront.do")
    @ResponseBody
    public AjaxResult login(HttpServletRequest request,String login_name,String password,HttpServletResponse response){
        AjaxResult re = new AjaxResult();
        try {
            User user = userService.findUser(login_name, password);
            user.setLogin_date(new Date());
            userService.updateUser(user);
            request.getSession().setAttribute(Constant.SESSION_USER, user);
            re.setSuccess(true);
        }catch (ServiceException e){
            re.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return re;
    }


    @RequestMapping("/check.do")
    @ResponseBody
    public AjaxResult checkName(String login_name){
//        AjaxResult result = new AjaxResult();
        String reg="[0-9A-Za-z_]{6,20}$";
        boolean flag = false;
        System.out.println("name="+login_name);
        List<String> names = userService.getNames();
        if(login_name != null){
            for(String name : names){
                if(login_name.equals(name)){
                    flag = false;
                    break;
                }else {
                    flag = true ;
                }
            }
        }
        flag = flag&&login_name.matches(reg);
        String msg = flag ? "" : "用户名重复或用户名不可用：用户名为6-20位，仅包含数字 字母 下划线";
        return new AjaxResult(flag,msg,"");
    }

    @RequestMapping("/check2.do")
    @ResponseBody
    public AjaxResult checkEmail(String email){
//        String reg="^([a-z0-9A-Z]+[-|\\\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\\\.)+[a-zA-Z]{2,}$";
        String reg="^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\\.[a-zA-Z0-9_-]{2,3}){1,2})$";
        boolean flag = false;
        List<String> emails = userService.getEmails();
        if(email != null){
            for(String mail : emails){
                if(email.equals(mail)){
                    flag = false;
                    break;
                }else {
                    flag = true ;
                }
            }
        }
        System.out.println(email.matches(reg));

        flag = flag&&email.matches(reg);
        String msg = flag ? "" : "邮箱已注册或者无效邮箱";
        return new AjaxResult(flag,msg,"");
    }

    @RequestMapping("/loginOut1.do")
    public String doLoginOut(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().invalidate();

        return "/front/front_index";
    }

    @RequestMapping("/modifyUser.do")
    @ResponseBody
    public AjaxResult modifyUser(HttpServletRequest request,User u ,HttpServletResponse response){
        String password = request.getParameter("newPassword");
        String email = request.getParameter("email");
        u.setPassword(password);
        boolean flag = email.matches("^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\\.[a-zA-Z0-9_-]{2,3}){1,2})$");
        String msg = flag ? "" : "邮箱不可用";
        AjaxResult result = new AjaxResult(flag,msg,"");
        if(result.isSuccess()) {
            int i= userService.updateUser(u);
            if(i==1){
                result = new AjaxResult(true,"修改信息成功！",u);
            }else {
                result.setMsg("修改信息失败！");
            }
        }
        return  result;
    }


    @RequestMapping("/findLoginDate.do")
    @ResponseBody
    public Boolean findLoginDate(HttpSession session){
        User u =(User)session.getAttribute(Constant.SESSION_USER);
        System.out.println(u+"获取上次签到时间的u");
        Date lastLoginDate = gpService.getLastLoginDate(u);
        boolean isNeedSign = false;
        if(lastLoginDate == null){
            isNeedSign =true;
        }else {
            isNeedSign = DateUtil.isNeedSign(lastLoginDate);
        }
        System.out.println("是否需要签到"+isNeedSign);
        return  isNeedSign ;
    }


    @RequestMapping("/updateLoginDate.do")
    @ResponseBody
    public AjaxResult updateLoginDate(HttpServletRequest request,User u,HttpServletResponse response){
        int user_id = u.getId();
        GoldPoints gp = new GoldPoints(user_id ,5,0,"签到获得5积分",new Date());
        int i = gpService.insertGoldPoint(gp);
        if (i == 1){
            return AjaxResult.isOk("签到成功");
        }else {
            return AjaxResult.isFail("网络异常，签到失败");
        }


    }

    //后台验证管理员登录 并将USER对象跟全部课程类别表存入Session作用域
    @RequestMapping("/loginBack.do")
    @ResponseBody
    public AjaxResult loginBack(User u, String code, HttpServletRequest request){
        AjaxResult result = new AjaxResult();
        String localCode=(String) request.getSession().getAttribute("code");
        if(localCode ==null || !localCode.equals(code)){
            result.setSuccess(false);
            result.setMsg("验证码错误");
            return result;
        }
        try {
            User user = service.findUserBylogin_name(u);
            if(user.getRole().equals("admin")){
                request.getSession().setAttribute(Constant.SESSION_USER, user);
                List<CourseType> allCourseTypes = courseService.findCourseTypeList();
                request.getSession().setAttribute("courseTypeList",allCourseTypes);
                result.setSuccess(true);
            }
            else{
                return new AjaxResult(false,"用户权限不足",null);
            }
        }
        catch (ServiceException e){
            return new AjaxResult(false,"用户名密码不正确",null);

        }
        return result;
    }
    //后台登录页面验证码功能
    @RequestMapping("/getCode.do")
    public void getCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        CommonUtil.MyImage m = CommonUtil.getImage(null, 4, true, true);
        request.getSession().setAttribute("code", m.getCode());
        ServletOutputStream responseOutputStream = response.getOutputStream();
        // 输出图象到页面
        ImageIO.write(m.getImage(), "JPEG", responseOutputStream);
        // 以下关闭输入流！
        responseOutputStream.flush();
        responseOutputStream.close();
    }
    //退出登录
    @RequestMapping("/backloginOut.do")
    public String loginOut(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().invalidate();
        return "/background/back_login";
    }
    //后台查找所有用户
    @RequestMapping("/findBackUser.do")
    @ResponseBody
    public PageInfo<User> findBackUser(String pageNo, UserBackVo u){
        System.out.println(u);
        PageInfo<User> allUser = service.findAllUser(StringUtil.getInt(pageNo),u);
        return allUser;
    }
    //后台修改用户查询该用户的所有信息
    @RequestMapping("/showBackUser.do")
    @ResponseBody
    public AjaxResult showBackUser(String id){
        AjaxResult ajaxResult = new AjaxResult(true, "查询成功", null);
        User user = service.findUserById(StringUtil.getInt(id));
        ajaxResult.setObj(user);
        return ajaxResult;
    }
    //根据前台的信息修改数据库的用户信息
    @RequestMapping("/modifyBackUser.do")
    @ResponseBody
    public AjaxResult modifyBackUser(User u){
        service.updateUserInfo(u);
        return new AjaxResult(true,"修改成功",null);
    }
}
