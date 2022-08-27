package com.controller;

import com.constant.Constant;
import com.entity.Comment;
import com.entity.User;
import com.github.pagehelper.PageInfo;
import com.service.CommentService;
import com.util.AjaxResult;
import com.vo.CommentVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;


@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    CommentService service;

    //评论加载
    @RequestMapping("/loadResComs.do")
    @ResponseBody
    public AjaxResult showComment(@RequestParam("resource_id") Integer resourceId, @RequestParam("pageNo")Integer pageNo){

        AjaxResult ajaxResult = new AjaxResult(true, "查询成功", null);
        try {
            PageInfo<CommentVo> info = service.findCommentByResourceId(resourceId, pageNo);
            ajaxResult.setObj(info);
        } catch (Exception e) {
            ajaxResult.setSuccess(false);
            ajaxResult.setMsg(e.getMessage());
        }
        return ajaxResult;
    }

    //查询点赞数
    @RequestMapping("/getPraCount.do")
    @ResponseBody
    public AjaxResult getCount(@RequestParam("comment_id") Integer commentId){
        Integer praiseCount = service.findPraiseCountByCommentId(commentId);
        AjaxResult ajaxResult = new AjaxResult(true,null,praiseCount);
        return ajaxResult;
    }

    //发布评论
    @RequestMapping("/sendComs.do")
    @ResponseBody
    public AjaxResult postComment(@RequestParam("resource_id") Integer resourceId, @RequestParam("context") String context, HttpSession session){
        User user = (User)session.getAttribute(Constant.SESSION_USER);
        Integer uid = user.getId();
        Comment comment = new Comment(context,new Date(),uid,resourceId,2);
        Integer i = service.addComment(comment);
        AjaxResult ajaxResult = new AjaxResult();
        ajaxResult.setMsg("发布评论成功！");
        return ajaxResult;
    }

    //查询待审核评论
    @RequestMapping("/findComs.do")
    @ResponseBody
    public AjaxResult loadComment(@RequestParam("status") Integer status,@RequestParam("pageNo")Integer pageNo){
        AjaxResult ajaxResult = new AjaxResult(true, "查询成功", null);
        try {
            PageInfo<CommentVo> info = service.findCommentByStatus(status, pageNo);
            ajaxResult.setObj(info);
        } catch (Exception e) {
            ajaxResult.setSuccess(false);
            ajaxResult.setMsg(e.getMessage());
        }
        return ajaxResult;
    }

    //通过审核、禁用评论 (通过评论id修改对应的status)
    @RequestMapping("/toggle.do")
    @ResponseBody
    public void reviewComments(Integer id,Integer status){
        Integer i = service.modifyCommentByStatus(id, status);
    }

    //根据条件分页查询已审核评论(启用、禁用)
    @RequestMapping("/findByChapterId.do")
    @ResponseBody
    public AjaxResult selReviewedComments(Integer status,Integer pageNo){
        AjaxResult ajaxResult = new AjaxResult(true, "查询成功", null);
        try {
            PageInfo<CommentVo> info = service.findReviewedComments(pageNo);
            ajaxResult.setObj(info);
        } catch (Exception e) {
            ajaxResult.setSuccess(false);
            ajaxResult.setMsg(e.getMessage());
        }
        return ajaxResult;
    }

}
