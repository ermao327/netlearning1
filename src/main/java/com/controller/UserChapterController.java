package com.controller;

import com.entity.Chapter;
import com.service.CourseService;
import com.util.AjaxResult;
import com.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * date:2021/3/4
 * autor:JY
 */

@Controller
@RequestMapping("/chapter")
public class UserChapterController {
    @Autowired
    CourseService service;
    @RequestMapping("/loadChapterByCourseId.do")
    @ResponseBody
    public List<Chapter> loadChapterByCourseId(String course_id){
        Integer cid = StringUtil.getInt(course_id);
        List<Chapter> chapterList = service.getChapterList(cid);
        return chapterList;
    }
}
