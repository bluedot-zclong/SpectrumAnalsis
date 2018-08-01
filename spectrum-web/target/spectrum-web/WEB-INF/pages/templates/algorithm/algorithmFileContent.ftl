<#macro algorithmFileContent>
<#include "/common/deleteModal.ftl" >
<#include "updateAlgorithmFile.ftl" >
<!--  PAPER WRAP -->
<div class="wrap-fluid">
    <div class="container-fluid paper-wrap bevel tlbr">
        <!-- 内容 -->
        <!--标题 -->
        <div class="row">
            <div id="paper-top">
                <div class="col-lg-3">
                    <h2 class="tittle-content-header">
                        <i class="icon-window"></i>
                        <span>算法文件</span>
                    </h2>

                </div>

                <div class="col-lg-7">
                    <div class="devider-vertical visible-lg"></div>
                    <div class="tittle-middle-header">

                        <div class="alert">
                            <button type="button" class="close" data-dismiss="alert">×</button>
                            <span class="tittle-alert entypo-info-circled"></span>欢迎 ,&nbsp;
                            <strong>${Session["userSession"].userName}</strong>&nbsp;&nbsp;您上次离开时间, 16:54 PM
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <!--/ 标题结束 -->

        <!-- 面包屑导航 -->
        <ul id="breadcrumb">
            <li>
                <span class="entypo-home"></span>
            </li>
            <li><i class="fa fa-lg fa-angle-right"></i>
            </li>
            <li><a href="#" title="主页">主页</a>
            </li>
            <li><i class="fa fa-lg fa-angle-right"></i>
            </li>
            <li><a href="#" title="模块标题">算法文件</a>
            </li>
            <form role="form"  id="form1" runat="server" action="${path}/search/globalsearch.do" method="post">
				
				  
	        	   <div class="pull-right">
	        	  
	        	   	 <li>
	        	   	 <div style="width: 210px; margin-left:auto; margin-right:auto">
	        	   	  <table>
						   <tr>
						    <td>
						   
						     <input style="border-radius:15px" id="searchtext" value="" name="searchString" type="text" placeholder="Search..." class="form-control" onkeyup="txtchange()" onblur="lost()"/>
						    </td>
						   </tr>
						   <tr>
						    <td>
						     <div id="tbcontent" style="position: absolute; z-index: 999999;">
						     
						     </div>
						    </td>
						   </tr>
						  </table>
						</div>
					 </li>
					 	<li>
	        			<input type="submit" value="查询" class="userDetail btn btn-info btn-sm btn-icon icon-left" />
	        	   	</li>
	        	   </div>
	        	  
	        	</form>
        </ul>
        <!-- 面包屑导航结束 -->
        <div class="content-wrap">
        	<br>
        	<button type="button" class="btn btn-info" data-toggle="modal" data-target="#uploadmodal">添加算法文件</button>
            <!-- 空白页-->
            <div class="nest" id="Blank_PageClose">
                <div class="title-alt">
                    <h6>算法目录</h6>
                </div>
                <div class="body-nest" id="Blank_Page_Content">
					<table id="example" style="width: 100%;" class="display"> 
					    <thead> 
						    <tr> 
						      <th class="no-sorting">
						      <input type="checkbox"  name="checkbox" id="allCheckBox">全选
                              </th>
						      <th>算法名称</th> 
						      <th>算法类别</th> 
						      <th>版本号</th> 
						      <th>上传时间</th> 
						      <th class="hidden"></th>
						      <th>操作</th>
						    </tr> 
					    </thead> 
					    <tbody>
						    <#if algorithmList??>
								<#list algorithmList as item>
									<tr>
									<#if item.isDeleted??&&item.isDeleted==0>
									  <td class="active text-center">
										<input type="checkbox"  name="checkbox">
									  </td>
									  
									  <td class="active text-center">${item.algorithmName}</td>
									  <td class="success text-center">
									  	<#if item.algorithmSort==0>
									  		预处理算法
									  	<#else>
									  		分析算法
									  	</#if>
									  </td>
									  <td class="success text-center">${item.algorithmVersion}</td>
									  <td class="warning text-center">${item.gmtCreate?date}</td>
									  <td class="hidden">${item.algorithmId}</td>
									  <td class="warning text-center">
									   		<button type="button" class="btn btn-info update" data-toggle="modal" data-target=".bs-example-modal-sm">编辑</button>
									   		<button type="button" class="btn btn-info delete" data-toggle="modal" data-target=".modeldelete">删除</button>
									  </td>
									</#if>
									</tr>
								</#list>
							</#if>
					    </tbody> 
					   </table> 
					  </div> 
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 模态框 -->

<!-- delete modal -->
<@deleteModal name="algorithmId">
</@deleteModal>
<!-- updateAlgorthmFile modal -->
<@updateAlgorithmFile>
</@updateAlgorithmFile>
<!-- uploadAlgorithmFile -->

<div class="modal fade" id="uploadmodal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">上传算法</h4>
			</div>
			<div class="modal-body">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">请填写上传信息</h3>
					</div>
					<div class="panel-body">
						<form role="form" class="form-horizontal" id="uploadForm">
							<div class="form-group">
								<label class="col-sm-3 control-label" for="algorithmName">算法名称
									<font color="red">*</font>
								</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" name="algorithmName"
										id="algorithmName" placeholder="请填写您的算法名称" maxlength="16" required>
								</div>
							</div>
							<div class="form-group-separator"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="algorithmVersion">算法版本号
									<font color="red">*</font>
								</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" name="algorithmVersion"
										id="algorithmVersion" placeholder="请填写您的算法版本号" maxlength="16" required>
								</div>
							</div>
							<div class="form-group-separator"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="algorithmSort">算法类型
									<font color="red">*</font>
								</label>
								<div class="col-sm-6">
									<select class="form-control" name="algorithmSort" id="algorithmSort"
										required>
										<option value="0">预处理算法</option>
										<option value="1">分析算法</option>
									</select>
								</div>
							</div>
							<div class="form-group-separator"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="algorithmDscription">算法描述
									<font color="red">*</font>
								</label>
								<div class="col-sm-6">
									<textarea class="form-control autogrow" cols="5"
										name="algorithmDscription" id="algorithmDscription"
										placeholder="请填写您的算法描述" maxlength="200" required></textarea>
								</div>
							</div>
							<div class="form-group-separator"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="file">jar包 <font
									color="red">*</font></label>
								<div class="col-sm-8">
									<input type="file" name="file" value="" id="file" class="col-sm-8" required />
								</div>
							</div>
							<div class="form-group-separator"></div>
							<div class="form-group col-sm-6 pull-right">
							    <input type="text" class="hidden" name="algorithmDirId" value="${dir_file_id}" id="algorithmDirId" maxlength="16" required>
								<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
								<button type="button" class="btn btn-primary" onClick="upload()">上传</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>

	<!-- 上传算法 -->
	var pieceFile = 1000*1024 * 1024; //文件切割后，每片文件的大小
		
	function upload(){
		var file = document.getElementById("file").files[0];
		var filesize = file.size;
		var filename = file.name;
		var totalPieceNum = Math.ceil(filesize/pieceFile);	//文件可以切多少片
		var start = 0;
		var end = 0;
		var index = 0;
		while(start < filesize){			
			end = pieceFile + start;
			if(end > filesize) {
				end = filesize;
            }
			var piece = file.slice(start,end);	//切割文件
			var formData = new FormData();
			var algorithmFile = $("#uploadForm").serializeArray();
			$.each(algorithmFile,function(i,formDatas){
				formData.append(formDatas.name,formDatas.value);
			});
			formData.append("file",piece,filename);	//三个参数:文件名，文件内容，文件原来名字			
			console.log(formData);
			$.ajax({
				url:"${path}/algorithm/upload/ajax.do",
			    type:'POST', //GET
			    async:true,    //或false,是否异步
			    data:formData,
			    timeout:5000,    //超时时间			    
			    cache:false,
	            traditional: true,
	            contentType: false,
	            processData: false,
			    beforeSend:function(){
			        console.log('发送前')
			    },
			    success:function(data,textStatus,jqXHR){

			    },
			    error:function(xhr,textStatus){
			        console.log('错误')

			    },
			    complete:function(){
			        console.log('结束')
			    }
			})
			start = end;
			index++;
		}
									
	}

	<!-- 更新算法  -->
	$(".update").on("click",function(){
		var algorithmId = $(this).parent().prev().text();
		$.ajax({
		       url:"${path}/algorithm/query/ajax.do",
		       type:"POST",
		       dataType:"json",
		       data:{'algorithmId': algorithmId},
		       success: function(data){
		    	    console.log(data);
		    	    $("#dirFileId").html("");
					$.each(data.obj.dirInfoList,function(i,dir){
						$("#dirFileId").append("<option value='"+dir.dirId+ "'>"+ dir.dirName+ "</option>");
		    	    });
					
					$("#algorithmName").val(data.obj.algorithmList[0].algorithmName);
					$("#algorithmUploadtime").val(data.obj.algorithmList[0].algorithmUploadtime);
					$("#algorithmSort").find("option[value = '"+data.obj.algorithmList[0].algorithmSort+"']").attr("selected","selected");
					$("#algorithmVersion").val(data.obj.algorithmList[0].algorithmVersion);
					$("#algorithmLanguage").val(data.obj.algorithmList[0].algorithmLanguage);
					$("#dirFileId").find("option[value = '"+data.obj.algorithmList[0].dirFileId+"']").attr("selected","selected");
					$("#algorithmDscription").val(data.obj.algorithmList[0].algorithmDscription);
					$("#algorithmId").val(data.obj.algorithmList[0].algorithmId);
					$('#upload').modal('show')
		       },
		       error: function(XMLHttpRequest, textStatus, errorThrown) {
				   alert(XMLHttpRequest.status);
				   alert(XMLHttpRequest.readyState);
				   alert(textStatus);
			   },
		}); 
	});
	$("#updateAlgorithm").on("click",function(){
		var algorithmFile = $("#algorithmFile").serialize();
		console.log(algorithmFile);
		$.ajax({
		       url:"${path}/algorithm/update/ajax.do",
		       type:"POST",
		       dataType:"json",
		       data: algorithmFile,
		       success: function(data){
				console.log(data);
				if(data.msg=="success"){
					alert("修改成功！");
	            	location.replace(location.href);
	            }else{
	            	alert("删除失败！");
	            }
		       },
		       error: function(XMLHttpRequest, textStatus, errorThrown) {
				   alert(XMLHttpRequest.status);
				   alert(XMLHttpRequest.readyState);
				   alert(textStatus);
			   },
		}); 
	});
	
	<!-- 删除算法 -->
	$(".delete").on("click",function(){
		var id = $(this).parent().prev().text();
		$("#deleteId").val(id);  		
	});
	
	$("#deleteModel").on("click",function(){
		var deleteId = $("#deleteId").val();
		$.ajax({
	        type: "post",
	        url: '${path}/algorithm/delete/ajax.do',
	        data: {"algorithmId":deleteId},
	        success: function (data) {
	            if(data.msg=="success"){
	            	location.replace(location.href);
	            }else{
	            	alert("删除失败！");
	            }
	        }
	    });
	});
	
	<!--全选js-->
	$("#allCheckBox").on('click', function() {
	    if ($(":checkbox").prop("checked")) {
	        $(":checkbox").prop("checked",true);
	       
	    }
	    else {
	        $(":checkbox").prop("checked",false);
	    }
	    });
	
	//初始化dataTabale
	$('#example').DataTable( {
	    language: {
	        "sProcessing": "处理中...",
	        "sLengthMenu": "显示 _MENU_ 项结果",
	        "sZeroRecords": "没有匹配结果",
	        "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
	        "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
	        "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
	        "sInfoPostFix": "",
	        "sSearch": "搜索:",
	        "sUrl": "",
	        "sEmptyTable": "表中数据为空",
	        "sLoadingRecords": "载入中...",
	        "sInfoThousands": ",",
	        "oPaginate": {
	            "sFirst": "首页",
	            "sPrevious": "上页",
	            "sNext": "下页",
	            "sLast": "末页"
	        },
	        "oAria": {
	            "sSortAscending": ": 以升序排列此列",
	            "sSortDescending": ": 以降序排列此列"
	        }  
	    },
	    columnDefs:[{ 
	    	orderable:false,//禁用排序 
	    	targets:[0,6]   //指定的列 
	    	}] 
	});
</script>
<!--  END OF PAPER WRAP -->
</#macro>