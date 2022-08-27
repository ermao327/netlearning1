<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>课程</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/iconfont/font_1/iconfont.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/iconfont/font_0/iconfont.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/swiper.js"></script>
    <script src="${pageContext.request.contextPath}/js/front-index.js"></script>
    <script src="${pageContext.request.contextPath}/js/template-web.js"></script>
    <script src="${pageContext.request.contextPath}/js/sweetalert.js"></script>
    <style>
    html,
    body {
        height: 100%;
    }

    body>.wrap-cc {
        min-height: 100%;
    }

    .content-cc {
        /* padding-bottom 等于 footer 的高度 */
        padding-bottom: 80px;
    }

    .footer-cc {
        width: 100%;
        height: 80px;
        /* margin-top 为 footer 高度的负值 */
        margin-top: -80px;
    }
    </style>
    
    <script>
    $(function() {
        $(".arrow").click(function() {
            $(this).parent().next().toggle();
        });

        $(".title-ul>li").on('click', function() {
            console.log($(this));
            $(this).addClass('current').siblings().removeClass("current");
            var panelId = "#" + $(this).attr("name");
            $(this).parent().siblings().css({
                'display': 'none'
            });
            $(panelId).css({
                'display': 'block'
            });
        });
        loadRecCourse();
    });
    </script>
    <script type="text/javascript">
    	/**
    	*资源校验方法
    	*验证用户积分或金币是否足够
    	*/
    	function checkResource(resource_id,path)
    	{
    	
    		var course_id = $("#course_id_holder").val();
    		$.ajax(
    		{
    			url:'${pageContext.request.contextPath}/resource/checkup.do',
    			data:{"resource_id":resource_id,"path":path},
    			type:'post',
                dataType:"json",
    			success:function(data){
    				// data=JSON.parse(data);
    				if(data.success)
    				{
   						let cost_number = data.obj.cost_number;
    					if(data.obj.cost_type==0){
    						var cost_type = "积分";
    					}else{
    						var cost_type = "金币";
    					}
    					
    					if(data.obj.file_type=="mp4")
    					{
    						/*sweetalert框架的弹窗方法  */
    						swal("成功支付"+cost_number + cost_type+"!即将进入播放页面...");
    						setTimeout(function()
							{
    						location.href =`${pageContext.request.contextPath}/resource/showRs.do?course_id=`+course_id+`&resource_id=`+resource_id+`&path=`+path;
							}, 1000);
	    					return;
    					}
    					swal("成功支付"+cost_number + cost_type+"!即将开始下载...");
    					location.href='${pageContext.request.contextPath}/upload/resources/${data.obj.path}';
    					return;
    				}
    				swal(data.msg);
    			}
    		});
    	}
    	
    	/**
    	*加载当前课程所在类别下点击量前三多的课程
    	*/
    	function loadRecCourse(){
    		var course_id = $("#course_id_holder").val();
    		$.ajax(
    		{
    			url:'${pageContext.request.contextPath}/course/loadRecCourse.do',
    			data:{"course_id":course_id},
    			type:'post',
    			success:function(data)
    			{
    				var top3s = data.obj;
    				var html = template("top3Courses", {c : top3s});
    				$(".col-md-3").append(html);
    			}
    		});
    	}
    	
    	
    </script>
    <script type="text/html" id="top3Courses">
		{{ each c  item }}
    		<div class="row recommd-course">
           	   <div class="col-md-4">
                	<img src="${pageContext.request.contextPath}/images/timg.jpg" alt="">
        	   </div>
         	   <div class="col-md-8">
         	        <div>
						<a href="${pageContext.request.contextPath}/chapter/showChapterFront.do?course_id={{item.id}}">{{item.course_name}}</a>
					</div>
         	        <div>{{item.course_info}}</div>
          	   </div>
     	   </div>
		{{/each}}
    </script>
    
</head>

<body>
	<!-- 其中存放了course_id -->
	<input type="hidden" id="course_id_holder" value="${course_id}"/>
    <div class="wrap-cc">
        <div class="content-cc">
            <jsp:include page="front_head.jsp"></jsp:include>
            <div class="container-fluid banner">
                <div class="container banner-contain">
                    <div class="row">
                        <p> 课程&bsol;前端开发&bsol;前端工具&bsol;webpack深入与实战</p>
                    </div>
                    <div class="row">
                        <p>webpack深入与实战</p>
                    </div>
                    <div class="row">
                        <button class="btn    btn-success  col-md-2">
                            继续学习 | &nbsp;&nbsp; <i class="glyphicon glyphicon-star-empty">  </i>
                        </button>
                        <ul class="col-md-5">
                            <li>点击量
                                <p> 45571 </p>
                            </li>
                            <li> 课程时长
                                <p>3小时21分</p>
                            </li>
                            <li> 综合评分
                                <p>9.7</p>
                            </li>
                        </ul>
                        <ul class="three-logo  col-md-4  col-md-offset-1 ">
                            <li>
                                <i class="icon iconfont icon-weixin"></i>
                            </li>
                            <li>
                                <i class="icon iconfont icon-weibo"></i>
                            </li>
                            <li>
                                <i class="icon iconfont icon-qq"></i>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-md-9">
                        <div class="desp">简介：JAVA</div>
                        <ul class="title-ul">
                            <li class="current" name="chapter">章节</li>
                            <li name="comment">评价</li>
                        </ul>
                        <ul class="course-content margin-bottom-90" id="chapter">
                        	<c:forEach items="${chapters }" var="chas">
	                            <li>
	                                <div class="row">
	                                    <div class="col-md-12 course-title">
	                                        <i class="icon  i-round iconfont icon-weibiaoti-"></i> 
	                                        ${chas.title} 
	                                        <span> ${chas.info } </span>
	                                        <i class="glyphicon glyphicon-triangle-bottom pull-right arrow"></i>
	                                    </div>
	                                    <ul class="lesson-title">
	                                    	<!-- 此处为资源列表 -->
	                                    	<c:forEach items="${chas.resources }" var="res">
		                                        <li class="col-md-11 col-md-offset-1 padding-10 ">
		                                            <span class="glyphicon glyphicon-triangle-right icon-right"> </span>
		                                            <a onclick="checkResource(${res.id},'${chas.title}-${res.title}')">
		                                            	<span> ${res.title } 
			                                            	(需要${res.cost_number}点
			                                            	<c:if test="${res.cost_type == 0}">积分</c:if>
			                                            	<c:if test="${res.cost_type == 1}">金币</c:if>)
		                                            	</span>
		                                            </a>
		                                        </li>
		                                     </c:forEach>   
	                                    </ul>
	                                </div>
	                            </li>
                        	</c:forEach>
                        </ul>
                        <ul id="comment" class="margin-bottom-90">
                           <!-- 此处为该章节相关资源评论展示区 -->
	                           <li>
					            <div class="row comment-area">
					                <div class="col-md-1"><img src="${pageContext.request.contextPath}/images/user.jpeg" alt="" class="img-circle " width="35" height="35"></div>
					                <div class="col-md-10 comment-info">
					                    <div class="col-md-12">admin</div>
					                    <div class="col-md-12">挺有用的</div>
					                    <div class="col-md-12">
					                        <div>
					                            时间：<span>22小时前</span>
					                        </div>
					                        <div>
					                            <span>举报</span>
					                            <span><i class="icon iconfont icon-zan"></i>12</span>
					                        </div>
					                    </div>
					                </div>
					            </div>
					          </li>
                            <li>
                                <div class="load-more">
                                    <span onclick="swal('正在加载...');">加载更多...</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <div class="row teacher-msg">
                            <div class="col-md-12 course-title padding-30">推荐课程</div>
                        </div>
                        <!-- 此处为推荐课程展示区 -->
                    </div>
                </div>
            </div>
            <div class="modal fade" id="userSet" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="myModalLabel">个人信息</h4>
                        </div>
                        <form action="#" class="form-horizontal" method="post">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">旧密码：</label>
                                    <div class="col-sm-6">
                                        <input class="form-control" type="text" name="password" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">新密码：</label>
                                    <div class="col-sm-6">
                                        <input class="form-control" type="password" name="newPassword" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">确认密码：</label>
                                    <div class="col-sm-6">
                                        <input class="form-control" type="password" name="rePassword" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">昵称：</label>
                                    <div class="col-sm-6">
                                        <input class="form-control" type="text" name="nickname" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">邮箱：</label>
                                    <div class="col-sm-6">
                                        <input class="form-control" type="text" name="email" />
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-info" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                                <button type="reset" class="btn btn-info">重&nbsp;&nbsp;置</button>
                                <button type="submit" class="btn btn-info">确&nbsp;&nbsp;定</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-cc">
        <div class="footer">
            <div>
                版权所有： 南京Java
            </div>
            <div>
                Copyright © 2017 imooc.com All Rights Reserved | 京ICP备
            </div>
        </div>
    </div>
</body>

</html>