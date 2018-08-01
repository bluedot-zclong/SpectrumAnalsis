 <#macro myinfopagebody>
<div class="wrap-fluid">
    <div class="container-fluid paper-wrap bevel tlbr">
        <!-- 内容 -->
        <!--标题 -->
        <div class="row">
            <div id="paper-top">
                <div class="col-lg-3">
                    <h2 class="tittle-content-header">
                        <i class="icon-window"></i>
                        <span>个人信息
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
            <li><a href="#" title="个人信息管理">个人信息管理</a>
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
		<form role="form" action="${path}/user/update/userInfo.do" method="post">
 				<div class="row">
                            <div class="col-md-8">
                                <div class="row">
                                    <div class="col-md-6">
                                   
                                        <div class="form-group">
                                            <label for="field-1" class="control-label">用户编号</label>

                                            <input type="text" class="form-control" id="id" placeholder="1" value="${user.userId}" disabled/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">

                                        <div class="form-group">
                                            <label for="field-1" class="control-label">真实姓名</label>

                                            <input type="text" name="username" class="form-control" value="${user.userName}" id="name" placeholder="John" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                          <div class="form-group">
                                            <label for="field-1" class="control-label">性别</label>

                                            <input type="text" name="sex" class="form-control" id="sex" placeholder="男" value="${(user.sex==1)?string('男','女')}" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="field-1" class="control-label">出生年月</label>

                                            <input type="text" name="birthday" class="form-control" id="birthday" placeholder="2011年11月11日" value="${user.birthday?date}" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="field-1" class="control-label">邮箱地址</label>
                                            <input type="text" class="form-control" id="email" placeholder="user@qq.com" value="${(user.email)}" disabled/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="field-1" class="control-label">手机号码</label>
                                            <input type="text" class="form-control" id="phoneNumber" placeholder="123456789789" value="${(user.phoneNumber)}" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <img src="<#if user.photoUrl?length gt 1>${user.photoUrl}<#else>../../assets/img/profile.jpg</#if>" alt="profile-picture" class="img-cirlce img-responsive img-thumbnail" />
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">

                                <div class="form-group">
                                    <label for="field-1" class="control-label">身份证号</label>

                                    <input type="text" class="form-control" id="IdCard" placeholder="3601111111111111111111" value="${(user.idcard)}" />
                                </div>

                            </div>
                            <div class="col-md-6">

                                <div class="form-group">
                                    <label for="field-1" class="control-label">身份权限</label>

                                    <input type="text" class="form-control" id="IdCard" placeholder="普通用户" value=" <#if user.roleId==1>普通用户</#if><#if user.roleId==2>操作人员</#if><#if user.roleId==3>实验人员</#if><#if user.roleId==4>普通管理员</#if><#if user.roleId==5>超级管理员</#if>" disabled/>
                                </div>

                            </div>
                        </div>
                         
                        <div class="row">
                            <div class="col-md-6">

                                <div class="form-group">
                                    <label for="field-1" class="control-label">个人地址</label>

                                    <input type="text" name="personAddress" class="form-control" id="personAddress" placeholder="123"  value="${(user.personAddress)}"/>
                                </div>

                            </div>
                            <div class="col-md-6">

                                <div class="form-group">
                                    <label for="field-1" class="control-label">工作地址</label>

                                    <input type="text" name="workAddress"  class="form-control autogrow" cols="5" id="workAddress" placeholder="123" value="${user.workAddress}"/>
                                </div>

                            </div>
                        </div>
                      
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-info btn-sm btn-icon" data-dismiss="modal">修改</button>
                        <button type="button" onclick="reset()" class="btn btn-white" data-dismiss="modal">重置</button>
                    </div>
             </div>
         </form>
     </div>
</div>
                
<script type="text/javascript">
	 function reset(){
	 	  $("#name").val("${user.userName}");
	 	  $("#IdCard").val("${user.idcard}");
          $("#sex").val("${(user.sex==1)?string('男','女')}");
          $("#birthday").val("${user.birthday?date}");
          $("#phoneNumber").val("${user.phoneNumber}");
          $("#workAddress").val("${user.workAddress}");
          $("#personAddress").val("${user.personAddress}");
	 }
</script>
</#macro>