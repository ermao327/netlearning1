<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
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
        //用户名校验 ajax
        function checkName(){
            console.log(".......")
            $.post('${pageContext.request.contextPath}/user/check.do',
                {
                    "login_name" :$("#registForm [name=login_name]").val()
                },

                function(data){
                    var $span = $("#registForm [name=login_name]").parent().find("span");
                    $span.html(data.msg)
                    $span.css("color","red");
                    $("#registBtn").attr("disabled",!data.success);
                    if (data.success) {
                        $span.css("color","green");
                    }
                },
                'json');
        }


        //注册 ajax
        function doRegist(){
            // alert("注册")
            $.ajax({
                url:'${pageContext.request.contextPath}/user/regist.do',
                data:$("#registForm").serialize(),
                dataType:'json',
                type:'post',
                success:function(data){
                    // alert("注册成功")
                    if (data.success) {
                        $("#login_modal").modal("show");
                        $("#regist_modal").modal("hide");
                        return;
                    }
                    var $span = $("#registForm [name=login_name]").parent().find("span");
                    $span.html(data.msg);
                    $span.css("color","red");
                }
            });
        }

        //注册时校验密码 ajax
        function checkRegistPassword(){
            var reg = /\w{3,20}/;
            if (reg.test($("#registForm [name=rePassword]").val())) {
                if ($("#registForm [name=password]").val() != $("#registForm [name=rePassword]").val()) {
                    var $span = $("#registForm [name=rePassword]").parent().find("span");
                    $span.html("两次密码不一致，请重新输入")
                    $span.css("color","red");
                    $("#registForm [name=password]").focus();
                }
                if ($("#registForm [name=password]").val() == $("#registForm [name=rePassword]").val()) {
                    var $span = $("#registForm [name=rePassword]").parent().find("span");
                    // $span.html("密码一致")
                    $span.html("")
                    $span.css("color","green");
                }
            }else {
                var $span = $("#registForm [name=rePassword]").parent().find("span");
                $span.html("请输入有效密码：8-20位，仅支持字母、数字、下划线")
                $span.css("color","red");
                $("#registForm [name=password]").focus();
            }
        }

        //注册时昵称校验 ajax
        function checkNickName(){
            // var reg = /\w[\u4e00-\u9fa5]{1,30}/;
            var reg = /\w{1,30}$/
            if (!(reg.test($("#registForm [name=nickname]").val()))){
                var $span = $("#registForm [name=email]").parent().find("span");
                $span.html("请输入有效昵称")
                $span.css("color","red");
                // $("#registForm [name=nickname]").focus();
            }else {
                var $span = $("#registForm [name=email]").parent().find("span");
                $span.html("")
            }

        }


        //注册时邮箱校验 ajax
        function checkEmail(){
            $.post('${pageContext.request.contextPath}/user/check2.do',
                {
                    "email" :$("#registForm [name=email]").val()
                },

                function(data){
                    var $span = $("#registForm [name=email]").parent().find("span");
                    $span.html(data.msg);
                    $span.css("color","red");
                    $("#registBtn").attr("disabled",!data.success);
                    if (data.success) {
                        $span.css("color","green");
                    }
                },
                'json');
        }


        //修改用户信息 ajax
        function changeUserInfo(){

            // alert("修改信息方法")
            $.ajax({
                url:'${pageContext.request.contextPath}/user/modifyUser.do',
                data:$("#modifyForm").serialize(),
                dataType:'json',
                type:'post',
                success:function(data){
                    alert(data.msg);
                    location.reload();
                }
            });
        }


        //加载页面
        $(function(){
            //加载左侧课程类型数据（三级）
            loadLeftCourseType();
            //加载前十五条数据
            loadTop15Courses();
        });

        function loadLeftCourseType(){
            // alert("do  loadLeftCourseType")
            $.ajax({
                url:'${pageContext.request.contextPath}/ct/findCourseType.do',
                dataType:'json',
                type:'post',
                success:function(data){
                    // alert("loadLeftCourseType success"+data);
                    var html = template('typeItemList',{"obj": data});
                    $("#typeItemDiv").append(html);
                }
            });
        }

        function loadTop15Courses(){
            $.ajax({
                url:'${pageContext.request.contextPath}/course/showTop15.do',
                dataType:'json',
                type:'post',
                success:function(data)
                {
                    var html = template('Top15CoursesList',{"list": data});
                    $("#Top15CoursesDiv").append(html);
                }
            });
        }

    </script>
    <script type="text/html" id="Top15CoursesList">
        {{each list  course i}}
             {{if i%5 == 0 }} 
				<div class="course-box" >
			 {{/if}}
    			<div class="course-item">
                    <div class="item-t">
                        <img src="${pageContext.request.contextPath}/upload/course_cover/{{course.cover_image_url}}" alt="">
                        <div class="java">
                            <label> {{course.courseType.type_name}}</label>
                        </div>
                    </div>
                    <div class="item-b">
                        <a href="showFront_courseDetail.do?courseName={{course.course_name}}">
                            <h4>{{course.course_name}}</h4>
                        </a>
                        <p class="title">
                            <span>实战</span>
                            <span>高级</span>
                            <span>作者：{{course.author}}</span>
                            <span>点击量：{{course.click_number}}</span>
                        </p>
                        <p class="price">￥ 888.00</p>
                    </div>
           		 </div>	
			{{if (i-4)%5 == 0 }} 
			</div>
            {{/if}}
        {{/each}}
    </script>
    <script type="text/html" id="typeItemList">
        {{each obj.courseTypes  type1 index1}}
            <div class="item" typeId="{{type1.id}}" data-id="a">
                <a href="#">
                    <span class="group">{{type1.type_name}}</span>
                    <span class="tip">&gt;</span>
                </a>
                <div class="course-detail">
                    {{each type1.childrens  type2 index2}}
                    <div class="one">
                        <div class="base" typeId="{{type2.id}}" >
                            <span>{{type2.type_name}}</span>
                            <div class="line"></div>
                        </div>
                        <p>
                            {{each type2.childrens  type3 index3}}
                            <a href="#">
                                <span typeId="{{type3.id}}" >{{type3.type_name}}</span>
                            </a>
                            {{/each}}
                        </p>
                    </div>
                    {{/each}}
                    <!-- 当前分类下,点击量前四的课程 -->
                    <div class="two">
                        <div class="item-box" >
    					{{each obj.courses  course index1}}
	              		 {{if type1.id== course.course_type_id }}  
                            <a href="showFront_courseDetail.do?courseName={{course.course_name}}">
                                <div class="item-course">
                                    <div class="item-course-l">
                                        <img src="${pageContext.request.contextPath}/upload/course_cover/{{course.cover_image_url}}" alt="">
                                    </div>
                                    <div class="item-course-r">
                                        <p>{{type1.type_name}}：{{course.course_name}}</p>
                                        <p>
                                            <span>{{course.course_info}}</span>
                                            <span>{{course.author}}</span>
                                            <span>{{course.click_number}}</span>
                                        </p>
                                        <p>￥888.00</p>
                                    </div>
                                </div>
                            </a>
                           {{/if}}
                        {{/each}}
                        </div>
                    </div>
                </div>
            </div>
        {{/each}}
    </script>
</head>

<body>
<div class="wrap-cc">
    <div class="content-cc">
    <jsp:include page="front_head.jsp"></jsp:include>
    <div class="main">
        <!-- 左侧 -->
        <div id="typeItemDiv" class="menu-left">
        
        </div>
        <!-- 右侧 -->
        <div class="menu-right">
            <!-- banner -->
            <div class="banner">
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <img src="${pageContext.request.contextPath}/images/banner01.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="${pageContext.request.contextPath}/images/banner02.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="${pageContext.request.contextPath}/images/banner03.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="${pageContext.request.contextPath}/images/banner04.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="${pageContext.request.contextPath}/images/banner05.jpg" alt="">
                        </div>
                    </div>
                    <!-- Add Pagination -->
                    <div class="swiper-pagination"></div>
                </div>
            </div>
            <!-- 课程信息 -->
            <div class="tips">
                <div class="path-banner">
                    <a href="#">
                        <i class="i-web"></i>
                        <p class="tit">Web前端攻城狮</p>
                        <p class="desc">互联网时代最火爆的技术</p>
                    </a>
                    <a href="#">
                        <i class="i-java"></i>
                        <p class="tit">Java攻城狮</p>
                        <p class="desc">健壮、安全、适用广泛</p>
                    </a>
                    <a href="#">
                        <i class="i-android"></i>
                        <p class="tit">Android攻城狮</p>
                        <p class="desc">移动设备市场份额第一</p>
                    </a>
                    <a href="#">
                        <i class="i-php"></i>
                        <p class="tit">PHP攻城狮</p>
                        <p class="desc">世界上最好的语言：）</p>
                    </a>
                    <a href="#">
                        <i class="i-ios"></i>
                        <p class="tit">iOS攻城狮</p>
                        <p class="desc">可能是全球最好用的系统</p>
                    </a>
                </div>
            </div>
        </div>
    </div>
        <!-- 实战推荐 -->
        <div   class="course" id="Top15CoursesDiv">
            <h3 class="types-title">                
                <span class="tit-icon tit-icon-l"></span>
                <em>实</em>／<em>战</em>／<em>推</em>／<em>荐</em>
            </h3>
            
        </div>    <!-- 实战推荐 -->
   
    </div>
</div>
<div class="footer-cc">
    <div class="foots">
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