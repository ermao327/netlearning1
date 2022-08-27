package com.service;
import com.entity.CourseType;
import com.github.pagehelper.PageInfo;


import java.util.List;


public interface CourseTypeService {
    public List<CourseType> findCourseTypes();
    List<CourseType> findByParentId(Integer pid);

//    List<CourseType> findByParentId(int parent_id);

    public PageInfo<CourseType> findCourseType();

}
