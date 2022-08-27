package com.service;

import com.entity.Chapter;
import com.github.pagehelper.PageInfo;

import java.util.Date;

public interface ChapterService {
    PageInfo<Chapter> loadChapters( int pageNo,Chapter chapter, Date begin_date,Date end_date);
    String checkWords(Chapter chapter,Date begin_date,Date end_date);
    void addChapter(Chapter chapter);
    int updateChapter(Chapter chapter);
}
