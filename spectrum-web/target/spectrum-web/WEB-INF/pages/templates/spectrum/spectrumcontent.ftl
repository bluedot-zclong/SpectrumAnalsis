<#macro content>
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
                        <span>光谱
                            </span>
                    </h2>

                </div>

                <div class="col-lg-7">
                    <div class="devider-vertical visible-lg"></div>
                    <div class="tittle-middle-header">

                        <div class="alert">
                            <button type="button" class="close" data-dismiss="alert">×</button>
                            <span class="tittle-alert entypo-info-circled"></span>
                            欢迎 ,&nbsp;
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
            <li><a href="#" title="模块标题">文件夹</a>
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
        	<button type="button" class="btn btn-info" onclick="getInfo()">上传光谱</button>
        	<button type="button" class="btn btn-info" onclick="getAllSelectedSpectrumId()">批量分析</button>
        	<a  class="btn btn-info" href="${path}/spectrum/getAnalysisReport.do">查看结果</a>
            <!-- 空白页-->
            <div class="nest" id="Blank_PageClose">
                <div class="title-alt">
                    <h6>
                        文件夹目录</h6>
                    <div class="titleClose">
                        <a class="gone" href="#Blank_PageClose">
                            <span class="entypo-cancel"></span>
                        </a>
                    </div>
                    <div class="titleToggle">
                        <a class="nav-toggle-alt" href="#Blank_Page_Content">
                            <span class="entypo-up-open"></span>
                        </a>
                    </div>

                </div>

                <div class="body-nest" id="Blank_Page_Content">
					<table id="example11" style="width: 100%;" class="display"> 
					<thead>
					  <!-- On rows -->
					    <tr>
					   		<th class="no-sorting">
						      <input type="checkbox"  name="checkbox" id="allCheckBox">全选
                            </th>
					   		<th class="text-center"><strong>光谱编号</strong></th>
							<th class="text-center"><strong>光谱文件名</strong></th>
							<th class="text-center"><strong>光谱类型名称</strong></th>
							<th class="text-center"><strong>创建日期</strong></th>
							<th class="text-center"><strong>操作</strong></th>
						</tr>
					</thead>
						<tbody>
						<#if spectruminfoList??>
						<#list spectruminfoList as item>
							<tr>
							<#if item.isDelete??&&item.isDelete==0>
							<td class="active text-center">
										<input type="checkbox"  name="checkbox" class="aloneBox" id="${item.spectruminfoId}">
							</td>
							<td class="active text-center">${item.spectruminfoId}</td>
							  <td class="active text-center">
							  ${item.spectrumName}
							  </td>
							  <td class="success text-center">
							  	${item.spectrumTypeName}
							  </td>
							  
							  <td class="warning text-center">${item.gmtCreate?date}</td>
							   <td class="warning text-center">
							   		<a type="button" href="${path}/spectrum/showSpectrumInfo.do?id=${item.spectruminfoId}" class="btn btn-info update" >详细</a>
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



<!-- delete modal -->

<div class="modal fade modeldelete" tabindex="-1" role="dialog" aria-labelledby="modeldelete">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Message</h4>
      </div>
      <div class="modal-body">
     		<h2 class="text-center">delete？</h2>
     		<input type="text" class="form-control hidden" id="deleteDirId"  name="dirId" placeholder="">
      </div>
      <div class="modal-body">
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal" id="deleteModel">YES</button>
        <button type="button" class="btn btn-info">NO</button>
      </div>
    </div>
  </div>
</div>
</div>
<!-- upload spectrum -->
<div class="modal fade" id="uploadmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">上传本地光谱</h4>
					</div>
					<div class="modal-body">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">请填写上传信息</h3>
							</div>
							<div class="panel-body">
								<form id="uploadForm" action="" role="form" class="form-horizontal" method="post" enctype="multipart/form-data">
									<div class="form-group">
										<label class="col-sm-3 control-label" for="pluginName">光谱名称 <font color="red">*</font></label>
										<div class="col-sm-6">
											<input type="text" class="form-control" name="spectrumName" id="pluginName" placeholder="请填写您的光谱名称" maxlength="16" required>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label" for="pluginName">被检测物产地<font color="red">*</font></label>
										<div class="col-sm-6">
											<input type="text" class="form-control" name="categoryOrigin" id="version" placeholder="请填写被检测物" maxlength="16" required>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label">被检测物一级分类<font color="red">*</font></label>
										<div class="col-sm-6">
											<select class="form-control"  name="" id="pluginType" required>
												<option value="1">粮食加工品</option>
											</select>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label">被检测物二级分类<font color="red">*</font></label>
										<div class="col-sm-6">
											<select class="form-control"   name="" id="pluginType" required>
												<option value="101">小麦粉</option>
											</select>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label">被检测物<font color="red">*</font></label>
										<div class="col-sm-6">
											<select class="form-control"   name="detectedId" id="pluginType" required>
												<option value="10101">特制一等小麦粉</option>
											</select>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label">光谱类型 <font color="red">*</font></label>
										<div class="col-sm-6">
											<select class="form-control"  name="spectrumTypeName" id="type" required>
											</select>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label">硬件类型 <font color="red">*</font></label>
										<div class="col-sm-6">
											<select class="form-control" id="hardware" name="hardware" required>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label">XUnit<font color="red">*</font></label>
										<div class="col-sm-3">
											<select class="form-control" name="XUnit" id="pluginType" required>
												<option value="波数">波数</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label">YUnit<font color="red">*</font></label>
										<div class="col-sm-3">
											<select class="form-control" name="YUnit" id="pluginType" required>
												<option value="吸光度">吸光度</option>
											</select>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label" for="description">光谱描述 <font color="red">*</font></label>
										<div class="col-sm-6">
											<textarea class="form-control autogrow" cols="5" name="description" id="description" placeholder="请填写您的光谱描述" maxlength="200" required></textarea>
										</div>
										<div class="col-sm-6 hidden">
											<input type="text" class="form-control" name="fileId" value="${dirId}" placeholder="文件夹位置" maxlength="16" required>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label">光谱文件 <font color="red">*</font></label>
										<div class="col-sm-8">
											<input type="file" name="binFile" value="" id="file" class="col-sm-8" required/>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group col-sm-6 pull-right" >
										<button type="button" onclick="upload()" class="btn btn-success" data-dismiss="modal">上传</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

<script type="text/javascript">
	$(".delete").on("click",function(){
		var id = $(this).parent().prev().prev().prev().prev().text();
		$("#deleteDirId").val(id); 
	});
	
	$("#deleteModel").on("click",function(){
		
		var deleteId = $("#deleteDirId").val();
		 $.post("${path}/spectrum/delete/ajax.do",
			  {
			    spectrumId:deleteId,
			  },
			  function(data,status){
			  		window.location.href="query.do?dirtype=0&start=0&end=10";
			  });
	});
	
	function getInfo(){
		 $.post("${path}/spectrum/getSpectrumType/ajax.do",
			  function(data,status){
			  		foreachSpectrumType(data.obj.spectrumTypeList)
			  		foreachHardwareList(data.obj.hardwareList)
			  		$('#uploadmodal').modal('show')
			  });
		
	}
	function foreachSpectrumType(spectrumTypeList){
		for(var i=0;i<spectrumTypeList.length;i++){
		    var spectrumType = spectrumTypeList[i];
			$("#type").append("<option>"+spectrumType.spectrumtypeName+"</option>")
		}
	}
	function foreachHardwareList(hardwareList){
		for(var i=0;i<hardwareList.length;i++){
		    var hardware = hardwareList[i];
			$("#hardware").append("<option>"+hardware.hardwareName+"</option>")
		}
	}
	
	<!-- 上传  -->
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
				url:"${path}/spectrum/upload/ajax.do",
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
					alert("success")
					window.location.reload();
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
	var id = new Array();
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
	$('#example11').DataTable( {
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
	    	targets:[0,4]   //指定的列 
	    	}] 
	});
	
	/*$(".aloneBox").on('click', function(){
		var flag = $(this).prop("checked");
	  if (flag) {
	        var length = id.length;
			var attr = $(this).attr("id");
			id[length] = attr;
	    }else{
			var length = id.length;
			var attr = $(this).attr("id");
			deleteData(attr,id);
		}
	});
	function indexOf(val,array) {
		for (var i = 0; i < array.length; i++) {
		if (array[i] == val) return i;
		}
		return -1;
	};
	function deleteData(val,array) {
		var index = array.indexOf(val);
		if (index > -1) {
			array.splice(index, 1);
		}
	};*/
	
	function getAllSelectedSpectrumId(){
		var list=$("body").find(".aloneBox");
		for(var i=0;i<list.length;i++){
			if($("body").find(".aloneBox").eq(i).prop("checked")){
				var length = id.length;
				id[length] = list[i].getAttribute('id');
			}
		}
		var url = "${path}/spectrum/queryDetechLine.do?id="+id;
		window.location.href=url; 
	}
</script>
<!--  END OF PAPER WRAP -->
</#macro>