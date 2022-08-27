<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
  <head>
    <title>优学堂精品课程管理系统登录</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" type="text/css"></link>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mycss.css" type="text/css"></link>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
  </head>
  <script>
  function codeRefresh(){
	     $("#randomCodeImg").attr("src","${pageContext.request.contextPath}/user/getCode.do?rt="+Math.random());
	   };
	   
	   //后台登录时校验
	   function submit(){
		   var login_name = $("#login_name").val();
		   var password = $("#password").val();
		   var randomCode = $("#randomCode").val();
		   if(login_name == null || login_name == ""){
	        	 $("#errMsg").text("用户名不能为空");
	             return false;
	         }

		   if(password == null || password == ""){
	        	 $("#errMsg").text("密码不能为空");
	             return false;
	         }

		   if(randomCode == null || randomCode == ""){
	        	 $("#errMsg").text("验证码不能为空");
	             //return false;
	         }
		   
		   $.ajax(
		    		{
		    			url:'${pageContext.request.contextPath}/user/loginBack.do',
		    			data:{
		    				"password":password,
		    				"login_name":login_name,
		    				"code":randomCode
		    			},
		    			type:'post',
		    			dataType:'json',
		    			success:function(data)
		   				{
		    				if(data.success){
		   						location.href="${pageContext.request.contextPath}/show_back_home.do"
		    				}else{
		    					$("#errMsg").text(data.msg);
		    				}
						}
		    		});
		   
	   }
	   

  </script>
  <body>
  	<!-- 使用自定义css样式 div-signin 完成元素居中-->
    <div class="containercc div-signin" style="position: relative; top: 50%; margin-top: -215px;">
      <div class="panel panel-primary div-shadow">
      	<!-- h3标签加载自定义样式，完成文字居中和上下间距调整 -->
	    <div class="panel-heading">
	    	<h3> 优学堂精品课程管理系统</h3>
	    	<span>High-quality Courses Manager System</span>
	    </div>
	    <div class="form-horizontal ccc">
	    <div class="panel-body">
	      <!-- login form start -->
		    <div class="form-group">
		       <label class="col-xs-3 control-label">用户名：</label>
		       <div class="col-xs-9">
		         <input name="login_name" class="form-control" id="login_name" type="text" placeholder="请输入用户名">
		       </div>
		    </div>
		    <div class="form-group">
		       <label class="col-xs-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
		       <div class="col-xs-9">
		         <input name="password" class="form-control" id="password" type="password" placeholder="请输入密码">
		       </div>
		    </div>
		    <div class="form-group">
		       <label class="col-xs-3 control-label">验证码：</label>
		       <div class="col-xs-4">
		         <input name = "code" class="form-control" id="randomCode" type="text" placeholder="请输入验证码">
		       </div>
		       <div class="col-xs-2">
		       	  <!-- 验证码图片加载（需引入验证码文件）图像高度经过测试，建议不要修改 -->
			      <img class="img-rounded" id = "randomCodeImg" src="${pageContext.request.contextPath}/user/getCode.do" alt="验证码" style="height: 32px; width: 70px;"/>
		       </div>
		       <div class="col-xs-2">
		         <button type="button" onclick="codeRefresh()" class="btn btn-link">看不清</button>
		       </div>
		    </div>
		    <div>
					<span style="color:red" id="errMsg" >${errMsg}</span>
			</div>
		    <br/>
		    <div class="form-group">
		       <div class="col-xs-9  col-xs-offset-3 padding-left-0">
		       	 <div class="col-xs-6">
			         <button type="reset" class="btn btn-primary btn-block">重&nbsp;&nbsp;置</button>
		       	 </div>
		       	 <div class="col-xs-6">
			         <button type="button" class="btn btn-primary btn-block" onclick ="submit()">登&nbsp;&nbsp;录</button>
		       	 </div>
		       </div>
		    </div>
		    </div>
	      <!-- login form end -->
	    </div>
	  </div>
    </div>
    <!-- 页尾 版权声明 -->
    <div class="containercc" style="position: relative;top: 50%;" >
		<div class="col-xs-12 foot-css" id="ccc" >
		        <p class="text-muted credit">
		            Copyright © 2017 南京网博 版权所有
		        </p>
	    </div>
    </div>
  </body>
</html>
