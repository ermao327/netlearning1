package com.controller;

import com.constant.Constant;
import com.entity.Course;


import com.entity.CourseType;
import com.exception.ServiceException;
import com.github.pagehelper.PageInfo;
import com.service.CourseService;
import com.service.CourseTypeService;
import com.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/course")
    public class CourseController {

    @Autowired
    CourseService service;
    @Autowired
    CourseTypeService courseTypeService;

    @RequestMapping("/findAllCourse.do")
    @ResponseBody
    public PageInfo findCoursesById(Integer pageNo, Integer course_type_id, HttpSession session){
        String course_name = (String) session.getAttribute("course_name");
        if(course_type_id == null){ //点击搜索进入此函数
            return service.findByCourseName(pageNo, course_name);
        }
        if(course_type_id == 0){ //点击方向栏的全部
            course_name = "";
            session.setAttribute("course_name",course_name);
            return service.findByCourseName(pageNo, course_name);
        }
        //判断传入的course_type_id属于哪一级
        List<CourseType> list = courseTypeService.findByParentId(course_type_id);
        if(list.size() == 0){ //三级id
            return service.findCoursesByCourseTypeId2(pageNo, course_type_id);
        }
        //顶级id
        return service.findCoursesByCourseTypeId(pageNo, course_type_id);
    }

//    @RequestMapping("findAllCourse.do")
//    @ResponseBody
//    protected PageInfo<Course> findAllCourse(HttpServletRequest request,int pageNo, HttpServletResponse response){
//
//        PageInfo<Course> courses = null;
//        try {
//            courses =  service.selectCourses(pageNo);
//        } catch (ServiceException e) {
//            e.printStackTrace();
//        }
//        return courses;
//    }
    @RequestMapping("/front_course.do")
    public String showFrontCourse(Integer course_id,HttpSession session){
        session.setAttribute("course_id",course_id);
        return "front/front_course";
    }
    @RequestMapping("/showTop15.do")
    @ResponseBody
    public List<Course> getTop15 (){
        List<Course> list = null;
        try {
            list =  service.selectTop15();
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServiceException("top15展示失败");
        }
        return list;
    }

    @RequestMapping("/findAllCourseForFront.do")
    public String findAllCourseForFront(HttpServletRequest request, CourseType ct){
        List<Course> courseList = service.getCourseList();
        request.getSession().setAttribute("courseList",courseList);
        return "/front/front_mycourse";
    }
        @RequestMapping("/loadRecCourse.do")
        @ResponseBody
        public AjaxResult findCourse(HttpServletRequest request){
            String courseId = request.getParameter("course_id");
            List<Course> courses = service.findCourseByCourseId(Integer.valueOf(courseId));

            AjaxResult ajaxResult = new AjaxResult();
            ajaxResult.setObj(courses);
            return ajaxResult;
        }


        @RequestMapping("/findCourse.do")
        @ResponseBody
        public AjaxResult selCourse(Integer pageNo){
            System.out.println("pageNo="+pageNo);
            AjaxResult ajaxResult = new AjaxResult(true, "查询成功", null);
            try {
                PageInfo<Course> info = service.findCourse(pageNo);
                ajaxResult.setObj(info);
            } catch (Exception e) {
                ajaxResult.setSuccess(false);
                ajaxResult.setMsg(e.getMessage());
            }
            return ajaxResult;
        }


        //启用、禁用课程
        @RequestMapping("/toggle.do")
        @ResponseBody
        public void manageCourse(Integer id,Integer status){
            int i = service.modifyCourseById(id, status);
        }

       //跳转章节管理页面
        @RequestMapping("/idHolder.do")
        public String jumpChapter(Integer id, HttpSession session){
            session.setAttribute("id",id);
            return "background/back_courseReourceSet";
        }


        //添加课程
        @RequestMapping("/addCourse.do")
        @ResponseBody
        public AjaxResult addCourse(@RequestParam("multiFiles") MultipartFile file, @RequestParam("course_name")String courseName,
                              String author,@RequestParam("recommendation_grade")Integer recommendationGrade,@RequestParam("course_type_id") Integer courseTypeId,HttpSession session) throws IOException {
            Course course = getCourse(file, null,courseName, author, recommendationGrade, courseTypeId, session);

            int i = service.insertCourseByCondition(course);
            System.out.println("i="+i);
            AjaxResult ajaxResult = new AjaxResult();
            ajaxResult.setMsg("添加课程成功，让我们愉快的学习吧！");
            return ajaxResult;

        }

        //修改课程前的查询
        @RequestMapping("/show.do")
        @ResponseBody
        public AjaxResult beforeCourse(Integer id){
            Course course = service.findCourseById(id);
            AjaxResult ajaxResult = new AjaxResult();
            ajaxResult.setObj(course);
            return ajaxResult;
        }

        //修改课程
        @RequestMapping("/modifyCourse.do")
        @ResponseBody
    public AjaxResult mfCourse(@RequestParam("multiFiles") MultipartFile file, Integer id,@RequestParam("course_name")String courseName,
                               String author,@RequestParam("recommendation_grade")Integer recommendationGrade,@RequestParam("course_type_id") Integer courseTypeId,HttpSession session)throws IOException{
            Course course = getCourse(file, id,courseName, author, recommendationGrade, courseTypeId, session);
            int i = service.modifyCourseByCondition(course);
            AjaxResult ajaxResult = new AjaxResult();
            ajaxResult.setMsg("修改成功！");
            return ajaxResult;
        }

        //封装Course对象
        public Course getCourse(MultipartFile file,Integer id,String courseName,
                                    String author,Integer recommendationGrade,
                                    Integer courseTypeId,HttpSession session) throws IOException {
            //文件上传
//            String dir = new SimpleDateFormat("yyyyMMdd").format(new Date());
            String path = session.getServletContext().getRealPath("/upload/course_cover/");
            System.out.println("path="+path);
            File file1 = new File(path);
            file1.mkdirs();
            String fileName = file.getOriginalFilename();
            file.transferTo(new File(file1,fileName));

            System.out.println("recommendationGrade="+recommendationGrade);
            Course course = new Course();
            course.setId(id);
            course.setCourse_name(courseName);
            course.setAuthor(author);
            course.setCover_image_url(fileName);
            course.setCreate_date(new Date());
            course.setClick_number(0);
            course.setStatus(Constant.STATUS_ENABLE);   //默认0
            course.setRecommendation_grade(recommendationGrade);
            course.setCourse_type_id(courseTypeId);
            return course;
        }

}
