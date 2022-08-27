package com.service;

import com.entity.Chapter;
import com.entity.Course;
import com.entity.Resource;
import java.util.List;

public interface NameForCourseIdService {
    //通过课程名字查courseId
    public Course findCourseIdByCourseName(String courseName);
    //通过courseId获取资源对象
    public List<Resource> findResourceByCourseId(Integer courseId);
    //通过courseId查章节
    public List<Chapter> findChapterByCourseId(Integer courseId);

}
