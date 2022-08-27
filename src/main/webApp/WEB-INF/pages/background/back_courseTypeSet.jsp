<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>课程类别管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/back-index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-mypaginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/template-web.js"></script>
    <script type="text/javascript" charset="utf-8">
        $(function(){
       		ajaxLoadData(1);
            $("#doAddCourseType").on("click", function() {
                $("#courseType-id-input").hide();
                $("#courseType-name").val("");
                $("#courseType-parent_id").find("option[value="+0+"]").prop("selected",true);
               	$("h4").html("添加课程分类");
               	
                $("#courseTypeModal").modal("show");
            });
            $(".courseType-btn").on("click", function() {
                $("#courseTypeModal").modal("hide");
            });

            $(".courseType-modify").on("click", function() {
                $("#courseType-id-input").show();
                $("#courseTypeModal").modal("show");
     
            });
            
            //查询子类别
//             $(".course-type-detail").on("click", function() {
//                 $('#frame-id', window.parent.document).attr('src', 'back_courseTypeSet.html');
//             });
            //返回父类别列表页面
//             $("#back").on("click", function() {
//                 $('#frame-id', window.parent.document).attr('src', 'back_courseTypeSet.html');
//             });
        }); 
        
        //后台修改用户状态禁用-启用
		function toggleStatus(id,status){
			var cp = myoptions.currentPage;
			$.ajax({
				url:'${pageContext.request.contextPath}/ct/toggleStatus.do',
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
        
        //后台添加课程分类
        function addCourseType(){
        

        	
        }
        
        //后台显示课程分类名字
		function showBackCourceType(id){
			$.ajax({
				url:'${pageContext.request.contextPath}/ct/showBackName.do',
			   	data:{
					"id" : id
				},
				type : 'post',
				dataType : 'json',
				success : function(data){
				   var parent_id;
				   if(data.obj.parent_id == null){
				       parent_id=0;
                   }else {
                       parent_id=data.obj.parent_id;
                   }
					$("#courseType-id-input").show();
					$("#courseTypeModal").modal("show");
					$("h4").html("修改课程分类");
                    $("#courseType-parent_id").find("option[value="+parent_id+"]").prop("selected",true);
					$("#courseType-id").val(data.obj.id);
					$("#courseType-name").val(data.obj.type_name);
				}
			})
		}
        
        
        //查询子类别
        function findBackTypeS(id){
        	$("#parentId").val(id);
			$("#back").show();
			$.ajax({
				url:'${pageContext.request.contextPath}/ct/findBackCourseType.do',
				data : {
					"parent_id" : id
				},
				type : 'post',
				dataType : 'json',
				success : function(data){
					ajaxLoadData(1);
					$("#course-type-detail").hide();
				}
			})
			
		}
        
        //点击返回列表
        function goback(){
        	$("#parentId").val(0);
        	ajaxLoadData(1);
        }
        
        
        
        //后台修改(添加)课程名字
		function confirmBtn(){
			var parent_id = $("#courseType-parent_id").val();
			alert(parent_id)
			if($("h4").html()=="修改课程分类"){
				var cp = myoptions.currentPage;
				var id = $("#courseType-id").val();
				var type_name = $("#courseType-name").val();
				if(type_name==null||type_name==""){
					alert("课程分类名字不能为空");
					return;
				};
				$.ajax({
					url : '${pageContext.request.contextPath}/ct/modifyCourseTypeName.do',
					data : {
							"id":id,
							"type_name":type_name,
                            "parent_id":parent_id,
							},
					type : 'post',
					dataType : 'json',
					success : function(data){
						$("#courseTypeModal").modal("hide");
						ajaxLoadData(cp);
						alert(data.msg);
					},
				})
			}
			if($("h4").html()=="添加课程分类"){
				var type_name = $("#courseType-name").val();
				$.ajax({
					url : '${pageContext.request.contextPath}/ct/addBackType.do',
					data : {
							"type_name":type_name,
							"parent_id":parent_id,
							"status":0
							},
					type : 'post',
					dataType : 'json',
					success : function(data){
						$("#courseTypeModal").modal("hide");
						ajaxLoadData(1);
						alert(data.msg);
					},
				})
			}
		}
        
		//分页加载数据
		function ajaxLoadData(page){
			var parent_id = $("#parentId").val();
			if(parent_id==0){
				$("#back").hide();
			};
			$.ajax({
					url:'${pageContext.request.contextPath}/ct/findBackCourseType.do',
					data:{
						"pageNo":page,
						"parent_id":parent_id
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
						let $tr = $("#tb").children();
						$tr.remove();
						var html = template('courseTypeBack_template', data);
						console.log(data);
						$("#tb").append(html);
					}
				})
		}
		
    </script>
	<script type="text/html" id="courseTypeBack_template">
				{{each list item}}
                        <tr>
                            <td>{{item.id}}</td>
                            <td>{{item.type_name}}</td>
 							{{if item.status==0}}
							<td>启用</td>
							{{/if}}
 							{{if item.status==1}}
							<td>禁用</td>
							{{/if}}
                            <td>
                                <input type="button" onclick="showBackCourceType({{item.id}})" class="btn btn-warning btn-sm courseType-modify" id="abc" value="修改" />
								{{if item.status==1}}
                                <input type="button" onclick="toggleStatus({{item.id}},0)" class="btn btn-success btn-sm" value="启用" />
								{{/if}}
								{{if item.status==0}}
								<input type="button" onclick="toggleStatus({{item.id}},1)" class="btn btn-danger btn-sm" value="禁用" />
                                {{/if}}
								
								<input type="button" onclick="findBackTypeS({{item.id}})"class="btn btn-success btn-sm course-type-detail" value="查询子类别" id="course-type-detail" />
                           		
							</td>
                        </tr>
				{{/each}}
	</script>
	<!-- 课程分类模板 -->
	<script type="text/html" id="courseTypeModel">
		 {{ each d as item i }}
		 
		 {{/each}}
	</script>

</head>

<body>

    <!-- 课程类别管理 -->
    <div class="panel panel-default" id="departmentSet">
        <div class="panel-heading">
            <h3 class="panel-title">课程类别管理</h3>
        </div>
        <div class="panel-body">
            <input type="button" value="添加课程类别" class="btn btn-primary" id="doAddCourseType" />
            <!-- courseType父类别id,没有时,移除此按钮 -->
            <input type="hidden" name="parent_id" value="0" id="parentId"/>
            <input type="button" onclick="goback()" value="返回上级列表" class="btn btn-success" id="back" style="float: right;" />
            <br>
            <br>
            <div class="modal fade" tabindex="-1" id="courseTypeModal">
                <!-- 窗口声明 -->
                <div class="modal-dialog modal-lg">
                    <!-- 内容声明 -->
                    <div class="modal-content">
                        <!-- 头部、主体、脚注 -->
                        <div class="modal-header">
                            <button class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">添加类别</h4>
                        </div>
                        <div class="modal-body text-center">
                            <div class="row text-right" id="courseType-id-input" >
                                <label for="courseType-id" class="col-sm-4 control-label">编号：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="courseType-id" readonly="true" />
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="courseType-name" class="col-sm-4 control-label">类别名称：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="courseType-name" />
                                </div>
                            </div>
                            <br>
                          <div class="row text-right">
                            <label for="courseType-parent_id" class="col-sm-4 control-label">父类别ID：</label>
                              <div class="col-sm-4">
                              <select class="form-control" id="courseType-parent_id" name="courseType-parent_id" >
                                      <option value="0" >全部</option>
                                      <c:forEach items="${courseTypeList}" var="tmp">
                                          <option value=${tmp.id}>${tmp.id}&nbsp;&nbsp;:${tmp.type_name}</option>
                                      </c:forEach>
                                  </select>
                              </div>
                          </div>
                            <br>
                        </div>
                        <div class="modal-footer">
                            <button onclick="confirmBtn()" class="btn btn-primary courseType-btn">确定</button>
                            <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="show-list">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">编号</th>
                            <th class="text-center">名称</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                    </tbody>
                </table>
            </div>

            <!-- 分页 -->
            <div style="text-align: center;" >
                <ul id="myPages" >
                <!-- 此处为页码展示区 -->
                </ul>
            </div>
        </div>
    </div>
</body>

</html>