<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>评论审核</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/back-index.css" />
<script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-mypaginator.js"></script>
<script src="${pageContext.request.contextPath}/js/template-web.js"></script>

<script type="text/javascript">
	$(function() {
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
</script>
<script type="text/javascript">
	$(function() {
		//进入页面后发送ajax请求载待审加核评论
		loadComs(1);
		//给跳转li绑定点击事件添加active样式
		$("myPages:li").click(function() {
			$(this).addClass("active");
		});
	});

	//加载评论的方法
	function loadComs(pageNo) {
		let name = $("#user-name").val();
		let beginDate = $("#begin_date").val();
		let endDate = $("#end_date").val();
		let context = $("#user-comment").val();
		$.ajax({
			url : '${pageContext.request.contextPath}/comment/findComs.do',
			data : {
				"login_name" : name,
				"begin_date" : beginDate,
				"end_date" : endDate,
				"context" : context,
				"pageNo" : pageNo,
				"status" : 2
			},
			dataType : 'json',
			type : 'post',
			success : function(data) {
				let $tr = $("#tb").children();
				$tr.remove();
				var coms = data.obj.list;
				var info = data.obj;
				if (pageNo == 1) 
				{
					myoptions.onPageClicked = function(event, originalEvent,
							type, page) {
						loadComs(page);
					};
					myPaginatorFun("myPages", 1, info.pages);
				}
				var html = template("comments", {d : coms});
				$("#tb").append(html);
			}
		});
	}
	//通过审核/禁用评论的方法--wj
	//status参数：通过：0;禁用：1
	function toggle(id,status,item){
		$.ajax(
		{
			url:'${pageContext.request.contextPath}/comment/toggle.do',
			data:{"id":id,"status":status},
			type:'post',
			success:function(data)
			{
				$(item).parent().parent().remove();
			}
		});
	}
</script>
<script type="text/html" id="comments">
  	    {{ each d item i }}
  		      <tr>
                    <td>{{i+1}}</td>
                    <td>{{item.context}}</td>
                    <td>{{item.login_name}}</td>
                    <td>{{item.create_date}}</td>
                    <td>{{item.praise_count}}</td>
                    <td>
						{{if item.status==0 }} 启用 {{/if}}
						{{if item.status==1 }} 禁用 {{/if}}
						{{if item.status==2 }} 待审核 {{/if}}
					</td>
                    <td class="text-center">
                        <input type="button" onclick="toggle({{item.id}},0,this)" class="btn btn-success btn-sm" value="通过" />
                        <input type="button" onclick="toggle({{item.id}},1,this)" class="btn btn-danger btn-sm" value="禁用" />
                    </td>
              </tr>
  	     {{/each}}
    </script>

</head>

<body>
	<div class="panel panel-default" id="userSet">
		<div class="panel-heading">
			<h3 class="panel-title">评论审核</h3>
		</div>
		<div>
			<input onclick="loadComs(1)" type="button" value="查询" class="btn btn-success" id="doSearch"
				style="margin: 5px 5px 5px 15px;" /> 
			<input type="button"
				class="btn btn-primary" id="show-user-search" value="展开搜索" /> 
			<input type="button" value="收起搜索" class="btn btn-primary"
				id="upp-user-search" style="display: none;" />
		</div>

		<div class="panel-body">
			<div class="showusersearch" style="display: none;">
				<form class="form-horizontal">
					<div class="form-group">
						<div class="form-group col-xs-6">
							<label for="user-name" class="col-xs-3 control-label">用户名：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="user-name"
									placeholder="请输入用户名" />
							</div>
						</div>
						<div class="form-group col-xs-6">
							<label for="user-comment" class="col-xs-3 control-label">评论内容：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="user-comment"
									placeholder="请输入评论内容" />
							</div>
						</div>
					</div>
					<!-- <div class="form-group">
                        <div class="form-group col-xs-6">
                            <label for="role-name" class="col-xs-3 control-label">状态：</label>
                            <div class="col-xs-8">
                                <select class="form-control" id="role-name" name="role-name" >
                                    <option value="-1" >全部</option>
                                    <option value="普通" >待审核</option>
                                    <option value="管理员" >禁用</option>
                                    <option value="管理员" >启用</option>
                                </select>
                            </div>
                        </div>
                    </div> -->
					<div class="form-group">
						<div class="form-group col-xs-6">
							<label class="col-xs-3 control-label">开始日期：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="begin_date"
									placeholder="请输入评论开始时间:2018-07-10" />
							</div>
						</div>
						<div class="form-group col-xs-6">
							<label class="col-xs-3 control-label">结束日期：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="end_date"
									placeholder="请输入评论结束时间:2018-07-10" />
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
							<th class="text-center">评论内容</th>
							<th class="text-center">用户名</th>
							<th class="text-center">评论时间</th>
							<th class="text-center">赞</th>
							<th class="text-center">状态</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody id="tb">
						<!--此处为评论展示区-->
					</tbody>
				</table>
			</div>

			<div style="text-align: center;">
				<ul id="myPages">
					<!--此处为页面跳转展示区-->
				</ul>
				<!-- 分页 -->
			</div>

		</div>
	</div>
</body>

</html>