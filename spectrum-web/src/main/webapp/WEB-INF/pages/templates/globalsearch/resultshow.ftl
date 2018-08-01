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
                        <span>全局搜索
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
            <li><a href="#" title="全局搜索">全局搜索</a>
            </li>
            <li><i class="fa fa-lg fa-angle-right"></i>
            </li>
            <li><a href="#" title="结果页面">结果页面</a>
            </li>
            <li class="pull-right">
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
            </li>
        </ul>
  <!-- 面包屑导航结束 -->
          <div class="content-wrap">
        	<br>
        	
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
					   		<th class="text-center"><strong>编号</strong></th>
					   		<th class="text-center"><strong>字段名</strong></th>
							<th class="text-center"><strong>查询结果</strong></th>
							<th class="text-center"><strong>结果类型</strong></th>					
							<th class="text-center"><strong>操作</strong></th>
						</tr>
					</thead>
						<tbody>
						
						
					<#list resultList as item>
							<tr>
							 <td class="active text-center">
								 ${item.id}
							  </td>
							  <td class="active text-center">
								 ${item.cloumnName}
							  </td>
							  <td class="active text-center">
								 ${item.resultString}
							  </td>
							  <td class="active text-center">
								 ${item.tableName}
							  </td>						
							 
							  
							   <td class="warning text-center">
							   		<button type="button" class="btn btn-info update" data-toggle="modal" data-target=".bs-example-modal-sm">查询</button>
							   		
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

  </#macro>