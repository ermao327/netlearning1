<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>课程详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/iconfont/font_0/iconfont.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/template-web.js"></script>
    <script src="${pageContext.request.contextPath}/js/sweetalert.js"></script>
    <script>
    var count = 0;
    $(function() {
        $(".title-ul>li").on('click', function() {
            $(this).addClass('current').siblings().removeClass("current");
        });
        $('.addPraise').bind('click', function(){
            swal('点赞成功');
        });
        alert('${resource.path}');
        //页面加载时加载第一页评论
        loadComs(1);
        //错误信息弹窗
        var msg = '${errorMsg}';
        if(msg){swal(msg);}
        loadRecCourse();
    });
    
	    /**
	    *评论加载功能
	    */
    	function loadComs(pageNo){
    	if(pageNo == 0 ||!pageNo){swal("没有更多评论了哟");return;}
    	var resource_id = $("#resource_id_holder").val();

    		$.ajax(
	        {
	        	url:'${pageContext.request.contextPath}/comment/loadResComs.do',
	        	data:
	        	{
	        		"resource_id":resource_id,
	        		"pageNo":pageNo
	        	},
	        	type:'post',
	        	success:function(data)
	        	 {
	        		var coms = data.obj.list;
	        		var info = data.obj;
	        		var html = template("userComs", {d : coms});
	        		$("#before-load-more").before(html);
	        		$("#nextPage-num").attr("nextPageNo",info.nextPage);
	 			 }
	        });
    	}
    	
    	/**
    	*加载更多评论的方法
    	*/
    	function showMore(item){
    		let pageNo = $("#nextPage-num").attr("nextPageNo");
    		loadComs(pageNo);
    	}
    	/**
    	*发表评论 方法
    	*/
    	function commitCom(id){
    		let context = $("#comment-context").val();
    		$.ajax(
    		{
    			url:'${pageContext.request.contextPath}/comment/sendComs.do',
    			data:{"resource_id":id,"context":context},
    			type:'post',
    			success:function(data)
    			{
    				swal(data.msg);

                    $(".loadComment").html(""); //清空评论区
                    loadComs(1);         //重新加载评论

    			}
    		});
    	}
    	/**
    	*加载当前课程所在类别下点击量前三多的课程
    	*/
    	function loadRecCourse()
    	{
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
    	/**
    	*点赞/取消暂功能
    	*/
    	function getCount(comment_id,item){
    		$.ajax(
    		{
    			url:'${pageContext.request.contextPath}/comment/getPraCount.do',
    			data:{"comment_id":comment_id},
    			type:'post',
                dataType:"json",
    			success:function(data)
    			{
    			    console.log(data.obj);
    				if(data.success){
    					$(item).next().html(data.obj);
    				}
    			}
    		});
    	}
    	
    	/**
    	*点赞/取消暂功能
    	*/
    	function doPraise(comment_id,item)
    	{
    		$.ajax(
    		{
	    		url:'${pageContext.request.contextPath}/praise/tgPraise.do',
	    		data:{"comment_id":comment_id},
	    		type:'post',
                dataType:"json",
	    		success:function(data)
	    		{
	    			if(data.success){

	    			swal("点赞成功！");
	    			$(item).addClass("current");
	    			getCount(comment_id,item);
	    			return;
	    			}
                    console.log("来 false了="+data);
	    			$(item).removeClass("current");
	    			getCount(comment_id,item);
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
    
    <script  type="text/html" id="userComs">
	{{ each d  item }}
		<li class="loadComment">
             <div class="row comment-area">
                 <div class="col-md-1"><img src="${pageContext.request.contextPath}/images/user.jpeg" alt="" class="img-circle " width="35" height="35"></div>
                 <div class="col-md-10 comment-info">
                     <div class="col-md-12">{{item.nickname}}</div>
                     <div class="col-md-12">{{item.context}}</div>
                     <div class="col-md-12">
                         <div>
                             时间：<span>{{item.create_date}}</span>
                         </div>
                         <div>
                             <span>举报</span>
                             <span class="addPraise" >
								<i class="icon iconfont icon-zan" onclick="doPraise({{item.id}},this)"></i>
							 	<span>{{item.praise_count}}</span>
							 </span>
                         </div>
                     </div>
                 </div>
             </div>
         </li>
		{{/each}}
	</script>
    
</head>

<body>
	<!-- idHolders -->
	<input type="hidden" id="course_id_holder" value="${course_id}"/>
	<input type="hidden" id="resource_id_holder" value="${resource.id}"/>
    <div class="wrap-cc">
        <div class="content-cc">
            <jsp:include page="front_head.jsp"></jsp:include>
            <nav class="navbar navbar-default">
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
	                        <a onclick="history.back()" class="vertical-middle">
	                        	<i class="glyphicon glyphicon-menu-left"></i>
	                        </a>
                        </li>
                        <li class="vertical-middle text-color"> ${resource.title}</li>
                        <li class="vertical-middle little-title">${path}</li>
                    </ul>
                    <!-- /.navbar-collapse -->
                </div>
                <!-- /.container-fluid -->
            </nav>
            <div class="container-fluid padding-0 bgColor">
                <video style="width: 100%; height:470px;" controls="controls">
					${resource}
					
                    <source src="${pageContext.request.contextPath}/${resource.path}">
                </video>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-md-9">
                        <ul class="title-ul">
                            <li class="current">评论</li>
                            <li>问答</li>
                            <li>笔记</li>
                        </ul>
                        <div class="row comment-area">
                            <div class="col-md-1"><img src="${pageContext.request.contextPath}/images/user.jpeg" alt="" class="img-circle " width="35" height="35"></div>
                            <div class="col-md-9">
                                <textarea id="comment-context" cols="70" rows="10" style="resize:none;"></textarea>
                            </div>
                            <div class="col-md-2 col-md-offset-10 ">
                                <button class="btn btn-success" onclick="commitCom(${resource.id})">发表评论</button>
                            </div>
                        </div>
                        <ul id="commentDetail" class="margin-bottom-90">
                            <!-- 此处为评论显示区域 -->
                            <li  id = "before-load-more" >
                                <div class="load-more">
                                    <span id="nextPage-num" onclick="showMore(this)" >加载更多...</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-3" >
                        <div class="row teacher-msg">
                            <div class="col-md-12 course-title padding-30">推荐课程</div>
                        </div>
                        <!-- 此处为推荐课程展示区 -->
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-cc">
        <div class="footer">
            <div>
            </div>
            <div>
                Copyright © 2018 imooc.com All Rights Reserved | 京ICP备 13046642号-2
            </div>
        </div>
    </div>
    
    
</body>

</html>