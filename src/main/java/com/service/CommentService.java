package com.service;

import com.entity.Comment;
import com.github.pagehelper.PageInfo;
import com.vo.CommentVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentService {
    public PageInfo<CommentVo> findCommentByResourceId(Integer resourceId, Integer pageNo);
    public Integer findPraiseCountByCommentId(Integer commentId);
    public Integer addComment(Comment comment);
    public PageInfo<CommentVo> findCommentByStatus(Integer status,Integer pageNo);
    public Integer modifyCommentByStatus(Integer id,Integer status);

    //查询已审核评论
    public PageInfo<CommentVo> findReviewedComments(Integer pageNo);
}
