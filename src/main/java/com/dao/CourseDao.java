package com.dao;

import com.entity.Chapter;
import com.entity.Course;
import com.entity.CourseType;
import org.apache.ibatis.annotations.Param;

import java.sql.SQLException;
import java.util.List;

public interface CourseDao {
    List<Course> selectAllCourses();
    List<Course> selectByCourseName(String courseName);
    List<Course> selectByCourseTypeId(Integer ctid);
    List<Course> selectByCourseTypeId2(Integer ctid);

    List<Course> selectCourses();
    List<Course> findTop15();
    Course findTop4(int course_type_id);

    //通过Id查询Course点击量前三课程
    public List<Course> selectCourseByCourseId(Integer courseId);
    public List<Course> selectCourse();
    public int updateCourseById(@Param("id") Integer id, @Param("status") Integer status);
    public int insertCourseByCondition(Course course);
    //通过Id查询Course
    public Course selectCourseById(Integer id);
    public int updateCourseByCondition(Course course);

    public List<Course> getCourseList();
    public List<Chapter> getChapterList(int cid);
    public List<CourseType> getCourseTypeList(@Param("parent_id") int parent_id);
    public CourseType findCourseTypeById(int id);
    public int updateCourseTypeById(CourseType ct);
    public int insertCourseType(CourseType ct)throws SQLException;
}
