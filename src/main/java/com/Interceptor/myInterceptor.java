package com.Interceptor;

import com.constant.Constant;
import com.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * date:2021/3/8
 * autor:JY
 */


public class myInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        User user = (User) request.getSession().getAttribute(Constant.SESSION_USER);
        if(user == null){
            request.setAttribute("loginMsg","请先登录");
            request.getRequestDispatcher(request.getContextPath()+"/pages/background/back_login.jsp").forward(request,response);
            return false;
        }
        return true;

    }
}
