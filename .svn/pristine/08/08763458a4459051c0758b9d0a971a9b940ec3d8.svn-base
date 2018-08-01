<#macro content>
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
            <!-- 空白页-->
            <div class="nest" id="Blank_PageClose">
            <br>
            <span style="margin-left: 20px">
            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal11">新建数据库备份</button>
            </span>
                <div class="title-alt">
                    <h6>
                    系统维护信息</h6>
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
					<table class="table table-striped">
					<thead>
					  <!-- On rows -->
					    <tr>
					    	<th class="text-center"><strong></strong></th>
							<th class="text-center"><strong>维护名称</strong></th>
							<th class="text-center"><strong>维护类型</strong></th>
							<th class="text-center"><strong>维护时间</strong></th>
							<th class="text-center"><strong>维护内容</strong></th>
							<th class="text-center"><strong>维护描述</strong></th>
							<th class="text-center"><strong>维护操作</strong></th>
						</tr>
					</thead>
						<tbody>
						<#list maintenanceList as item>
							<tr>
							 	 <td class="active text-center">${item.maintenanceId}</td>
							  	 <td class="warning text-center">
								   		${item.maintenanceName}
								 </td>	
							  	 <td class="warning text-center">${(item.maintenanceType==0)?string('备份','恢复')}</td>
								 <td class="warning text-center">
								   		${item.gmtCreate?date}
								 </td>
								 <td class="warning text-center">
							   		${item.maintenanceContent}
							   	 </td>
							   	 <td class="warning text-center">
							   		${item.maintenanceDescribe}
							   	 </td>
							   	 
							   	  <td class="warning text-center">
							   	  <#if item.maintenanceType==0>
							   	    <a href='javascript:;' onclick='recover(${item.maintenanceFileAddress}, this)' class='btn btn-secondary btn-sm btn-icon icon-left'>
	                                                      	      恢复
	                                                        </a>
							   	  </#if>
							   							 					   
							   	 </td>
							</tr>
						</#list>
					
						</tbody>
					</table>
                </div>
            </div>
        </div>
    </div>
</div>


<!--创建模态框-->
<div class="modal" id="myModal11" tabindex="-1" role="dialog" aria-labelledby="modelcreate"  aria-hidden="true">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">新建备份</h4>
      </div>
      <div class="modal-body">
     <form class="form-inline" action="backup.do" method="post">
		  <div class="form-group">
		    <label for="exampleInputName1">备份名称: </label>
		    <input type="text" class="form-control" id="maintenanceName" name="maintenanceName" placeholder="">
		  </div>
		   <div class="form-group"  style="padding-top:10px">
		    <label for="exampleInputName2">备份内容: </label>
		    <input type="text" class="form-control" id="maintenanceContent" name="maintenanceContent" placeholder="">
		  </div>
		 
		   <div class="form-group " style="padding-top:10px">
		    <label for="exampleInputName3">备份描述: </label>
		    <input type="text" class="form-control" id="maintenanceDescribe" name="maintenanceDescribe" placeholder="">
		  </div>
		  
		 
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-info">新建</button>
      </div>
      </form>
    </div>
  </div>
  </div>
</div>

   <div class="modal fade" id="modal-6">
          <div class="modal-dialog">
          
            <form action="recover.do" method="post">
				<input type="hidden" id="maintenanceFileAddress" name="maintenanceFileAddress" value="">
				
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">填写恢复信息</h4>
                    </div>
					
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-md-6">

                                <div class="form-group">
                                    <label for="field-1" class="control-label">恢复名称</label>

                                    <input type="text" class="form-control" id="field-1" placeholder="John"  name="maintenanceName">
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="field-1" class="control-label">恢复内容</label>
                                    <input type="text" class="form-control autogrow"  id="field-5" placeholder="恢复内容"  name="maintenanceContent"></textarea>
                                </div>
                            </div>
                    </div>
                    
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="field-1" class="control-label">恢复描述</label>
                                    <input type="text" class="form-control autogrow" cols="5" id="field-5" placeholder="恢复描述"  name="maintenanceDescribe"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                        
                    <div class="modal-footer">
                        <button type="button" class="btn btn-white" data-dismiss="modal">返回</button>
                        <button type="submit" class="btn btn-info">恢复</button>
                    </div>
                </div>
              </form>
            </div>
        </div>
        
    

<script>
	function recover(address, obj) {
	$("#maintenanceFileAddress").val(address);
	
		jQuery('#modal-6').modal('show', {backdrop: 'static'});
	
}
	
</script>


</#macro>