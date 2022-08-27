package com.service;

import com.entity.Chapter;
import com.entity.Course;
import com.entity.CourseType;
import com.exception.ServiceException;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CourseService {
    PageInfo findByCourseName(Integer pageNo,String courseName);
    public List<Course> findCourseByCourseId(Integer courseId);
    PageInfo findCoursesByCourseTypeId(Integer pageNo,Integer ctid);
    PageInfo findCoursesByCourseTypeId2(Integer pageNo,Integer ctid);

    public PageInfo<Course> findCourse(Integer pageNo);
    public int modifyCourseById(Integer id,Integer status);
    public int insertCourseByCondition(Course course);
    public Course findCourseById(Integer id);
    public int modifyCourseByCondition(Course course);
    public List<Course> getCourseList();
    public List<Chapter> getChapterList(int cid);
    public PageInfo<CourseType> getCourseTypeList(int pageNo, int parent_id);
    public CourseType findCourseTypeByid(int id);
    public int updateCourseTypeStatusById(CourseType ct);
    public int addCourseType(CourseType ct);
    public List<CourseType> findCourseTypeList();

    public PageInfo<Course> selectCourses(int PageNo)  throws ServiceException;

    public List<Course> selectTop15();

    public List<Course> findTop4ByGroup();
}
