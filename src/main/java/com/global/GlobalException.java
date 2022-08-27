package com.global;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/**
 * date:2021/3/4
 * autor:JY
 */

@ControllerAdvice
public class GlobalException {

    @ExceptionHandler
    public ModelAndView exceptionHandler(Exception e) {
        return new ModelAndView("exception", "msg", "服务器异常");
    }
}