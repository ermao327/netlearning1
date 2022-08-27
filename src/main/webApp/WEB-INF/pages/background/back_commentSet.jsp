<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>评论管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/back-index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-mypaginator.js"></script>
	<script src="${pageContext.request.contextPath}/js/template-web.js"></script>
    <script type="text/javascript" >
        $(function(){
            //返回章节列表
            $("#back").on('click', function(){
                $('#frame-id', window.parent.document).attr('src', 'back_crs.do');
            });

            // 显示隐藏查询列表
            $('#show-comment-search').click(function() {
                $('#show-comment-search').hide();
                $('#upp-comment-search').show();
                $('.show-comment-search').slideDown(500);
            });
            $('#upp-comment-search').click(function() {
                $('#show-comment-search').show();
                $('#upp-comment-search').hide();
                $('.show-comment-search').slideUp(500);
            });
        });

    </script>
    <script type="text/javascript">
	$(function() {
		//进入页面后发送ajax请求加载待审核评论
		loadComs(1);
		//给跳转li绑定点击事件添加active样式
		$("myPages:li").click(function() {
			$(this).addClass("active");
		});
	});
	
	//加载评论的方法
	function loadComs(pageNo) {
		var chapter_id = $("#chapter_id_holder").val();
		let name = $("#user-name-search").val();
		let beginDate = $("#begin_date").val();
		let endDate = $("#end_date").val();
		let context = $("#user-comment-search").val();
		let status = $("#course-resource-stauts-search").val();
		$.ajax({
			url : '${pageContext.request.contextPath}/comment/findByChapterId.do',
			data : {
				"login_name" : name,
				"begin_date" : beginDate,
				"end_date" : endDate,
				"context" : context,
				"pageNo" : pageNo,
				"status":status,
				"chapter_id":chapter_id
			},
			dataType : 'json',
			type : 'post',
			success : function(data) {
				let $tr = $("#tb").children();
				$tr.remove();
				var coms = data.obj.list;
				if(coms == null){swal("暂无待审核评论");return;}
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
	//通过审核/禁用评论的方法
	//status参数：通过：0;禁用：1
	function toggle(id,status,item){
		$.ajax(
		{
			url:'${pageContext.request.contextPath}/comment/toggle.do',
			data:{"id":id,"status":status},
			type:'post',
			success:function()
			{
				location.reload();
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
						{{if item.status == 1}}禁用{{/if}}
						{{if item.status == 0}}启用{{/if}}
				 </td>
                 <td class="text-center">
                     <input type="button" 
							{{if item.status == 1}} class="btn btn-success btn-sm" value="启用" onclick="toggle({{item.id}},0,this)" {{/if}}	
							{{if item.status == 0}} class="btn btn-danger btn-sm" value="禁用" onclick="toggle({{item.id}},1,this)" {{/if}}	
								 />
                 </td>
            </tr>
  	     {{/each}}
    </script>
</head>

<body>
	<input type="hidden" id="chapter_id_holder" value="${chapter_id}"/>
    <div class="panel panel-default" id="userSet">
        <div class="panel-heading">
            <h3 class="panel-title">评论管理</h3>
        </div>
        <div>
            <!-- course-resource-id,没有时,移除此按钮 -->
            <input type="hidden" name="course_resource_id" value=""  />
            <input onclick="loadComs(1)" type="button" value="查询" class="btn btn-success" id="doSearch" style="margin: 5px 5px 5px 15px;" />
            <input type="button" class="btn btn-primary" id="show-comment-search" value="展开搜索" />
            <input type="button" value="收起搜索" class="btn btn-primary" id="upp-comment-search" style="display: none;" />
            <input type="button" value="返回章节列表" class="btn btn-success" id="back" style="margin: 5px 15px 5px 0px;float: right;" />
        </div>

        <div class="panel-body">
            <div class="show-comment-search" style="display: none;">
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="form-group col-xs-6">
                            <label for="user-name-search" class="col-xs-3 control-label">用户名：</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" id="user-name-search" placeholder="请输入用户名" />
                            </div>
                        </div>
                        <div class="form-group col-xs-6">
                            <label for="user-comment-search" class="col-xs-3 control-label">内容：</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" id="user-comment-search" placeholder="请输入评论内容" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group col-xs-6">
                            <label class="col-xs-3 control-label">开始日期：</label>
                            <div class="col-xs-8">
                                <input id="begin_date" type="text" class="form-control" placeholder="请输入开始时间:2018-07-10" />
                            </div>
                        </div>
                        <div class="form-group col-xs-6">
                            <label class="col-xs-3 control-label">结束日期：</label>
                            <div class="col-xs-8">
                                <input id="end_date" type="text" class="form-control" placeholder="请输入结束时间:2018-07-10" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group col-xs-6">
                            <label for="course-resource-stauts-search" class="col-xs-3 control-label">状态：</label>
                            <div class="col-xs-8">
                                <select class="form-control" id="course-resource-stauts-search" name="course-resource-stauts-search" >
                                    <option value="-1" >全部</option>
                                    <option value="0" >启用</option>
                                    <option value="1" >禁用</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                </form>
            </div>

            <div class="show-list">
                <table class="table table-bordered table-hover" style='text-align: center;'>
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
                        <!-- 此处为评论展示区 -->
                       
                    </tbody>
                </table>
            </div>

            <!-- 分页 -->
            <div style="text-align: center;" >
                <ul id="myPages" >
                	<!-- 此处为页码展示 -->
                </ul>
            </div>

        </div>
    </div>
</body>

</html>