<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh">

<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>用户管理</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/back-index.css" />
<script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript"
	charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-mypaginator.js"></script>
<script src="${pageContext.request.contextPath}/js/template-web.js"></script>



<script type="text/javascript" charset="utf-8">
//后台修改用户状态禁用-启用
	function toggleStatus(id,status){
		var cp = myoptions.currentPage;
		$.ajax({
			url : '${pageContext.request.contextPath}/user/modifyBackUser.do',
			data : {
				"id":id,
				"status":status
			},
			type : 'post',
			dataType : 'json',
			success : function(data){
				ajaxLoadData(cp);
			},
		})
	}


	$(function() {
		ajaxLoadData(1);
		$(".doModify").on("click", function() {
			$(".modal-title").html("用户修改");
			$("#myModal").modal("show");
		});
		$(".updateOne").on("click", function() {
			$("#myModal").modal("hide");
		});

		// 显示隐藏查询列表
		$('#show-user-search').click(function() {
			$('#show-user-search').hide();
			$('#upp-user-search').show();
			$('.showusersearch').slideDown(500);
		});
		$('#upp-user-search').click(function() {
			$('#show-user-search').show();
			$('#upp-user-search').hide();
			$('.showusersearch').slideUp(500);
		});
		
	});
	
	//后台显示用户信息
	function showBackUser(id){
		$.ajax({
			url : '${pageContext.request.contextPath}/user/showBackUser.do',
			data : {
				"id" : id
			},
			type : 'post',
			dataType : 'json',
			success : function(data){
				$("#myModal").modal("show");
				$("#user_id").val(data.obj.id);
				$("#username").val(data.obj.nickname);
				$("#roleName").val(data.obj.role);
				$("#password").val(data.obj.password);
				$("#email").val(data.obj.email);
			}
		})
	}
	
	//后台修改用户信息
	function modifyUser(){
		var reg=new RegExp("^[a-z0-9A-Z]+[- | a-z0-9A-Z . _]+@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-z]{2,}$");
		var cp = myoptions.currentPage;
		var id = $("#user_id").val();
		var nickname = $("#username").val();
		var role = $("#roleName").val();
		var password = $("#password").val();
		var email = $("#email").val();
		if(nickname==null||nickname==""){
			alert("昵称不能为空");
			return;
		};
		if (email == "") {
			alert("邮箱不能为空");
			return;
		} else if(!reg.test(email)) {
			alert("邮箱格式不正确")
			return;
		}
		
		$.ajax({
			url : '${pageContext.request.contextPath}/user/modifyBackUser.do',
			data : {
					"id":id,
					"nickname":nickname,
					"role":role,
					"password":password,
					"email":email
					},
			type : 'post',
			dataType : 'json',
			success : function(data){
				$("#myModal").modal("hide");
				ajaxLoadData(cp);
			}
		})
	}	
//分页加载数据
	function ajaxLoadData(page){
		var login_name =$("#user-name").val();
		var nickname =$("#user-nickname").val();
		var role =$("#role-name option:selected").val();
		var email =$("#user-email").val();
		var create_start_date =$("#create_start_date").val();
		var create_end_date =$("#create_end_date").val();
		var login_start_date =$("#login_start_date").val();
		var login_end_date =$("#login_end_date").val();
		
		$.ajax({
				url:'${pageContext.request.contextPath}/user/findBackUser.do',
				data:{
					"pageNo":page,
					"login_name":login_name,
					"nickname":nickname,
					"role":role,
					"email":email,
					"create_start_date":create_start_date,
					"create_end_date":create_end_date,
					"login_start_date":login_start_date,
					"login_end_date":login_end_date
				},
				dataType:'json',
				type:'post',
				success:function(data)
				{
					pageNo = data.pageNum; 
					myoptions.onPageClicked = function(event, originalEvent,type, page) {
						ajaxLoadData(page);
					};
					if(data.pages==0){
						myPaginatorFun("myPages", 1, 1);	
					}else{
						myPaginatorFun("myPages", pageNo, data.pages);
					}
					$("#tb").children().remove();
					var html = template('userBack_template', data);
					$("#tb").append(html);
				}
			})
		}
</script>


	<script type="text/html" id="userBack_template">
		{{each list  item}}
			<tr>
				<td>{{item.id}}</td>
				<td>{{item.login_name}}</td>
				<td>{{if item.role=='admin'}}
					管理员			
				{{/if}}
				{{if item.role=='normal'}}
					普通			
				{{/if}}</td>
				<td>{{item.nickname}}</td>
				<td>{{item.email}}</td>
				<td class ="dateFormat">{{item.create_date}}</td>
				<td class ="dateFormat">{{item.login_date}}</td>
				<td class="text-center">
					<input onclick="showBackUser({{item.id}})" type="button" class="btn btn-warning btn-sm doModify" value="修改" /> 
					{{if item.status==0&&item.role!='admin'}}
					<input onclick="toggleStatus({{item.id}},1)" type="button" class="btn btn-danger btn-sm" value="禁用" />
					{{/if}}
					{{if item.status==1&&item.role!='admin'}}
					<input onclick="toggleStatus({{item.id}},0)" type="button" class="btn btn-success btn-sm" value="启用" />
					{{/if}}
				</td>
			</tr>
		{{/each}}
	</script>	
</head>

<body>
	<div class="panel panel-default" id="userInfo">
		<div class="panel-heading">
			<h3 class="panel-title">用户管理<span id="errorMsg" style="color:red;font-size:30px;">${errorMsg}</span></h3>

		</div>
		<div>
			<input type="button"  onclick="ajaxLoadData(1)" value="查询" class="btn btn-success" id="doSearch"
				style="margin: 5px 5px 5px 15px;" /> <input type="button"
				class="btn btn-primary" id="show-user-search" value="展开搜索" /> <input
				type="button" value="收起搜索" class="btn btn-primary"
				id="upp-user-search" style="display: none;" />
		</div>

		<div class="panel-body">
			<div class="showusersearch" style="display: none;">
				<form class="form-horizontal"id="searchForm">
					<div class="form-group">
						<div class="form-group col-xs-6">
							<label for="user-name" class="col-xs-3 control-label">登录名：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="user-name"
									placeholder="请输入登录名" />
							</div>
						</div>
						<div class="form-group col-xs-6">
							<label for="user-nickname" class="col-xs-3 control-label">昵称：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="user-nickname"
									placeholder="请输入昵称" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-group col-xs-6">
							<label for="user-email" class="col-xs-3 control-label">邮箱：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="user-email"
									placeholder="请输入邮箱" />
							</div>
						</div>
						<div class="form-group col-xs-6">
							<label for="role-name" class="col-xs-3 control-label">角色：</label>
							<div class="col-xs-8">
								<select class="form-control" id="role-name" name="role-name">
									<option value="-1">全部</option>
									<option value="normal">普通</option>
									<option value="admin">管理员</option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-group col-xs-6">
							<label class="col-xs-3 control-label">开始日期：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="create_start_date"
									placeholder="请输入创建开始时间:2017-10-10" />
							</div>
						</div>
						<div class="form-group col-xs-6">
							<label class="col-xs-3 control-label">结束日期：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="create_end_date"
									placeholder="请输入创建结束时间:2017-10-12" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-group col-xs-6">
							<label class="col-xs-3 control-label">开始日期：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="login_start_date"
									placeholder="请输入登录开始时间:2017-10-10" />
							</div>
						</div>
						<div class="form-group col-xs-6">
							<label class="col-xs-3 control-label">结束日期：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="login_end_date"
									placeholder="请输入登录结束时间:2017-10-12" />
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="show-list">
				<table class="table table-bordered table-hover"
					style='text-align: center;'>
					<thead>
						<tr class="text-danger">
							<th class="text-center">编号</th>
							<th class="text-center">登录名</th>
							<th class="text-center">角色</th>
							<th class="text-center">昵称</th>
							<th class="text-center">邮箱</th>
							<th class="text-center">创建日期</th>
							<th class="text-center">最近登录日期</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody id="tb">						
						
					</tbody>
				</table>
			</div>
			<!-- 分页 -->
			<div style="text-align: center;">
				<ul id="myPages"></ul>
			</div>

			<div class="modal fade" tabindex="-1" id="myModal">
				<!-- 窗口声明 -->
				<div class="modal-dialog modal-lg">
					<!-- 内容声明 -->
					<div class="modal-content">
						<!-- 头部、主体、脚注 -->
						<div class="modal-header">
							<button class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">用户修改</h4>
						</div>
						<div class="modal-body text-center">
							<div class="row text-right">
								<label for="user_id" class="col-xs-4 control-label">编号：</label>
								<div class="col-xs-4">
									<input type="text" class="form-control" id="user_id"
										readonly="true" />
								</div>
							</div>
							<br>
							<div class="row text-right">
								<label for="username" class="col-xs-4 control-label">昵称：</label>
								<div class="col-xs-4">
									<input type="text" class="form-control" id="username" />
								</div>
							</div>
							<br>
							<div class="row text-right">
								<label for="roleName" class="col-xs-4 control-label">角色：</label>
								<div class="col-xs-4">
									<select class="form-control" id="roleName"/>
										<option value="normal">普通</option>
										<option value="admin">管理员</option>
									</select>
								</div>
							</div>
							<br>
							<div class="row text-right">
								<label for="password" class="col-xs-4 control-label">密码：</label>
								<div class="col-xs-4">
									<input type="text" class="form-control" id="password" />
								</div>
							</div>
							<br>
							<div class="row text-right">
								<label for="email" class="col-xs-4 control-label">邮箱：</label>
								<div class="col-xs-4">
									<input type="email" class="form-control" id="email" />
								</div>
							</div>
							
							<br>
						</div>
						<div class="modal-footer">
							<button onclick="modifyUser()" class="btn btn-warning updateOne">修改</button>
							<button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>