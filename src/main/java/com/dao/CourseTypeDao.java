package com.dao;

import com.entity.CourseType;
import org.springframework.stereotype.Repository;

import java.util.List;


public interface CourseTypeDao {
    public List<CourseType> selectAll();
    List<CourseType> selectByParentId(Integer pid);
    Integer selectParentIdById(Integer id);

    public List<CourseType> findByParentId(int parent_id);
    public CourseType selectCourseTypeById(int id);
    public List<CourseType> selectCourseType();
}
