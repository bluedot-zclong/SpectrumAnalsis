
<#macro content>
<#include "/common/deleteModal.ftl" >
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
                        <span>文件夹
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
        	<button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal11">新建文件夹</button>
            <!-- 空白页-->
            <div class="nest" id="Blank_PageClose">
                <div class="title-alt">
                    <h6>  文件夹目录</h6>
                </div>

                <div class="body-nest" id="Blank_Page_Content">
					<table id="example" class="table table-striped">
					<thead>
					  <!-- On rows -->
					    <tr>
					   		 <th class="text-center"><strong>文件夹编号</strong></th>
							<th class="text-center"><strong>文件夹名</strong></th>
							<th class="text-center"><strong>类型</strong></th>
							<th class="text-center"><strong>创建日期</strong></th>
							<th class="text-center"><strong>操作</strong></th>
						</tr>
					</thead>
						<tbody>
						<#if dirList??>
						<#list dirList as item>
							<tr>
							
							<td class="active text-center">${item.dirId}</td>
							  <td class="active text-center">
								  <a href="${path}/dir/showAllFile.do?dirId=${item.dirId}&dirType=${item.dirTypeId}">
								  ${item.dirName}
								  </a>
							  </td>
							  <td class="success text-center">
							  	${(item.dirTypeId==1)?string('算法','光谱')}
							  </td>
							  
							  <td class="warning text-center">${item.gmtCreate?date}</td>
							   <td class="warning text-center">
							   		<button type="button" class="btn btn-info update" data-toggle="modal" data-target=".bs-example-modal-sm">修改</button>
							   		<button type="button" class="btn btn-info delete" data-toggle="modal" data-target=".modeldelete">删除</button>
							   </td>
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

<!-- update modal -->

<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">修改</h4>
      </div>
      <div class="modal-body">
     <form class="form-inline" action="update.do" method="post">
		  <div class="form-group">
		    <label for="exampleInputName2">Name: </label>
		    <input type="text" class="form-control" id="dirName" name="dirName" placeholder="">
		  </div>
		  <div class="form-group hidden">
		    <input type="text" class="form-control hidden" id="dirId"  name="dirId" placeholder="">
		    <input type="text" class="form-control hidden"  name="dirType" value="${fileType}"/>
		  </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-info">Save changes</button>
      </div>
      </form>
    </div>
  </div>
</div>

<!--delete modal-->
<@deleteModal name="dirId">
</@deleteModal>

<!-- create modal -->
<div class="modal" id="myModal11" tabindex="-1" role="dialog" aria-labelledby="modelcreate"  aria-hidden="true">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">新建</h4>
      </div>
      <div class="modal-body">
     <form class="form-inline" action="create.do" method="post">
		  <div class="form-group">
		    <label for="exampleInputName2">Name: </label>
		    <input type="text" class="form-control" id="dirName" name="dirName" placeholder="">
		  </div>
		  <div class="form-group hidden">
		    <input type="text" class="form-control hidden"  name="dirType" value="${fileType}"/>
		  </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-info">新建文件夹</button>
      </div>
      </form>
    </div>
  </div>
</div>

<script>
	var fileType = ${fileType};
	$(".update").on("click",function(){
		var id = $(this).parent().prev().prev().prev().prev().text();
  		$("#dirId").val(id);
	});
	
	$(".delete").on("click",function(){
		var id = $(this).parent().prev().prev().prev().prev().text();
		$("#deleteId").val(id);  		
	});
	
	$("#deleteModel").on("click",function(){
		var deleteId = $("#deleteId").val();
		$.post("delete/ajax.do",
			  {
			    dirId:deleteId,
			  },
			  function(data,status){
			  		if(fileType == 0){
			  			window.location.href="query.do?dirtype=0&start=0&end=10";
			  		}else{
			  			window.location.href="query.do?dirtype=1&start=0&end=10";
			  		}
			  });
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
	    	targets:[0,4]   //指定的列 
	    	}] 
	});
	
</script>
<!--  END OF PAPER WRAP -->
</#macro>