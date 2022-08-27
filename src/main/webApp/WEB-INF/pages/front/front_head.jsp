<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href='${pageContext.request.contextPath}/iconfont/font_1/iconfont.css'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/front-index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
  <script>
    $(function(){
    	showSumA();
    	$(".signBtn").click(function() {
            $(".expe").show().addClass('animated forward fadeOutUp');

            $(".signBtn").html("已签到").unbind("click").addClass('gray').removeClass('hoverRed');

        });


        var isLogin = true;
        if (${sessionUser == null }) {
            isLogin = false;
        }
        changeUserDiv(isLogin);
		
		var msg = '${errorMsg}';
		if(msg){alert(msg);}
		
		$("#head-form").show();
		if(location.href=='http://localhost:8080${pageContext.request.contextPath}/gp/front_record.do'){
			$("#head-form").hide();
		}
    });
    
    //前台显示用户剩余积分和金币
    function showSumA(){
		$.ajax({
			url : '${pageContext.request.contextPath}/gp/findFrontSumByUid.do',
			type : 'post',
			dataType : 'json',
			success : function(data){
				$("#pointSum").html(data.obj.sum_point_count);
				$("#goldSum").html(data.obj.sum_gold_count);
			}
		})
    }



    //签到后更新时间 ajax
    function loginDate(id){
        // alert("签到方法执行")
        $.ajax({
            url:'${pageContext.request.contextPath}/user/updateLoginDate.do',
            data:{
                "id":id
            },
            dataType:'json',
            type:'post',
            success:function(data){
                showSumA();
            }
        });
    }

    function openUserModal(isRegist) {
        if (isRegist) { //是注册
            $("#regist_modal").modal("show");
            return;
        }
        //是登录
        $("#login_modal").modal("show");
    }

    function changeUserDiv(isLogin) {
        // alert("进去changeUserDiv"+isLogin);
        if (isLogin) { //
            $("#loginOff").hide();

            $("#loginOn").show();
            $("#login_modal").modal("hide");

            //判断是否需要签到
            $.ajax({
                url:'${pageContext.request.contextPath}/user/findLoginDate.do',
                dataType:'json',
                type:'get',
                success:function(data){
                    if (!data) {
                        $(".signBtn").html("已签到").unbind("click").addClass('gray').removeClass('hoverRed');
                    }
                }
            });


        } else {
            $("#loginOn").hide();
            $("#loginOff").show();
        }
    }

    //执行登录
    function doLogin(){
        $("#errMsg").text("");
        var login_name = $("#login_modal [name=login_name]").val();
        var password = $("#login_modal [name=password]").val();
        if(login_name == ""){
            $("#errMsg").text("用户名不能为空");
            return false;
        }

        if(password == ""){
            $("#errMsg").text("密码不能为空");
            return false;
        }

        $.ajax({
            url:'${pageContext.request.contextPath}/user/loginFront.do',
            data:{
                "login_name":login_name,
                "password":password
            },
            type:'post',
            dataType:'json',
            success:function(data) {
                if(data.success){
                    var isLogin = true;
                    location.href="${pageContext.request.contextPath}/login";
                    changeUserDiv(isLogin);
                }else{
                    $("#errMsg").text("用户名或者密码错误");
                }
            }
        });
    }

    //修改用户信息时，校验旧密码
    function  checkPassword(pwd){
        if (pwd != $("#modifyForm [name=password]").val() ) {
            var $span = $("#modifyForm [name=password]").parent().find("span");
            $span.html("旧密码输入有误，请重新输入")
            $span.css("color","red");
            $("#modifyForm [name=password]").empty();
            $("#modifyForm [name=password]").focus();
        }
        if (pwd == $("#modifyForm [name=password]").val() ) {
            var $span = $("#modifyForm [name=password]").parent().find("span");
            $span.html("旧密码输入正确");
            $span.css("color","green");
            $("#modifyForm [name=newPassword]").focus();
        }
    }
    ////修改用户信息时，重复新密码校验
    function checkRePassword() {

        var $span = $("#modifyForm [name=rePassword]").parent().find("span");
        $span.html("")
        var reg = /\w{3,20}/;
        if (reg.test($("#modifyForm [name=rePassword]").val())) {
            if ($("#modifyForm [name=newPassword]").val() != $("#modifyForm [name=rePassword]").val()) {
                var $span = $("#registForm [name=rePassword]").parent().find("span");
                $span.html("两次密码不一致，请重新输入")
                $span.css("color","red");
                $("#modifyForm [name=newPassword]").focus();
            }
            if ($("#modifyForm [name=newPassword]").val() == $("#modifyForm [name=rePassword]").val()) {
                var $span = $("#modifyForm [name=rePassword]").parent().find("span");
                // $span.html("密码一致")
                $span.html("")
                $span.css("color","green");
            }
        }else {
            var $span = $("#registForm [name=rePassword]").parent().find("span");
            $span.html("请输入有效密码：8-20位，仅支持字母、数字、下划线")
            $span.css("color","red");
            $("#registForm [name=newPassword]").focus();

    }


    }
    </script>
    
    
        <!-- head -->
    <nav class="navbar navbar-default">
        <div class="container-fluid" style="background: #fff;box-shadow: 5px 5px 5px #eef;padding-left: 20px;">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <!--  <a class="navbar-brand" href="#">Brand</a> -->
                <img src="${pageContext.request.contextPath}/images/com-logo1.png" alt="" width="120" style="margin-right: 20px;">
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="${pageContext.request.contextPath}/front_index.do" class="vertical-middle">免费课程</a></li>
                    <li><a href="#" class="vertical-middle">职业路径</a></li>
                </ul>
                <form id="head-form" action="${pageContext.request.contextPath}/front_select.do" class="navbar-form navbar-left searchInput" style="padding:10px;">
                    <div class="form-group">
                        <input type="text" class="" placeholder="Search" name="course_name">
                    </div>
                    <button type="submit" class="btn btn-default "><span class="glyphicon glyphicon-search"></span></button>
                </form>
                
                    <div id="loginOff" class="regist ccc">
                        <span style="margin-right: 20px;font-size: 14px;">下载APP</span>
                        <a href="javascript:openUserModal(false);" class="ccc"  id="loginbt">登录</a> &nbsp;&nbsp;/&nbsp;&nbsp;
                        <a href="javascript:openUserModal(true);" class="ccc">注册</a>
                    </div>
             
              
                    <ul id="loginOn" class="nav navbar-nav navbar-right">
                        <li class="nav navbar-nav signIn">
                            <div class="signBtn hoverRed" onclick="loginDate(${sessionUser.id })">签到</div>
                            <div class="expe">+5经验值</div>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle user-active" data-toggle="dropdown" role="button">
                                <img class="img-circle" src="${pageContext.request.contextPath}/images/user.jpg" id="userImg">
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu userinfo cc">
                                <li>
                                    <img src="${pageContext.request.contextPath}/images/user.jpg" class="img-circle" alt="">
                                    <div class="">
                                        <p>${sessionUser.nickname} </p>
                                        <p>金币<span id="goldSum"></span>&nbsp;积分 <span id="pointSum"></span></p>
                                    </div>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/course/findAllCourseForFront.do">
                                        <i class="glyphicon glyphicon-edit"></i>我的课程
                                    </a>
                                    <a href="${pageContext.request.contextPath}/gp/front_record.do">
                                        <i class="glyphicon glyphicon-record"></i>积分记录
                                    </a>
                                </li>
                                <li>
                                    <a href="#" data-toggle="modal" data-target="#userSet">
                                        <i class="glyphicon glyphicon-cog"></i>个人设置
                                    </a>
                                    <a href="${pageContext.request.contextPath}/user/loginOut1.do"><i class="glyphicon glyphicon-off"></i>退出登录</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
             
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>
    <!-- nav -->
    
    <div class="modal fade" id="userSet" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">个人信息</h4>
                </div>
                <form id="modifyForm" action="${pageContext.request.contextPath}/user/modifyUser.do"  class="form-horizontal" method="post">
                    <input type="hidden" name="id" value="${sessionUser.id }">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">旧密码：</label>
                            <div class="col-sm-6">
                                <input onblur="checkPassword(${sessionUser.password })" class="form-control" type="password" name="password" />
                                 <br/>
                                <span style="color:red"></span>
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
                                <input onblur="checkRePassword()" class="form-control" type="password" name="rePassword" />
                                <br/>
                                <span style="color:red"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">昵称：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" name="nickname" value="${sessionUser.nickname }"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">邮箱：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" name="email"  value="${sessionUser.email }"/>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                        <button type="reset" class="btn btn-info">重&nbsp;&nbsp;置</button>
                        <button onclick="changeUserInfo()" type="button" class="btn btn-info">确&nbsp;&nbsp;定</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- regist modal -->
    <div class="modal fade" id="regist_modal" tabindex="-1" role="dialog" aria-labelledby="myRegistLabel">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myRegistLabel">注册</h4>
                </div>
                <form id="registForm" action="#" class="form-horizontal" method="post">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">登录名：</label>
                            <div class="col-sm-6">
                                <input onblur="checkName()" class="form-control" type="text" name="login_name" />
                                <br/>
                                <span style="color:red"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">密码：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password" name="password" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">确认密码：</label>
                            <div class="col-sm-6">
                                <input onblur="checkRegistPassword()" class="form-control" type="password" name="rePassword" />
                                 <br/>
                                <span style="color:red"></span>
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
                                <span style="color:red"></span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                        <button id=registBtn type="button" onclick="doRegist()" class="btn btn-info">注&nbsp;&nbsp;册</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- login modal -->
    <div class="modal fade" id="login_modal" tabindex="-1" role="dialog" aria-labelledby="myLoginLabel">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myLoginLabel">登录</h4>
                </div>
                <form  class="form-horizontal" >
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">登录名：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" name="login_name" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">密码：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password" name="password" />
                            </div>
                        </div>
                        <div style="text-align:center">
                        	<span style="color:red">${errMsg1 }</span>
                        	<span style="color:red">${errMsg2 }</span>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                        <button type="button" class="btn btn-info" onclick="doLogin()">登&nbsp;&nbsp;录</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
   