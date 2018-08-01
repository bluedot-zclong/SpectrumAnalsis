<#macro pagebody>
<div class="wrap-fluid">
    <div class="container-fluid paper-wrap bevel tlbr">
        <!-- 内容 -->
        <!--标题 -->
        <div class="row">
            <div id="paper-top">
                <div class="col-lg-3">
                    <h2 class="tittle-content-header">
                        <i class="icon-window"></i>
                        <span>密码修改
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
            <li><a href="#" title="个人信息">个人信息</a>
            </li>
            <li><i class="fa fa-lg fa-angle-right"></i>
            </li>
            <li><a href="#" title="修改密码">修改密码</a>
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
  <div class="container">
  <#if error??>
 	${error}
 	</#if>
   <form role="form" action="${path}/user/updatepassword.do" method="POST">                         
 				<div class="row">
 				
                            <div class="col-md-8">
                                <div class="row">
                                <div class="col-md-3"></div>
                                    <div class="col-md-6">

                                        <div class="form-group">
                                            <label for="field-1" class="control-label">原密码</label>

                                            <input type="password" class="form-control" name="oldpassword" id="oldpassword" placeholder="123" value="" />
                                        </div>
                                    </div>
                                    <div class="col-md-3"></div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-6">

                                        <div class="form-group">
                                            <label for="field-1" class="control-label">新密码</label>

                                            <input type="password" class="form-control" name="password" id="password" placeholder="1234" />
                                        </div>
                                    </div>
                                    <div class="col-md-3"></div>
                                </div>
                                <div class="row">
                                <div class="col-md-3"></div>
                                    <div class="col-md-6">
                                          <div class="form-group">
                                            <label for="field-1" class="control-label">再次输入新密码</label>

                                            <input type="password" class="form-control" id="again" name="again" placeholder="1234" />
                                        </div>
                                    </div>
                                 <div class="col-md-3"></div>
                                    
                      
                    </div>
                    <div class="row">
                                <div class="col-md-3"></div>
                                 <div class="col-md-6">
                    
                        <button type="submit" class="btn-info btn-sm btn-icon icon-leftbtn btn-block my-btn" data-dismiss="modal">修改</button>
                    
                    </div>
                </div>
             </div>
             </form>
          </div>
  
  </#macro>