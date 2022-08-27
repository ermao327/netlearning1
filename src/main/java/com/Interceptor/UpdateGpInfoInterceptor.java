package com.Interceptor;

import com.constant.Constant;
import com.entity.User;
import com.service.UserGpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * date:2021/3/17
 * autor:JY
 */


public class UpdateGpInfoInterceptor implements HandlerInterceptor {
    @Autowired
    UserGpService service;

        @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
            User user =(User) request.getSession().getAttribute(Constant.SESSION_USER);
            if(user!=null) {
                service.findGoldPointsVoByUid(user.getId());
            }
        }
}
