<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>课程管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/back-index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-mypaginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/template-web.js"></script>
    <script src="${pageContext.request.contextPath}/js/sweetalert.js"></script>
    <style>
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

    .img {
        /* max-width: 100px; */
        width: 100px;
        /* max-height: 120px; */
    }
    tr td {
        line-height: 120px !important;
    }

    </style>
    <script type="text/javascript">
        $(function(){
            // 课程管理 添加课程
            $("#doCourse").on("click", function() {
                $("#course-id-input").hide();
                $(".file").html("选择文件");
                $("#cover-image").val(undefined);
                $(".modal-title").html("添加课程");
                $("#Course").modal("show");
   	    	//清空模态框
	    		$("#course-id").val("");
				$("#course-name").val("");
				$("#course-author").val("");
				$("#recommendation-grade").val("");
				$("#course-type-id").val("");
			//重新绑定点击事件
				$("#confirmBt").unbind("click");
           		$("#confirmBt").bind("click",addCourse);
            });
            
            //课程章节显示
            $(".course-detail").on("click", function() {
                $('#frame-id', window.parent.document).attr('src', '${pageContext.request.contextPath}/back_courseSet');
            });
            // 显示隐藏查询列表
            $('#show-course-search').click(function() {
                $('#show-course-search').hide();
                $('#upp-course-search').show();
                $('.show-course-search').slideDown(500);
            });
            $('#upp-course-search').click(function() {
                $('#show-course-search').show();
                $('#upp-course-search').hide();
                $('.show-course-search').slideUp(500);
            });
            
        });

        function imageUpload(item){
            $(item).click();
        }
        function imageChange(item){
            var file = item.files[0];//获取选中的第一个文件
            $(".file").html(file.name);
            //console.log("file", file.name);
        }
    </script>
    
    
    
    <script>
    	$(function(){
    		//进入页面默认无条件加载第一页内容
			ajaxLoadData(1);
    		//进一步查找课程类别信息,用于其它地方
			findAllCourseType();
    	});
    	
    	/**
    	*无条件加载课程类别
    	*/
    	function findAllCourseType()
    	{
    		$.ajax({
  	    			url:'${pageContext.request.contextPath}/ct/findBackCourseType.do',
  	    			data:{"parent_id":0},
                    dataType:'json',
					type:'post',
  	    			success:function(data)
  	    			{
  	    				
  		   				/*
  		   				1.传过来的是PageInfo,直接用data获取
  		   				2.传来的是普通对象，对象中有属性obj为PageInfo类型,则data=JSON.parse(data);,
  		   				info=data.obj;用info传入模板
  		   				3.传来的是普通对象，对象中有属性obj为List类型，则data=JSON.parse(data),
  		   				t=data.obj,用{list:t}传入模板中
  		   				*/
  		   				var tp = template("course_types_info", data);
  		   				console.log(data.list);
  		   				$("#course-type-id").append(tp);
  		   				$("#course-type-id-search").append(tp);
  	    				//swal("课程类型为空，请先添加课程类型");
  	    			}
    	    });
    	}
    	/**
    	*加载课程的方法
    	*/
    	function ajaxLoadData(pageNo)
    	{    		
    		var author = $("#author-name-search").val();
    		var course_name = $("#course-name-search").val();
    		var status = $("#course-status-search").val();
    		var course_type_id = $("#course-type-id-search").val();
    		var begin_date = $("#begin_date").val();
    		var end_date = $("#end_date").val();
    		$.ajax(
    		{
    			url:'${pageContext.request.contextPath}/course/findCourse.do',
    			data:
    			{	
    				"pageNo":pageNo,
    				"author":author,
    				"course_name":course_name,
    				"status":status,
    				"course_type_id":course_type_id,
    				"begin_date":begin_date,
    				"end_date":end_date
    			},    			
    			type:'post',
                dataType:"json",
    			success:function(data)
    			{

    				// var data = JSON.parse(data);
	    			var $tr = $("#tb").children();
					$tr.remove();
					
					var info = data.obj;
					if (pageNo == 1) 
					{
						myoptions.onPageClicked = function(event, originalEvent,
								type, page) {
							ajaxLoadData(page);
						};
						var totalPages = info.pages;
						if(totalPages==0){
							totalPages=1;
						}
						myPaginatorFun("myPages", 1, totalPages);	
					}
					
					var html = template("course_item", info);
					$("#tb").append(html);
					$("#currentPage").val(info.pageNum);
 
		            $(".curse-btn").on("click", function() {
		                $("#Course").modal("hide");
		            });
		            
    			}
    		})
    	}
    	
    	/**
    	*启用禁用课程的方法
    	*/
    	function toggleStatus(item,id,status)
    	{
    		$.ajax(
    		{
    			url:'${pageContext.request.contextPath}/course/toggle.do',
    			data:{"id":id,"status":status},
    			type:'post',
    			success:function()
   				{
    				//location.reload();
   					ajaxLoadData($("#currentPage").val());
				}
    		});
    	}
    	
    	/**
    	*修改课程前的查询方法
    	*/
    	function showToModify(id){
    		//弹出模态框
            $("#course-id-input").show();
            $(".file").html("选择文件");
            $("#cover-image").val(undefined);
            $(".modal-title").html("修改课程");
            $("#Course").modal("show");
            $("#confirmBt").unbind("click");
            $("#confirmBt").bind("click",modifyCourse);
    		$.ajax(
    		{
    			url:'${pageContext.request.contextPath}/course/show.do',
    			data:{"id":id},
    			type:'post',
                dataType:"json",
    			success:function(data){
    				// data = JSON.parse(data);
    				var courseItem = data.obj;

    				$("#course-id").val(courseItem.id);
					$("#course-name").val(courseItem.course_name);
					
					$("#course-author").val(courseItem.author);
					$("#recommendation-grade").val(courseItem.recommendation_grade);
					$("#course-type-id").val(courseItem.course_type_id);
    			}
    		});
    	}
    	/**
    	*添加课程的方法
    	*/
    	function addCourse()
    	{
	    	//把参数存进format中;
	    	var formData = new FormData();
	    	var multiFiles = $("#cover-image")[0].files;
	    	var course_name = $("#course-name").val();
	    	
	    	var author = $("#course-author").val();
	    	var recommendation_grade = $("#recommendation-grade").val();
	    	var course_type_id = $("#course-type-id").val();
           	formData.append('multiFiles',multiFiles[0]);
	    	formData.append('course_name', course_name);
	    	
	    	formData.append('author', author);
	    	formData.append('recommendation_grade', recommendation_grade);
	    	formData.append('course_type_id',course_type_id);
	    	$.ajax(
	    	{
				url:'${pageContext.request.contextPath}/course/addCourse.do',
				type:'post',
				data:formData,
				dataType:"json",
				processData: false,
				contentType: false,
				success:function(data){
					alert(data.msg);
					location.reload();
				}
			});
    	}
    	
    	 function imageUpload(item){
             $(item).click();
         }
         function imageChange(item){
             var file = item.files[0];//获取选中的第一个文件
             $(".file").html(file.name);
             //console.log("file", file.name);
         }
    	
    	/**
    	*修改课程信息
    	*/
    	function modifyCourse()
    	{
	    	//把参数存进format中;
	    	var formData = new FormData();
	    	var multiFiles = $("#cover-image")[0].files;
	    	var id = $("#course-id").val();
	    	var course_name = $("#course-name").val();
	    	
	    	var author = $("#course-author").val();
	    	var recommendation_grade = $("#recommendation-grade").val();
	    	var course_type_id = $("#course-type-id").val();
           	formData.append('multiFiles',multiFiles[0]);
	    	formData.append('id', id);
	    	formData.append('course_name', course_name);
	    	formData.append('author', author);
	    	formData.append('recommendation_grade', recommendation_grade);
	    	formData.append('course_type_id',course_type_id);
	    	$.ajax(
	    	{
				url:'${pageContext.request.contextPath}/course/modifyCourse.do',
				type:'post',
				data:formData,
				dataType:"json",
				processData: false,
				contentType: false,
				success:function(data){
					alert(data.msg);
					location.reload();
				}
			});
    	}
    	
    </script>
   
	<script type="text/html" id="course_types_info">
		{{ each list item}}
			<option value="{{item.id}}" >{{item.type_name}}</option>
		{{/each}}
	</script>
	
	
	 <!-- 课程展示模板 -->
    <script type="text/html" id="course_item">
	{{ each list  item}}
		<tr>
	         <td>{{item.id}}</td>
	         <td>{{item.course_name}}</td>
	         <td>{{item.author}}</td>
	         <td>
				<image class="img" src="${pageContext.request.contextPath}/upload/course_cover/{{item.cover_image_url}}" alter="no image" />
	         </td>
	         <td>{{item.click_number}}</td>
	         <td>
				{{if item.recommendation_grade==0}} 普通 {{/if}}
				{{if item.recommendation_grade==1}} 推荐 {{/if}}
			 </td>
	         <td>{{item.courseType.type_name}}</td>
	         <td>{{item.create_date}}</td>
	         <td>
                 {{if item.status==0}}
                 启用
                 {{/if}}
                 {{if item.status==1}}
                 禁用
                 {{/if}}
             </td>
	         <td class="text-center">
	             <input type="button" onclick="showToModify({{item.id}})"  class="btn btn-warning btn-sm doCourseModify" value="修改" />
				{{if item.status==0}}
	             <input onclick="toggleStatus(this,{{item.id}},1)" type="button" class="btn btn-danger btn-sm" value="禁用" />
				{{/if}}
				{{if item.status==1}}
	             <input onclick="toggleStatus(this,{{item.id}},0)" type="button" class="btn btn-success btn-sm" value="启用" />
				{{/if}}
				<a href="${pageContext.request.contextPath}/course/idHolder.do?id={{item.id}}">
	             <input type="button" class="btn btn-success btn-sm course-detail" value="章节详情" />
				</a>
				</td>
      </tr>
	{{/each}}
	</script>
</head>

<body>
    <div class="panel panel-default" id="userPic">
        <div class="panel-heading">
            <h3 class="panel-title">课程管理</h3>
        </div>
        <div>
            <input type="button" value="添加课程" class="btn btn-primary" id="doCourse" style="margin: 5px 5px 5px 15px;" />
            <input type="button" value="查询" onclick="ajaxLoadData(1)" class="btn btn-success" id="doSearch" style="margin: 5px 5px 5px 0px;" />
            <input type="button" class="btn btn-primary" id="show-course-search" value="展开搜索" />
            <input type="button" value="收起搜索" class="btn btn-primary" id="upp-course-search" style="display: none;" />
        </div>
        <div class="panel-body">
            <div class="show-course-search" style="display: none;">
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="form-group col-xs-6">
                            <label for="author-name-search" class="col-xs-3 control-label">作者：</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" id="author-name-search" placeholder="请输入作者" />
                            </div>
                        </div>
                        <div class="form-group col-xs-6">
                            <label for="course-name-search" class="col-xs-3 control-label">课程名称：</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" id="course-name-search" placeholder="请输入课程名称" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group col-xs-6">
                            <label for="course-status-search" class="col-xs-3 control-label">状态：</label>
                            <div class="col-xs-8">
                                <select class="form-control" id="course-status-search" name="course-status-search" >
                                    <option value="-1" >全部</option>
                                    <option value="0" >启用</option>
                                    <option value="1" >禁用</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-xs-6">
                            <label for="course-type-id-search" class="col-xs-3 control-label">课程类别：</label>
                            <div class="col-xs-8">
                                <select class="form-control" id="course-type-id-search" name="course_type_id-search" >
                                    <option value="-1" >全部</option>
                                    <!-- 课程类型展示 -->
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group col-xs-6">
                            <label class="col-xs-3 control-label">开始日期：</label>
                            <div class="col-xs-8">
                                <input id="begin_date" type="text" class="form-control" placeholder="请输入开始时间:2018-07-11" />
                            </div>
                        </div>
                        <div class="form-group col-xs-6">
                            <label class="col-xs-3 control-label">结束日期：</label>
                            <div class="col-xs-8">
                                <input id="end_date" type="text" class="form-control" placeholder="请输入结束时间:2018-07-11" />
                            </div>
                        </div>
                    </div>
                    
                </form>
            </div>

            <div class="modal fade" tabindex="-1" id="Course">
                <!-- 窗口声明 -->
                <div class="modal-dialog modal-lg">
                    <!-- 内容声明 -->
                    <div class="modal-content">
                        <!-- 头部、主体、脚注 -->
                        <div class="modal-header">
                            <button class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">添加课程</h4>
                        </div>
                        <div class="modal-body text-center">
                            <div class="row text-right" id="course-id-input" style="display: none;" >
                                <label for="course-id" class="col-xs-4 control-label">课程编号：</label>
                                <div class="col-xs-4">
                                    <input type="text" class="form-control" id="course-id" name="course_id" readonly="true" />
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="course-name" class="col-xs-4 control-label">课程名称：</label>
                                <div class="col-xs-4">
                                    <input type="text" class="form-control" id="course-name" name="course_name" />
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="course-author" class="col-xs-4 control-label">作者：</label>
                                <div class="col-xs-4">
                                    <input type="text" class="form-control" id="course-author" name="author" />
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label class="col-xs-4 control-label">封面图片：</label>
                                <div class="col-xs-4">
                                    <a href="javascript:imageUpload('#cover-image');" class="file" >选择文件</a>
                                    <input type="file" name="cover_image" style="display: none;" onchange="imageChange(this)" id="cover-image" />
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="recommendation-grade" class="col-xs-4 control-label">推荐等级：</label>
                                <div class="col-xs-4">
                                    <select class="form-control" id="recommendation-grade" name="recommendation_grade" >
                                       <!-- 第一个option请不要变动和删除 -->
                                        <option value="-1" >请选择</option>
                                        <option value="0" >普通</option>
                                        <option value="1" >推荐</option>
                                    </select>
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="course-type-id" class="col-xs-4 control-label">课程类别：</label>
                                <div class="col-xs-4">
                                    <select class="form-control" id="course-type-id" name="course_type_id" >
                                   		<option value="-1" >请选择</option>
                                    </select>
                                </div>
                            </div>
                            <br>
                        </div>
                        <div class="modal-footer">
                            <button id="confirmBt" class="btn btn-primary curse-btn">确定</button>
                            <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                      </div>
                    </div>
                </div>
            </div>
            <div class="show-list">
                <table class="table table-bordered table-hover" style="text-align: center;">
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">编号</th>
                            <th class="text-center">课程名称</th>
                            <th class="text-center">作者</th>
                            <th class="text-center">封面图片</th>
                            <th class="text-center">点击量</th>
                            <th class="text-center">推荐等级</th>
                            <th class="text-center">课程类别</th>
                            <th class="text-center">创建时间</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                       <!-- 此处为课程展示区域 --> 
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
</body>

</html>