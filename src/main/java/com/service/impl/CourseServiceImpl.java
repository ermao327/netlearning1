package com.service.impl;

import com.constant.Constant;
import com.dao.CourseDao;
import com.dao.CourseTypeDao;
import com.entity.Chapter;
import com.entity.Course;
import com.entity.CourseType;
import com.exception.DataAccessException;
import com.exception.ServiceException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class CourseServiceImpl implements CourseService {

    @Autowired
    CourseDao dao;
    @Autowired
    CourseTypeDao ctDao;

    @Override
    public PageInfo findByCourseName(Integer pageNo,String courseName) {
        PageHelper.startPage(pageNo, Constant.PAGE_SIZE_COURSE);
        List<Course> courses = dao.selectByCourseName(courseName);
        return new PageInfo(courses);
    }
    @Override
    public PageInfo findCoursesByCourseTypeId2(Integer pageNo, Integer ctid) {
        PageHelper.startPage(pageNo, Constant.PAGE_SIZE_COURSE);
        List<Course> courses = dao.selectByCourseTypeId2(ctid);
        return new PageInfo(courses);
    }

    @Override
    public PageInfo findCoursesByCourseTypeId(Integer pageNo,Integer ctid) {
        PageHelper.startPage(pageNo, Constant.PAGE_SIZE_COURSE);
        List<Course> courses = dao.selectByCourseTypeId(ctid);
        return new PageInfo(courses);
    }

    @Override
    public PageInfo<Course> selectCourses(int pageNo) throws ServiceException {
        PageHelper.startPage(pageNo, Constant.PAGE_SIZE_COURSE);
        List<Course>  list= dao.selectCourses();
        if ( list == null){
            throw new ServiceException("课程已经加载完毕！");
        }
        return new PageInfo<Course>(list);
    }

    @Override
    public List<Course> selectTop15() {
        List<Course> top15 = null;
        try {
            top15 = dao.findTop15();
        } catch (Exception e) {
            e.printStackTrace();
            throw new DataAccessException("top15查询失败");
        }
        return top15;
    }

    @Override
    public List<Course> findTop4ByGroup() {
        List<Course> courses = dao.selectAllCourses();
        List list = new ArrayList();
        Set ids = new HashSet();
        for (Course course : courses) {
            Integer id = course.getCourseType().getParent_id();
            Integer type1id = ctDao.selectParentIdById(id);
            course.setCourse_type_id(type1id);
            ids.add(type1id);
        }
        for (Object id:ids) {
            List sunList = new ArrayList();
            for (int i = 0; i < courses.size() ; i++) {
                if (courses.get(i).getCourse_type_id()==id && sunList.size()<4){
                    sunList.add(courses.get(i));
                }
            }
            list.addAll(sunList);
        }
        return list;
    }
//    public List<Course> selectTop4(){
//        System.out.println("service查找top4");
//        List<Course> list =dao.selectCourses();
//        for (Course c:list){
//            Integer childId = c.getCourse_type_id();
//            Integer parentId =ctDao.selectCourseTypeById(childId).getParent_id();
//            childId = parentId;
//            parentId =ctDao.selectCourseTypeById(childId).getParent_id();
//            c.setCourse_type_id(parentId);
//        }
//        List<Course> top4 = list.stream() .sorted(Comparator.comparing(Course::getRecommendation_grade)).sorted(Comparator.comparing(Course::getClick_number)).collect(Collectors.toList());
//        if(top4.size()>4){
//            top4=top4.subList(0, 4);
//        }
//
//        System.out.println(top4);
//        return top4;
//    }


    @Override
    public List<Course> findCourseByCourseId(Integer courseId) {
        return dao.selectCourseByCourseId(courseId);
    }

    @Override
    public PageInfo<Course> findCourse(Integer pageNo) {
        PageHelper.startPage(pageNo, Constant.PAGE_SIZE);
        List<Course> list = dao.selectCourse();
        if (null == list) {
            throw new ServiceException("没有更多课程了...");
        }
        return new PageInfo<Course>(list);

    }

    @Override
    public int modifyCourseById(Integer id, Integer status) {
        return dao.updateCourseById(id,status);
    }

    @Override
    public int insertCourseByCondition(Course course) {
        return dao.insertCourseByCondition(course);
    }

    @Override
    public Course findCourseById(Integer id) {
        return dao.selectCourseById(id);
    }

    @Override
    public int modifyCourseByCondition(Course course) {
        return dao.updateCourseByCondition(course);
    }
    @Override
        public List<Course> getCourseList () {
            List<Course> courseList = dao.getCourseList();
            return courseList;
        }

    @Override
    public List<Chapter> getChapterList(int cid) {
        List<Chapter> chapterList = dao.getChapterList(cid);
        return chapterList;
    }

    @Override
    public PageInfo<CourseType> getCourseTypeList(int pageNo, int parent_id) {
        PageHelper.startPage(pageNo, Constant.PAGE_SIZE);
        List<CourseType> courseTypeList = dao.getCourseTypeList(parent_id);
        if (null == courseTypeList) {
            throw new ServiceException("没有记录...");
        }
        return new PageInfo<CourseType>(courseTypeList);

    }

    @Override
    public CourseType findCourseTypeByid(int id) {
        CourseType courseType = dao.findCourseTypeById(id);
        return courseType;
    }

    @Override
    public int updateCourseTypeStatusById(CourseType ct) {
        int i = dao.updateCourseTypeById(ct);
        if(i==0){
            throw new ServiceException("更新状态失败");
        }
        return i;
    }

    @Override
    public int addCourseType(CourseType ct) {
        int i=0;
     try {
         i = dao.insertCourseType(ct);}
     catch (SQLException e){
         throw new ServiceException("sql语句错误");
     }
        return i;
    }

    @Override
    public List<CourseType> findCourseTypeList() {
        List<CourseType> courseTypeList = dao.getCourseTypeList(0);
        return courseTypeList;
    }
}
