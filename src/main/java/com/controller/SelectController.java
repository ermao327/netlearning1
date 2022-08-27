package com.controller;

import com.entity.Chapter;
import com.entity.Course;
import com.entity.Resource;
import com.service.NameForCourseIdService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class SelectController {
    @Autowired
    NameForCourseIdService service;
    @RequestMapping("/front_select.do")
    public String front_select(String course_name, HttpSession session){
        session.setAttribute("course_name",course_name);
        return "front/front_select";
    }

    @RequestMapping("/showFront_courseDetail.do")
    public String courseIdByCourseName(String courseName, HttpSession session){
        //根据课程名查courseId
        Course course = service.findCourseIdByCourseName(courseName);
        Integer courseId=course.getId();
        session.setAttribute("course_id",courseId);

        //根据courseId查询章节
        List<Resource> resource = service.findResourceByCourseId(courseId);//根据courseId获取资源对象
        List<Chapter> chapters = service.findChapterByCourseId(courseId);
        for (Chapter c : chapters){
            for (Resource r : resource){
                if (c.getId()==r.getChapter_id()){
            c.getResources().add(r);
                }
            }
        }
        session.setAttribute("chapters",chapters);
        return "front/front_course";
    }
}
