package com.dao;

import com.entity.Comment;
import com.entity.Praise;
import com.entity.User;
import com.vo.CommentVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentDao {
    public List<CommentVo> selectCommentByResourceId(Integer resourceId);
    public User selectUserByID(Integer id);
    public Integer selectPraiseCountByCommentId(Integer commentId);
    public Integer insertComment(Comment comment);
    //查询待审核评论
    public List<CommentVo> selectCommentByStatus(Integer status);

    public Integer updateCommentByStatus(@Param("id") Integer id, @Param("status") Integer status);
    //查询已审核评论
    public List<CommentVo> selectReviewedComments();
}
