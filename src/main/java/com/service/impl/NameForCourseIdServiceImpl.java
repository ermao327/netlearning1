package com.service.impl;

import com.dao.NameForCourseIdDao;
import com.entity.Chapter;
import com.entity.Course;
import com.entity.Resource;
import com.service.NameForCourseIdService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NameForCourseIdServiceImpl implements NameForCourseIdService {

    @Autowired
    NameForCourseIdDao dao;

    @Override
    public Course findCourseIdByCourseName(String courseName) {
        return dao.selectCourseIdByCourseName(courseName);
    }

    @Override
    public List<Resource> findResourceByCourseId(Integer courseId) {
        return dao.selectResource(courseId);
    }

    @Override
    public List<Chapter> findChapterByCourseId(Integer courseId) {
        return dao.selectChapterByCourseId(courseId);

    }


}
