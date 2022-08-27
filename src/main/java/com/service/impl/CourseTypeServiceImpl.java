package com.service.impl;

import com.dao.CourseTypeDao;
import com.entity.CourseType;
import com.github.pagehelper.PageInfo;
import com.service.CourseTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseTypeServiceImpl implements CourseTypeService {

    @Autowired
    CourseTypeDao ctDao;

    @Override
    public PageInfo<CourseType> findCourseType() {
        List<CourseType> list = ctDao.selectCourseType();
        return new PageInfo<CourseType>(list);
    }



    @Override
    public List<CourseType> findCourseTypes() {
        return ctDao.selectAll();
    }
    @Override
    public List<CourseType> findByParentId(Integer pid) {
        List<CourseType> courseTypes = ctDao.selectByParentId(pid);
        return courseTypes;
    }

//    @Override
//    public List<CourseType> findByParentId(int parent_id) {
//        return ctDao.findByParentId(parent_id);
//    }
}

