package com.service.impl;

import com.constant.Constant;
import com.dao.ChapterDao;
import com.entity.Chapter;
import com.exception.DataAccessException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.service.ChapterService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ChapterServiceImpl implements ChapterService {

    @Autowired
    ChapterDao dao;

    @Override
//    public PageInfo<Chapter> loadChapters(Chapter chap,int pageNo) {
//        PageHelper.startPage(pageNo, 2);
//        List<Chapter> list = null;
//        try {
//            list = dao.findAll(chap);
//        } catch (Exception e) {
//            e.printStackTrace();
//            throw new DataAccessException("查询章节失败");
//        }
//        return new PageInfo<Chapter>(list);
//    }
    //查询所有chapter
    public PageInfo<Chapter> loadChapters(int pageNo, Chapter chapter, @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") Date begin_date, @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") Date end_date ) {
        PageHelper.startPage(pageNo, Constant.PAGE_SIZE);
        List<Chapter> chapters = null;
        try {
            chapters = dao.findAll(chapter, begin_date, end_date);
        } catch (Exception e) {
            e.printStackTrace();
            throw new DataAccessException("查询章节失败");
        }
        return new PageInfo<Chapter>(chapters);
    }

    @Override
    public String checkWords(Chapter chapter,Date begin_date,Date end_date) {
        String title=chapter.getTitle();
        String info=chapter.getInfo();
        List<Chapter> all = dao.findAll(chapter,begin_date,end_date);
        String msg = null;
        if (title != null && info == null) {
            for (Chapter c : all) {
                if (title.equals(c.getTitle())) {
                    if (info.equals(c.getInfo())) {
                        msg = "章节标题和资源标题重复";
                    } else {
                        msg = "章节标题重复";
                    }
                } else {
                    if (info.equals(c.getInfo())) {
                        msg = "资源标题重复";
                    }
                }
                if (title == "" || info == "") {
                    msg = "章节标题和资源标题不能为空";
                }
            }
        }else {
            msg = "章节标题和资源标题不能为空";
        }

        return msg;
    }


    @Override
    public void addChapter(Chapter chapter) {
        dao.insertNewChapter(chapter);
    }

    @Override
    public int updateChapter(Chapter chapter) {

        System.out.println("Service updateChapter方法执行");
        int i= 0;
        try {
            i = dao.updateChapter(chapter);
        } catch (Exception e) {
            e.printStackTrace();
            throw new DataAccessException("修改用户失败");
        }

        return i;
    }

}
