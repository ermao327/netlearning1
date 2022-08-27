package com.service.impl;

import com.constant.Constant;
import com.dao.CommentDao;
import com.entity.Comment;
import com.entity.User;
import com.exception.ServiceException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.service.CommentService;
import com.vo.CommentVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    CommentDao dao;

    @Override
    public PageInfo<CommentVo> findCommentByResourceId(Integer resourceId,Integer pageNo) throws ServiceException{
        PageHelper.startPage(pageNo, Constant.PAGE_SIZE);
        List<CommentVo> commentVos = dao.selectCommentByResourceId(resourceId);
        //遍历commentVos 将nickName和praiseCount属性查出并赋给commentVos对应的每一个评论对象
        for (CommentVo list:commentVos){
            User user = dao.selectUserByID(list.getUser_id());
            list.setNickname(user.getNickname());

            Integer praiseCount = dao.selectPraiseCountByCommentId(list.getId());
            list.setPraise_count(praiseCount);
        }

        if (commentVos==null){
            throw new ServiceException("没有更多评论了！");
        }
        return new PageInfo<CommentVo>(commentVos);
    }

    @Override
    public Integer findPraiseCountByCommentId(Integer commentId) {
        return dao.selectPraiseCountByCommentId(commentId);
    }

    @Override
    public Integer addComment(Comment comment) {
        return dao.insertComment(comment);
    }

    @Override
    public PageInfo<CommentVo> findCommentByStatus(Integer status, Integer pageNo) {
        PageHelper.startPage(pageNo, Constant.PAGE_SIZE);
        List<CommentVo> commentVos = dao.selectCommentByStatus(status);
        //遍历commentVos 将nickName和praiseCount属性查出并赋给commentVos对应的每一个评论对象
        for (CommentVo list:commentVos){
            User user = dao.selectUserByID(list.getUser_id());
            list.setLogin_name(user.getLogin_name());

            Integer praiseCount = dao.selectPraiseCountByCommentId(list.getId());
            list.setPraise_count(praiseCount);
        }

        return new PageInfo<CommentVo>(commentVos);
    }

    //审核、禁用评论
    @Override
    public Integer modifyCommentByStatus(Integer id, Integer status) {
        return dao.updateCommentByStatus(id,status);
    }

    @Override
    public PageInfo<CommentVo> findReviewedComments(Integer pageNo) {
        PageHelper.startPage(pageNo, Constant.PAGE_SIZE);
        List<CommentVo> commentVos3 = dao.selectReviewedComments();
        //遍历commentVos 将nickName和praiseCount属性查出并赋给commentVos对应的每一个评论对象
        for (CommentVo list:commentVos3){
            User user = dao.selectUserByID(list.getUser_id());
            list.setLogin_name(user.getLogin_name());

            Integer praiseCount = dao.selectPraiseCountByCommentId(list.getId());
            list.setPraise_count(praiseCount);
        }

        return new PageInfo<CommentVo>(commentVos3);
    }


}
