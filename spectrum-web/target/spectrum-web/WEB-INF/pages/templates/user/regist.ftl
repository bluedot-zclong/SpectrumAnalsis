<#assign path="${basePath}">
<#macro registpagebody>
 <!-- Preloader -->
    <div id="preloader">
        <div id="status">&nbsp;</div>
    </div>
    
    <div class="container">

        <div class="" id="login-wrapper">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div id="logo-login">
                        <h1>光谱分析系统
                            <span>2.0版</span>
                        </h1>
                    </div>
                </div>

            </div>

            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="account-box"> 
                        <form role="form" action="${path}/user/regist.do" method="POST">
                            <div class="">
                                <label for="username">用户名</label>
                                <input type="text" id="username" class="form-control" name="username">
                            </div>
                             <div class="form-group">
                                <label for="sex">邮件（登录账号）</label>
                                <input type="password" id="email" class="form-control" name="email">
                            </div>
                            <div class="form-group">
                                <label for="inputPassword">密码</label>
                                <input type="password" id="inputPassword" class="form-control" name="password">
                            </div>
                            
                            <div class="form-group">
                                <label for="inputPasswordAgain">再次输入密码</label>
                                <input type="password" id="inputPasswordAgain" class="form-control" name="passwordagain">
                            </div>
                              <div class="form-group">
                                <label for="telephone">电话号码</label>
                                <input type="text" id="telephone" class="form-control" name="telephone">
                            </div>
                            <div class="form-group">
                                <label for="birthday">出生日期</label>
                                <input type="birthday" id="birthday" class="form-control" name="birthday">
                            </div>
                            <div class="form-group">
                                <label for="sex">性别</label>
                                <input type="password" id="sex" class="form-control" name="sex">
                            </div>
                            
                             <div class="form-group">
                                <label for="sex">身份证号码</label>
                                <input type="password" id="sex" class="form-control" name="password">
                            </div>
                             <button class="btn btn-block my-btn" type="submit">
                                注册
                            </button>
                            
                            <button class="btn btn-block my-btn" >
                                返回登录界面
                            </button>
                           
                        </form>

                    </div>
                </div>
            </div>
        </div>

 		<p>&nbsp;</p>
        <div style="text-align:center;margin:0 auto;">
            <h6 style="color:#fff;">蓝点工作室<br />
				</h6>
        </div>

    </div>
    <script>
		jQuery(document).ready(function() {
			//验证码
			$("#changeVCode").on("click", 'img', function() {
				/**动态验证码，改变地址，多次在火狐浏览器下，不会变化的BUG，故这样解决*/
				var i = new Image();
				i.src = '${path}/user/getGifCode.do?' + Math.random();
				i.id = 'captcha';
				$(i).replaceAll(this);
				
			});

		});
	</script>
</#macro>