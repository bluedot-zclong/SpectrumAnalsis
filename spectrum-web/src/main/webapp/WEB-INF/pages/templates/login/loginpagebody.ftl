<#assign path="${basePath}">
<#macro loginpagebody>
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
                        <form role="form" action="${path}/user/login.do" method="POST">
                            <div class="">
                                <!--a href="#" class="pull-right label-forgot">Forgot email?</a-->
                                <label for="inputUsernameEmail">用户名</label>
                                <input type="text" id="inputUsernameEmail" class="form-control" name="email">
                            </div>
                            <div class="form-group">
                                <!--a href="#" class="pull-right label-forgot">Forgot password?</a-->
                                <label for="inputPassword">密码</label>
                                <input type="password" id="inputPassword" class="form-control" name="password">
                            </div>
                            <div class="form-group" id="changeVCode" >
                                <!--a href="#" class="pull-right label-forgot">Forgot password?</a-->
                                <label for="vcode">验证码</label></br>
                                <input type="text" id="vcode" name="vcode">
                                <img id="captcha"  src="${path}/user/getGifCode.do"/>
                            </div>
                            <div class="checkbox pull-left">
                                <label>
                                    <input type="checkbox">记住用户名</label>
                            </div>
                              <div class=" pull-right">
                                <lable>忘记密码，<a href="#">点击找回<a> </lable>
                            </div>
                            
                             <button class="btn btn-block my-btn" >
                                注册
                            </button>
                            
                            <button class="btn btn-block my-btn" type="submit">
                                登 录
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

