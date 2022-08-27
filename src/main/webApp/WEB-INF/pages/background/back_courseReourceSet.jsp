<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>课程章节管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/back-index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-mypaginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/template-web.js"></script>
    <style type="text/css" >
    .file {
        position: relative;
        display: inline-block;
        background: #D0EEFF;
        border: 1px solid #99D3F5;
        border-radius: 4px;
        padding: 4px 12px;
        overflow: hidden;
        color: #1E88C7;
        text-decoration: none;
        text-indent: 0;
        line-height: 20px;
        width: 100%;
        text-align: center;
    }
    .file:hover {
        background: #AADFFD;
        border-color: #78C3F3;
        color: #004974;
        text-decoration: none;
    }
    .file:focus {
        background: #AADFFD;
        border-color: #78C3F3;
        color: #004974;
        text-decoration: none;
    }
    </style>

    <script type="text/javascript" >
        $(function(){
            //返回课程列表
            $("#back").on('click', function(){
                $('#frame-id', window.parent.document).attr('src', 'back_courseSet.do ');
                $('#frame-id', window.parent.document).attr('src', 'back_courseSet.do');
            });
            //相关评论
            $(".comment-detail").on('click', function(){
                $('#frame-id', window.parent.document).attr('src', 'back_comset.do');
            });

            //添加章节
            $("#doAddCourseReource").on('click', function(){
                $(".modal-title").html("添加章节");
                $("#course-resource-id-input").hide();
                $("#courseReourceModal").modal("show");
                $("#course-resource-title").val("");
                $("#course-resource-context").val("");
                //重新绑定点击事件
                $("#confirmBt").unbind("click");
                $("#confirmBt").bind("click",addChapter);
            });


            $(".course-reource-btn").on('click', function(){
                $("#courseReourceModal").modal("hide");
            });

            $(".course-reource-modify-btn").on('click', function(){
                $(".modal-title").html("修改章节");
                $("#course-resource-id-input").show();
                $("#courseReourceModal").modal("show");
            });

            //显示播放页
            $(".resource-detail").on('click', function(){
                $('#frame-id', window.parent.document).attr('src', 'back_rds.do');
            });

            // 显示隐藏查询列表
            $('#show-course-resource-search').click(function() {
                $('#show-course-resource-search').hide();
                $('#upp-course-resource-search').show();
                $('.show-course-resource-search').slideDown(500);
            });
            $('#upp-course-resource-search').click(function() {
                $('#show-course-resource-search').show();
                $('#upp-course-resource-search').hide();
                $('.show-course-resource-search').slideUp(500);
            });
        });

        function fileUpload(item){
            $(item).click();
        }
        function fileChange(item){
            var file = item.files[0];//获取选中的第一个文件
            $(".file").html(file.name);
            //console.log("file", file.name);
        }

    </script>
    <script type="text/javascript">
    	$(function(){
    		loadChapter(1);
    	});
    	
    	/**
    	*--
    	*章节加载方法
    	*/
    	function loadChapter(pageNo)
    	{
    		var course_id = $("#course_id_holder").val();
			var begin_date = $("#begin_date_time").val();
			var end_date = $("#end_date_time").val();
			var title = $("#course-resource-title-search").val();
			var info = $("#course-resource-info-search").val();
			var status = $("#course-resource-stauts-search").val();
    		$.ajax(
    		{
    			url:'${pageContext.request.contextPath}/chapter/loadChapter.do',
    			data:
    			{
    				"pageNo":pageNo,
    				"course_id":course_id,
    				"begin_date":begin_date,
    				"end_date":end_date,
    				"title":title,
    				"info":info,
    				"status":status
    			},
    			type:'post',
    			success:function(data)
    			{
    				data=JSON.parse(data);
   					let $tr = $("#tb").children();
					$tr.remove();
					var chapters = data.obj.list;
					var info = data.obj;
    				if(pageNo==1)
    				{
    					myoptions.onPageClicked = function(event, originalEvent,
							type, page) {
						loadChapter(page);
						};
						myPaginatorFun("myPages", 1, info.pages);
    				}
    				var html = template("chapters_info", {d : chapters});
                    $("#tb").append(html);
                    $("#currentPage").val(info.pageNum);
    			}
    		});
    	}


        /**
        *--
        *启用禁用课程的方法--
        */
        function toggleStatus(item,id,status)
        {
            $.ajax(
            {
                url:'${pageContext.request.contextPath}/chapter/modifyChapter.do',
                data:{"id":id,"status":status},
                type:'post',
                success:function()
                {
                    loadChapter($("#currentPage").val());
                }
            });
        }


        /**
        *--
        *添加课程的方法--
        */
        function addChapter()
        {
            var chapterTitle = $("#course-resource-title").val();
            var chapterInfo = $("#course-resource-context").val();
            var course_id = $("#course_id_holder").val(); 
            $.ajax(
            {
                url:'${pageContext.request.contextPath}/chapter/addChapter.do',
                data:{
                    "title":chapterTitle,
                    "info":chapterInfo,
                    "course_id":course_id
                },
                type:'post',
                dataType:"json",
                success:function(data){
                    alert(data.msg);
                    location.reload();
                }
            });
        }
        /**
        *--
        *修改课程章节前的查询方法
        */
        function showToModify(id){
            //弹出模态框
            $(".modal-title").html("修改章节");
            $("#course-resource-id-input").hide();
            $("#courseReourceModal").modal("show");
            $("#confirmBt").unbind("click");//取消查询的点击事件
            $("#confirmBt").bind("click",modifyChapter);//绑定修改事件
            $.ajax(
            {
                url:'${pageContext.request.contextPath}/chapter/showToModify.do',
                data:{"id":id},
                type:'post',
                success:function(data){
                	data = JSON.parse(data);
                    let chapterItem = data.obj;
                    $("#course-resource-title").val(chapterItem.title);
                    $("#course-resource-context").val(chapterItem.info);
                    $("#course-resource-id").val(chapterItem.id);
                }
            });
        }

         /**
        *--
        *修改课程的方法--
        */
        function modifyChapter()
        {
            var chapterTitle = $("#course-resource-title").val();
            var chapterInfo = $("#course-resource-context").val();
            var id = $("#course-resource-id").val();
            $.ajax(
            {
                url:'${pageContext.request.contextPath}/chapter/modifyChapter.do',
                data:{
                    "title":chapterTitle,
                    "info":chapterInfo,
                    "id":id
                },
                type:'post',
                dataType:"json",
                success:function(data){
                    alert(data.msg);
                    location.reload();
                }
            });
        }
    </script>
    <script type="text/html" id="chapters_info">
		{{ each d item i }}
			<tr>
	              <td>{{i+1}}</td>
	              <td>{{item.title}}</td>
	              <td>{{item.info}}</td>
	              <td>{{item.create_date}}</td>
	              <td>
					{{if item.status==0}} 启用 {{/if}}
					{{if item.status==1}} 禁用 {{/if}}
				  </td>
	              <td class="text-center">
	                  <input type="button" onclick="showToModify({{item.id}})" class="btn btn-warning btn-sm course-reource-modify-btn" value="修改">
                      {{if item.status==0}}
	                  <input onclick="toggleStatus(this,{{item.id}},1)" type="button" class="btn btn-danger btn-sm" value="禁用">
                      {{/if}}
                      {{if item.status==1}}
                      <input onclick="toggleStatus(this,{{item.id}},0)" type="button" class="btn btn-success btn-sm" value="启用">
                      {{/if}}
					  <a href="${pageContext.request.contextPath}/chapter/sendChapterId.do?chapter_id={{item.id}}">
	                 	 <input type="button" class="btn btn-success btn-sm comment-detail" value="相关评论" />
	              	  </a>
			      </td>
	          </tr>
		{{/each}}
	</script>
</head>

<body>
    <div class="panel panel-default" id="userSet">
        <div class="panel-heading">
            <h3 class="panel-title">课程章节管理</h3>
        </div>
        <div>
            <input type="button" value="添加章节" class="btn btn-primary" id="doAddCourseReource" style="margin: 5px 5px 5px 15px;" />
            <input type="button" value="查询" onclick="loadChapter(1)" class="btn btn-success" id="doSearch" style="margin: 5px 5px 5px 0px;" />
            <input type="button" class="btn btn-primary" id="show-course-resource-search" value="展开搜索" />
            <input type="button" value="收起搜索" class="btn btn-primary" id="upp-course-resource-search" style="display: none;" />
            <input onclick="history.back()" type="button" value="返回课程列表" class="btn btn-success" id="back" style="margin: 5px 15px 5px 0px;float: right;" />
        </div>
        <div class="panel-body">
            <div class="show-course-resource-search" style="display: none;">
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="form-group col-xs-6">
                            <label for="course-resource-title-search" class="col-xs-3 control-label">标题：</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" id="course-resource-title-search" placeholder="请输入标题" name="title" />
                            </div>
                        </div>
                        <div class="form-group col-xs-6">
                            <label for="course-resource-info-search" class="col-xs-3 control-label">简介：</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" id="course-resource-info-search" placeholder="请输入简介" name="info"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group col-xs-6">
                            <label class="col-xs-3 control-label">开始日期：</label>
                            <div class="col-xs-8">
                                <input id="begin_date_time" type="text" class="form-control" placeholder="请输入开始时间:2017-10-10" name="begin_date" />
                            </div>
                        </div>
                        <div class="form-group col-xs-6">
                            <label class="col-xs-3 control-label">结束日期：</label>
                            <div class="col-xs-8">
                                <input id="end_date_time" type="text" class="form-control" placeholder="请输入结束时间:2017-10-12" name="end_date" />
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
            	<input type="hidden" id="course_id_holder" value="${course_id}" />
           
            <div class="show-list">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">编号</th>
                            <th class="text-center">标题</th>
                            <th class="text-center">内容详情</th>
                            <th class="text-center">创建时间</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                    <!-- 此处为章节展示区域 -->
                        
                    </tbody>
                </table>
            </div>
            
            <!-- 分页 -->
            <div style="text-align: center;" >
                <input id="currentPage" type="hidden" value=""/>
                <ul id="myPages" ></ul>
            </div>
        </div>
    </div>

    <div class="modal fade" tabindex="-1" id="courseReourceModal" >
        <!-- 窗口声明 -->
        <div class="modal-dialog modal-lg">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" >添加章节</h4>
                </div>
                <div class="modal-body text-center">
                    <!-- course-id,没有时,移除 '返回课程列表' 按钮 -->
                    <input type="hidden" name="course_id" value=""  />
                    <div class="row text-right" id="course-resource-id-input" style="display: none;">
                        <label for="course-resource-id" class="col-xs-4 control-label">章节编号：</label>
                        <div class="col-xs-4">
                            <input type="text" class="form-control" id="course-resource-id" readonly="true" name="course-resource-id" />
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="course-resource-title" class="col-xs-4 control-label">章节标题：</label>
                        <div class="col-xs-4">
                            <input type="text" class="form-control" id="course-resource-title" name="title" />
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="course-resource-context" class="col-xs-4 control-label">内容详情：</label>
                        <div class="col-xs-4">
                            <input type="text" class="form-control" id="course-resource-context" name="info"/>
                        </div>
                    </div>
                    <br>
                    <p/>
                   
                    
                    <br>
                   
                    <br>
                </div>
                <div class="modal-footer">
                    <button id="confirmBt" class="btn btn-primary course-reource-btn">确定</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
</body>

</html>