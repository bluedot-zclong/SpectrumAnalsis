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
                        <span>用户管理
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
            <li><a href="#" title="用户管理">用户管理</a>
            </li>
            <li><i class="fa fa-lg fa-angle-right"></i>
            </li>
            <li><a href="#" title="用户列表">用户列表</a>
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
           
                <div class="title-alt">
                    <h6>
                    用户列表</h6>
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
					    <div class="body-nest" id="Blank_Page_Content">
                	<table class="table table-striped">
                                                <thead>
                                                <tr>
	                                                <th class="text-center"><strong>用户编号</strong></th>
													<th class="text-center"><strong>用户名称</strong></th>
													<th class="text-center"><strong>邮箱</strong></th>
													<th class="text-center"><strong>性别</strong></th>
													<th class="text-center"><strong>电话号码</strong></th>
													<th class="text-center"><strong>操作</strong></th>
													
                                                </tr>
                                                </thead>
                                              
                                           <tbody>
								<#list userList as item>
									<tr>
									 	 <td class="active text-center">${item.userId}</td>
									  	 <td class="warning text-center">
										   		${item.userName}
										 </td>	
									  	 <td class="warning text-center">
										   		${item.email}
										 </td>
										  <td class="warning text-center">
										   		${(item.sex==1)?string('男', '女')}
										 </td>
										 <td class="warning text-center">
									   		${item.phoneNumber}
									   	 </td>
									 	
									   	   <td class="warning text-center">
		                                        <a data-userID="4" onclick="showPersonInfo(${item.userId})" class="userDetail btn btn-info btn-sm btn-icon icon-left" data-toggle="modal" data-target="#modal-2">详细信息</a>                                                
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



    
      <div class="modal fade" id="modal-2"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">详细信息</h4>
                    </div>

                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="row">
                                    <div class="col-md-6">

                                        <div class="form-group">
                                            <label for="field-1" class="control-label">用户编号</label>

                                            <input type="text" class="form-control" id="id" placeholder="1" disabled/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">

                                        <div class="form-group">
                                            <label for="field-1" class="control-label">真实姓名</label>

                                            <input type="text" class="form-control" id="name" placeholder="John" disabled/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                          <div class="form-group">
                                            <label for="field-1" class="control-label">性别</label>

                                            <input type="text" class="form-control" id="sex" placeholder="男" disabled/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="field-1" class="control-label">出生年月</label>

                                            <input type="text" class="form-control" id="birthday" placeholder="2011年11月11日" disabled/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="field-1" class="control-label">邮箱地址</label>
                                            <input type="text" class="form-control" id="email" placeholder="user@qq.com" disabled/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="field-1" class="control-label">手机号码</label>
                                            <input type="text" class="form-control" id="phoneNumber" placeholder="123456789789" disabled/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <img src="../../assets/img/profile.jpg" alt="profile-picture" class="img-cirlce img-responsive img-thumbnail" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">

                                <div class="form-group">
                                    <label for="field-1" class="control-label">身份证号</label>

                                    <input type="text" class="form-control" id="IdCard" placeholder="3601111111111111111111" disabled/>
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="field-1" class="control-label">个人地址</label>

                                    <input type="text" class="form-control" id="personAddress" placeholder="xxxxxxxxx" disabled/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="field-1" class="control-label">工作地址</label>

                                    <input type="text" class="form-control autogrow" cols="5" id="workAddress" placeholder="xxxxxxxxxxxxxxxx" disabled></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    

 
<script>
 function showPersonInfo(id){
				$.ajax({  
	              	    type : 'POST',  
	                    url : 'userinfo.do',  
	                    data: { "userId": id }, 
	                    success : function(datas)  
	                    {  
	                     	
	                      var email = datas.obj.email;
	                      var IdCard = datas.obj.idcard
	                      var name = datas.obj.userName;
	                      var sex = datas.obj.sex==1?"男":"女";
	                      var birthday = datas.obj.birthday;
	                      var phoneNumber = datas.obj.phoneNumber;
	                      var workAddress = datas.obj.workAddress;
	                      var personAddress = datas.obj.personAddress;
	                      
	                      $("#id").val(id)
	                      $("#email").val(email);
	                      $("#IdCard").val(IdCard);
	                      $("#name").val(name);
	                      $("#sex").val(sex);
	                      $("#birthday").val(birthday);
	                      $("#phoneNumber").val(phoneNumber);
	                      $("#workAddress").val(workAddress);
	                      $("#personAddress").val(personAddress);
	                      
	                    },  
	                    error : function()  
	                    {  
	                    	alert("error");
	                    }  
	                });  
        }
</script>
 
 
</#macro>