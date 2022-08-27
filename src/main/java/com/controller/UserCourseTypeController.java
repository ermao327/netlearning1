package com.controller;

import com.entity.Course;
import com.entity.CourseType;
import com.github.pagehelper.PageInfo;
import com.service.CourseService;
import com.service.CourseTypeService;
import com.util.AjaxResult;
import com.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * date:2021/3/9
 * autor:JY
 */

@Controller
@RequestMapping("/ct")
public class UserCourseTypeController {

    @Autowired
    CourseService service;
    @Autowired
    CourseTypeService ct;
    @Autowired
    CourseService course;


    @RequestMapping("/findCourseType.do")
    @ResponseBody
    public Map findCourseType(){
        List<CourseType> courseTypes = ct.findCourseTypes();
        List<Course> courses = course.findTop4ByGroup();
        Map map = new HashMap();
        map.put("courseTypes",courseTypes);
        map.put("courses",courses);
        return map;
    }
//    public Map<String,List> findCourseType() {
//        List<CourseType> list = null;
//        try {
//            list = ct.findAllCourseType();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        Map<String,List> map = new HashMap();
//        List<CourseType> courseTypes = new ArrayList<>();
//        List<Course> courses = null;
//        try {
//            courses = course.selectTop4();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        for (CourseType ct1 : list) {
//            if(ct1.getParent_id()==null){
//                courseTypes.add(ct1);
//            }
//            for (CourseType ct2 : list) {
//                if (ct1.getId() == ct2.getParent_id()) {
//                    ct1.getChildrens().add(ct2);
//                }
//            }
//        }
//        for (Course course : courses){
//            System.out.println(course);
//        }
//        map.put("courses", courses);
//        map.put("courseTypes", courseTypes);
//
//        return map;
//    }


    @RequestMapping("/findByParentId.do")
    @ResponseBody
    public List<List<CourseType>> findByParentId(int parent_id){
        System.out.println("Controller findByParentId 调用");
        List<List<CourseType>> list = new ArrayList<>();
        List<CourseType> types=ct.findByParentId(parent_id);
        for (CourseType type: types){
            list.add(ct.findByParentId(type.getId()));
        }

        return list;
    }
    @RequestMapping("/findBackCourseType.do")
    @ResponseBody
    public PageInfo<CourseType> findBackCourseType(HttpServletRequest request,String pageNo, String parent_id){
        System.out.println(parent_id);
        PageInfo<CourseType> courseTypeList = service.getCourseTypeList(StringUtil.getInt(pageNo),StringUtil.getInt(parent_id));
        return courseTypeList;
    }
    @RequestMapping("/showBackName.do")
    @ResponseBody
    public AjaxResult showBackName(String id){
        CourseType courseType = service.findCourseTypeByid(StringUtil.getInt(id));
        return new AjaxResult(true,"查询课程类别成功",courseType);
    }
    @RequestMapping("/toggleStatus.do")
    @ResponseBody
    public AjaxResult toggleStatus(CourseType ct){
        int i = service.updateCourseTypeStatusById(ct);
        return new AjaxResult(true,"修改状态成功",null);
    }
    @RequestMapping("/modifyCourseTypeName.do")
    @ResponseBody
    public AjaxResult modifyCourseTypeName(CourseType ct){
        System.out.println(ct.getType_name());
        int i = service.updateCourseTypeStatusById(ct);
        return new AjaxResult(true,"修改类名成功",null);
    }
    @RequestMapping("/addBackType.do")
    @ResponseBody
    public AjaxResult addBackType(HttpServletRequest request,CourseType ct){
        AjaxResult ajaxResult = new AjaxResult();
        System.out.println(ct.getParent_id());
        int i = service.addCourseType(ct);
        if(i==0){
           ajaxResult.setMsg("添加课程类别失败");
        }
        ajaxResult.setMsg("添加课程类 别成功");
        return ajaxResult;
    }

}
