<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>我的课程</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/iconfont/font_0/iconfont.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-mypaginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/template-web.js" type="text/javascript" ></script>
    <style type="text/css">
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
    html,body {
      height: 100%;
    }
        
    body > .wrap-cc{
      min-height: 100%;
    }
        
    .content-cc{
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
    	showSumC();//积分显示
        $(".arrow").click(function() {
            $(this).parent().next().toggle();
        })

        $(".title-ul>li").on('click', function() {
            console.log($(this).attr("show"));
            $('.' + $(this).attr("show")).show().siblings().hide();

            $(this).addClass('current').siblings().removeClass("current");

        })

        $(".com.source-modify").on('click', function() {
            $("#user_source").modal("show");
        });
       
    })
    
	
   	
    function openAdd() {
    	$("#mySourceModalLabel").html("添加资源");	
        $("#user_source").modal("show");
    	$("#title-from").val("");
    	$("#file-cost-type").find("option[value='-1']").prop("selected",true);
		$("#cost-number-form").val("");
    }

    function fileUpload(item) {
        $(item).click();
    }

    function fileChange(item) {
        var file = item.files[0]; //获取选中的第一个文件
        $(".file").html(file.name);
        //console.log("file", file.name);
    }
    //前台显示我的资源修改之前的内容
        function showResource(id,title,cost_type,cost_number){
  		$("#mySourceModalLabel").html("修改资源");	
		$("#user_source").modal("show");
		$("#id-from").val(id);
		$("#title-from").val(title);
		$("#file-cost-type").find("option[value="+cost_type+"]").prop("selected",true);
		$("#cost-number-form").val(cost_number);
	}
    
    
    //前台用户中我的积分显示
    function showSumC(){
		$.ajax({
			url : '${pageContext.request.contextPath}/gp/findFrontSumByUid.do',
			type : 'post',
			dataType : 'json',
			success : function(data){
				$("#points-c").html("积分"+data.obj.sum_point_count);
			}
		})
    }
    var upLoadCount=1;
    //前台添加（修改）我的资源
    // 断点续传先根据文件名字从服务器获取这个文件的大小
    function getFileSize() {
        upLoadCount=1;
        //先去服务器端查询这个文件的大小，根据文件名
        var fileObj = $("#course-resource-file")[0].files[0];
        console.log(fileObj)
        //获取需要添加的资源的各种信息
        var title = $("#title-from").val();
        var cost_type = $("#file-cost-type option:selected").val();
        var cost_number = $("#cost-number-form").val();
        var chapter_id = $("#chapter_id").val();
        var resourceObj={
            original_name:fileObj.name,
            title:title,
            cost_type:cost_type,
            cost_number:cost_number,
            chapter_id:chapter_id,
        }
        $.ajax({
            url:"${pageContext.request.contextPath}/resource/getUploadFileSize",
            data:{"resourceObj":JSON.stringify(resourceObj)},
            type:"post",
            dataType:"JSON",
            success:function (data) {
               alert(data.msg);
               if(data.msg=="查询资源成功") {
                   $("#process-border").css("display", "block");
                   $("#process").css("width", data * 200 / fileObj.size + "px");
                   alert(data.obj)
                   addResource(data.obj);
               }
                // $("#user_source").modal("hide");
                 //alert(info);
                //location.reload();
            }
        })
        // $("#user_source").modal("hide");
        // alert(info);
       // location.reload();
    }
	function addResource(start){
        var info="上传成功！";
        var file_size = 1024*1024;  //切割成1m上传
        var fileObj = $("#course-resource-file")[0].files[0];
        if(start >= fileObj.size){
            $("#user_source").modal("hide");
            alert(info);
            location.reload();
            return;
        }
    	var formData = new FormData();
        var end = (start+ file_size)>fileObj.size ? fileObj.size : (start+ file_size);
    	var id = $("#id-from").val();
    	var title = $("#title-from").val();
    	var cost_type = $("#file-cost-type option:selected").val();
    	var cost_number = $("#cost-number-form").val();
    	var chapter_id = $("#chapter_id").val();
    	//alert("章节ID"+chapter_id);

    	if(title==null||title==""){
    		alert("标题不能为空");
    		return;
    	}
    	if($("#course-resource-file").val()==null||$("#course-resource-file").val()==""){
    		alert("请上传资源");
    		return;
    	}
    	if(cost_type==-1){
    		alert("请选择资源花费类型");
    		return;
    	}
    	var re = /^[0-9]*$/;   //判断字符串是否为数字
    	if(!re.test(cost_number)){
    		alert("请正确填写花费值");
    		return;
    	}

        formData.append("filename",fileObj.name);
    	formData.append('id',id);
    	formData.append('title',title);
       	formData.append('multiFiles',fileObj.slice(start,end));
    	formData.append('cost_type', cost_type);
    	formData.append('cost_number',cost_number );
    	formData.append('chapter_id',chapter_id );
    	formData.append('uploadcount',upLoadCount);
    	formData.append('file_size',fileObj.size);
    	var url ="";
    	if($("#mySourceModalLabel").html()=="添加资源"){
    		url='${pageContext.request.contextPath}/resource/addFrontResource.do';
    	}
    	if($("#mySourceModalLabel").html()=="修改资源"){
    		url='${pageContext.request.contextPath}/resource/modifyFrontResource.do';
    	}
	    //把参数存进format中;
	    $.ajax({
            url:url,
            data:formData,
            dataType:"json",
            processData: false,
            contentType: false,
            type:"post",
            success : function(data){
                    info=data.msg;
                    upLoadCount=upLoadCount+1;
                    //断点续传根据已上传的大小动态显示上传进度
                    $("#filesize").text(Math.round(end/fileObj.size*100)+"/100");
                    $("#process").css("width",end*200/fileObj.size+"px");
                    addResource(end);
				    // alert("成功返回")
				    // alert(data)
                    // var info =data.msg;
					// $("#user_source").modal("hide");
					// alert(info);
					//location.reload();
				}
			});
	}
    //前台删除我的资源
    function removeResource(id){
        alert(id)
		if(!confirm("确认删除吗？")){
			return;
		}
    	$.ajax({
    		url : '${pageContext.request.contextPath}/resource/removeFrontResource.do',
			data : {
				"id":id
			},
			type : 'post',
			dataType : 'json',
			success : function(data){
				alert(data.msg);
				location.reload();
			}
		})
    }

	
    
   	//瀑流式分页显示我的资源
    var pageNo = 1;
    showMoreResource();
	function showMoreResource(){
		//把参数存进format中;
    	$.ajax({
			url:'${pageContext.request.contextPath}/resource/findBackResource.do',
			type:'post',
			data:{"pageNo":pageNo},
			dataType:"json",
			success:function(data){
               var info=data.obj;
			if(info.isLastPage){
				$("#loadMoreText").html("没有更多").removeAttr("onclick");
			}
			var html = template('myresource_template', info);
			$("#loadMore").before(html);
			pageNo = pageNo + 1;
			}
		});
		
	}
	
	function courseChanged() {
		var d=document.getElementById("chapter_id");
		d.length=1;
		var course_id = $("#course-id").val();
		$.ajax({
			url : '${pageContext.request.contextPath}/chapter/loadChapterByCourseId.do',
			type : 'post',
			data:{"course_id":course_id},
			dataType : "json",
			success : function(data){
				console.log(data);
				for(var i=0;i<=data.length;i++){
					var option=new Option(data[i].title,data[i].id);
					d.options[d.length]=option;
				}
			}
		})
	}
    </script>
</head>

<script type="text/html" id="myresource_template">
				{{each list item}}
					<li id="item.id">
                        <div class="col-md-1 col-sm-1">
                            <strong>{{item.create_date.substring(0,4)}}</strong>
                            <div>{{item.create_date.substring(5,7)}}月{{item.create_date.substring(8,10)}}日{{item.create_date.substring(11,19)}}</div>
                        </div>
                        <div class="col-md-11 col-sm-11">
                            <span class="circle"></span>
                            <div class="row  border-bottom">
                                <div class="col-md-3">
                                    <img src="${pageContext.request.contextPath}/images/timg.jpg" alt="" height="120" class="mycourseImg">
                                </div>
                                <div class="col-md-8 mycourse-info">
                                    <p class="padding-top-25">
                                        <span>资源标题:{{item.title}}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span>文件大小：{{(item.file_size/1024/1024).toFixed(2)}}M</span>
                                    </p>
                                    <p class="padding-10">
                                        <span>文件类型：{{item.file_type}}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <span>时长：91min</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <span>文件名字：{{item.original_name.substring(0,item.original_name.indexOf('.'))}}</span>
                                    </p>
                                    <div>
                            			{{if item.cost_type==0}}
                                        <div>使用方式：积分</div>
										{{/if}}
                            			{{if item.cost_type==1}}
                                        <div>使用方式：金币</div>
										{{/if}}
                                        <div>花费：{{item.cost_number}}</div>
                                        <div>上传者：{{item.user_name}}</div>
                                        <div class="nostyle">
                                            <button onclick="showResource({{item.id}},'{{item.title}}',{{item.cost_type}},{{item.cost_number}})" class="btn btn-warning source-modify">修改</button>
                                            <button onclick="removeResource({{item.id}})" class="btn btn-danger">删除</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
				{{/each}}
	</script>

<body>
<div class="wrap-cc">
    <div class="content-cc">
    <jsp:include page="front_head.jsp"></jsp:include>
    <div class="container-fluid banner">
        <div class="container banner-mycourse">
            <div class="row">
                <p>${sessionUser.nickname }</p>
            </div>
            <div class="row">
                <img src="${pageContext.request.contextPath}/images/girl.png" alt="" width="18">&nbsp;&nbsp;
                <span>学习时长</span>&nbsp;
                <span>0小时</span>&nbsp;
                <span id="points-c">积分</span>&nbsp;
                <span>经验0</span>
            </div>
            <div class="row">
                这位同学很懒，木有签名的说~~
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <ul class="title-ul">
                <li class="current" show='cc-course'>最近学习</li>
                <li class="source" show='cc-source'>我的资源</li>
            </ul>
            <div>
                <!-- 最近学习 -->
                <ul class="mycourse-content cc-course">
                    <li>
                        <div class="col-md-1 col-sm-1">
                            <strong>2018</strong>
                            <div>
                                01月31日 13:50:06
                            </div>
                        </div>
                        <div class="col-md-11 col-sm-11">
                            <span class="circle"></span>
                            <div class="row  border-bottom">
                                <div class="col-md-3">
                                    <img src="${pageContext.request.contextPath}/images/timg.jpg" alt="" height="120" class="mycourseImg">
                                </div>
                                <div class="col-md-8 mycourse-info">
                                    <p class="padding-top-25">
                                        <span>
                                       神经网络简介 
                                    </span>
                                        <span>
                                         更新至3-1
                                     </span>
                                    </p>
                                    <p class="padding-10">
                                        <span>已学8%</span> &nbsp;&nbsp;&nbsp;&nbsp;
                                        <span>
                                            用时34分
                                        </span> &nbsp;&nbsp;&nbsp;&nbsp;
                                        <span>
                                            学习至1-1 01课程背景
                                        </span>
                                    </p>
                                    <div>
                                        <div>
                                            笔记 0
                                        </div>
                                        <div>
                                            代码0
                                        </div>
                                        <div>
                                            问答0
                                        </div>
                                        <div>
                                            继续学习
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="col-md-1 col-sm-1">
                            <strong>2018</strong>
                            <div>
                                01月31日 16:40:36
                            </div>
                        </div>
                        <div class="col-md-11 col-sm-11">
                            <span class="circle"></span>
                            <div class="row border-bottom">
                                <div class="col-md-3">
                                    <img src="${pageContext.request.contextPath}/images/timg.jpg" alt="" height="120" class="mycourseImg">
                                </div>
                                <div class="col-md-8 mycourse-info">
                                    <p class="padding-top-25">
                                        <span>
                                       神经网络简介 
                                    </span>
                                        <span>
                                         更新至3-1
                                     </span>
                                    </p>
                                    <p class="padding-10">
                                        <span>已学8%</span> &nbsp;&nbsp;&nbsp;&nbsp;
                                        <span>
                                            用时34分
                                        </span> &nbsp;&nbsp;&nbsp;&nbsp;
                                        <span>
                                            学习至1-1 01课程背景
                                        </span>
                                    </p>
                                    <div>
                                        <div>
                                            笔记 0
                                        </div>
                                        <div>
                                            代码0
                                        </div>
                                        <div>
                                            问答0
                                        </div>
                                        <div>
                                            继续学习
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="load-more">
                            <span onclick="showMoreResource">加载更多...</span>
                        </div>
                    </li>
                </ul>
                <!-- 我的资源 -->
                <ul class="mycourse-content cc-source">
                    <li style="text-align: right;margin-top:20px; ">
                        <button class="btn btn-primary" onclick="openAdd()" style="width: 100px;">添加资源</button>
                    </li>
                    
                    <li id ="loadMore">
                        <div class="load-more" >
                            <span onclick="javascript:showMoreResource()" id ="loadMoreText">加载更多...</span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <!-- 资源模态框 -->
    <div class="modal fade" id="user_source" tabindex="-1" role="dialog" aria-labelledby="mySourceModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="mySourceModalLabel">资源</h4>
                </div>
                <form action="#" class="form-horizontal" method="post">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">标题：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" name="title" id="title-from"/>
                                <input class="form-control" type="hidden" name="id" id="id-from"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">资源：</label>
                            <div class="col-sm-6">
                                <a href="javascript:fileUpload('#course-resource-file');" class="file">选择文件</a>
                                <input type="file" name="course_resource_file" style="display: none;" onchange="fileChange(this)" id="course-resource-file" />
                                <div id="process-border" style="width: 200px;height: 20px;display: none;background: grey">
                                    <div id="process" style="width: 0px;height: 20px;background: blue"></div><span id="filesize">显示已上传文件的大小</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">资源花费类型：</label>
                            <div class="col-sm-6">
                                <select class="form-control" id="file-cost-type" name="file_cost_type_id">
                                    <option value="-1">请选择</option>
                                    <option value="0">积分</option>
                                    <option value="1">金币</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">花费值：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" name="cost_value" id="cost-number-form"/>
                            </div>
                        </div>
                       
                        <div class="form-group">
                            <%--@declare id="course-type-id-search"--%><label for="course-type-id-search" class="col-sm-3 control-label">课程选择：</label>
                            <div class="col-sm-6">
                            	
                                <select class="form-control" id="course-id" name="course_id" onchange="courseChanged();">
                                    <option value="-1" >全部</option>
                                    <c:forEach items="${courseList }" var="tmp"> 
								    	<option value=${tmp.id }>${tmp.course_name}</option>
								    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="course-type-id-search" class="col-sm-3 control-label">课程章节：</label>
                            <div class="col-sm-6">
                                <select class="form-control" id="chapter_id" name="chapter_id" >
                                    <option value="-1" >全部</option>
                                    <!-- 课程类型展示 -->
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    
                    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                        <button type="button" onclick="getFileSize()" class="btn btn-info">确&nbsp;&nbsp;定</button>
                    </div>
                </form>
            </div>
        </div>
    </div>    
    </div>
</div>
<div class="footer-cc">
    <div class="footer">
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