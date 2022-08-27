<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>优学堂</title>
    <!-- js -->
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/swiper.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/front-index.js"></script>
    <script src="${pageContext.request.contextPath}/js/template-web.js"></script>
    <!-- css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href='${pageContext.request.contextPath}/iconfont/font_1/iconfont.css'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/front-index.css">
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
          //加载上方的一级类型
         loadFirstCourseType();
        //最新,最热
        $(".tool-left>a").on('click', function() {
            $(this).addClass('present').siblings().removeClass("present");
        })
        $(".tool-iseasy>a").on('click', function() {
            $(this).addClass('active').siblings().removeClass("active");
        })
        var state = 0;
        $(".tool-chk").click(function() {
            if (state == 0) {
                $(".tool-chk").css({
                    "background": "url(images/sw-on.fw.png) no-repeat"
                });
                state = 1;
            } else {
                $(".tool-chk").css({
                    "background": "url(images/sw-off.png) no-repeat"
                });
                state = 0;
            }
        })
		 loadCourses(1);//页面加载打印第一页
    })
    
     function Type2(item){

         $(item).parent().addClass("on").siblings().removeClass("on");
     }
     
       function TypeWeb(item){
         $(item).parent().addClass("on").siblings().removeClass("on");
         $("#firstRow").show();
         $("#secondRow").show();
     }
       function TypePerson(item){
         $(item).parent().addClass("on").siblings().removeClass("on");
         $("#firstRow").hide();
         $("#secondRow").hide();
     }
  
     
     //第一个“全部按钮”，课程查询
     function Type1All(item){
        typeId = null;
        type1Id = null;
         $(item).parent().addClass("on").siblings().removeClass("on");
           $("#secondTypeItemLi").nextAll().remove();    
            $("#CourseTypeItemDiv").empty();    
            loadCourses(1,0);//按按钮显示第一页
     }
     //点击下一页
     function nextPage(){
     	pageNo = $("#nextPageBtn").attr("pageNo");
		$("#CourseTypeItemDiv").empty();
     	loadCourses(pageNo,typeId);//??????????????怎么把id值传过来
     }
     //点击上一页
     function prePage(){
     	pageNo = $("#prePageBtn").attr("pageNo");
		$("#CourseTypeItemDiv").empty();
     	loadCourses(pageNo,typeId);
     }
     
     //分页查询课程
     function loadCourses(pageNo,id){
     	 $.ajax({
                    url:'${pageContext.request.contextPath}/course/findAllCourse.do',
                    data:{
                    	"pageNo":pageNo,
                    	"course_type_id":id
                    },
                    dataType:'json',
                    type:'post',
                    success:function(data){

                        var html = template('courseList',{"list": data});
                        $(".pager-cur").html(pageNo);
                        $(".pager-total").html(data.pages);
                        $("#CourseTypeItemDiv").append(html);
                        pageNoNext = pageNo-"0"+1;//运行一次就加1,赋值到下面，给再下次点击它时用(下一页)
                        pageNoPre = pageNo-"0"-1;//运行一次就减1,赋值到下面，给再下次点击它时用(上一页)
                        if (data.isLastPage) {
                        	//到底
							 $("#nextPageBtn").attr("pageNo",data.pages);
							 return
							}
            				$("#nextPageBtn").attr("pageNo",pageNoNext);
            				//最前
							 if (data.isFirstPage) {
							 $("#prePageBtn").attr("pageNo",data.firstPage);
							 return
							}
            				$("#prePageBtn").attr("pageNo",pageNoPre);
                    }
                });
     }
     
     //组合查询
    var typeId = null;
    var type1Id = null;

    function Type1(item,id){
        typeId = id;
        type1Id = id;
         $(item).parent().addClass("on").siblings().removeClass("on");
          $.ajax({
                    url:'${pageContext.request.contextPath}/ct/findByParentId.do',
                    data:{
                        "parent_id":id
                    },
                    dataType:'json',
                    type:'post',
                    success:function(data){
                        var html = template('secondTypeList',{"list": data});
                        $("#secondTypeItemLi").nextAll().remove();
                        $("#secondTypeItemLi").after(html);
                    }
          });
          
         $("#CourseTypeItemDiv").empty();    
          loadCourses(1,id); 
    }
      function Type2(item,id){
        if(id==null || id==undefined){
            id = type1Id;
            typeId = id;
        }else{
            typeId = id;
        }
      	$(item).parent().addClass("on").siblings().removeClass("on");
      	$("#CourseTypeItemDiv").empty();    
        loadCourses(1,id); 
      }
		//加载第一行类型
        function loadFirstCourseType(){
            $.ajax({
                    url:'${pageContext.request.contextPath}/ct/findCourseType.do',
                    dataType:'json',
                    type:'post',
                    success:function(data){
                        var html = template('firstTypeList',{"obj": data});
                        $("#firstTypeItemLi").after(html);
                    }
                });
        }
        
        
        
    </script>
    <script type="text/html" id="firstTypeList">
       {{each obj.courseTypes  type1}}
                 <li class="course-nav-item"><a href="javascript:void(0);" onclick="Type1(this,{{type1.id}})" >{{type1.type_name}}</a></li>
        {{/each}}          
    </script>
     <script type="text/html" id="secondTypeList">
       {{each list  type2}}
			 {{each type2  type3}}
                 <li class="course-nav-item"><a href="javascript:void(0);" onclick="Type2(this,{{type3.id}})" >{{type3.type_name}}</a></li>
			{{/each}} 
        {{/each}}          
    </script>
    <script type="text/html" id="courseList">
       {{each list.list course}}
       		 <div class="course-item">
                        <div class="item-t">
                            <img src="${pageContext.request.contextPath}/upload/course_cover/{{course.cover_image_url
}}" alt="">
                            <div class="java">
                                <label>{{course.course_name}}</label>
                            </div>
                        </div>
                        <div class="item-b">
                            <a href="showFront_courseDetail.do?courseName={{course.course_name}}">
                                <h4>详情</h4>
                            </a>
                            <p class="title">
                                <span>实战</span>
                                <span>高级</span>
                                <span>{{course.author}}</span>
                                <span>{{course.click_number}}</span>
                            </p>
                            <p class="price">￥ 888.00</p>
                        </div>
                    </div>    
       {{/each}}          
    </script>
</head>

<body>
    <div class="wrap-cc">
        <div class="content-cc">
          <jsp:include page="front_head.jsp"></jsp:include>
            <div class="contain" >
                <div class="course-nav-row"  id="firstRow">
                    <span class="hd f-left"> 方向：</span>
                    <div>
                        <ul class="ln">
                            <li class="course-nav-item on" id="firstTypeItemLi"><a href="javascript:void(0);" onclick="Type1All(this)">全部</a></li>
                                
                        </ul>
                    </div>
                </div>
                <div class="course-nav-row" id="secondRow">
                    <span class="hd f-left"> 分类：</span>
                    <div>
                        <ul class="ln">
                            <li class="course-nav-item on" id="secondTypeItemLi"><a href="javascript:void(0);" onclick="Type2(this)">全部</a></li>
                            
                        </ul>
                    </div>
                </div>
                <div class="course-nav-row">
                    <span class="hd f-left"> 类型：</span>
                    <div>
                        <ul class="ln">
                            <li class="course-nav-item on"><a href="javascript:void(0);" onclick="TypeWeb(this)">网站</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);" onclick="TypePerson(this)">个人</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- 实战推荐 -->
            <div class="course">
                <div class="course-tool-bar">
                    <div class="tool-left f-left">
                        <a href="javascript:void(0);">最新</a>
                        <a href="javascript:void(0);" class="present">最热</a>
                    </div>
                    <div class="tool-right f-right">
                        <span class="tool-item">
                     <a href="#" class="hide-learned tool-chk">隐藏已参加课程</a>
                 </span>
                 <span class="tool-item tool-page">
                     <span class="pager-num"> 
                         <b class="pager-cur"></b>
                         <em class="pager-total"></em>
                     </span>
                    <a class="pager-action pager-prev" id="prePageBtn" onclick="prePage()" pageNo="1" >
                   		 <i class="icon iconfont icon-jiankuohaocudazuo"></i>
               		</a>
                   	<a class="pager-action pager-next"  id="nextPageBtn"  onclick="nextPage()" pageNo="1" >
                    	<i class="icon iconfont icon-jiankuohaocudayou"></i>
              		</a>
                </span>
                    </div>
                    <div class="tool-iseasy f-right">
                        <strong>难度：</strong>
                        <a href="#" class="sort-item active">全部</a>
                        <a href="#" class="sort-item">初级</a>
                        <a href="#" class="sort-item">中级</a>
                        <a href="#" class="sort-item">高级</a>
                    </div>
                </div>
                <div class="course-box" id="CourseTypeItemDiv">           
                </div>
            </div>
        </div>
    </div>
    <div class="footer-cc">
        <div class="foots">
            <div>
                版权所有： 南京java
            </div>
            <div>
                Copyright © 2017 imooc.com All Rights Reserved | 京ICP备
            </div>
        </div>
    </div>
</body>

</html>