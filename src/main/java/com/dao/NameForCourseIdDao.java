package com.dao;

import com.entity.Chapter;
import com.entity.Course;
import com.entity.Resource;

import java.util.List;

public interface NameForCourseIdDao {

    public Course selectCourseIdByCourseName(String courseName);
    //通过courseId获取资源对象
    public List<Resource> selectResource(Integer courseId);
    //通过courseId查章节
    public List<Chapter> selectChapterByCourseId(Integer courseId);
}
