<#macro sidebar>
<#assign roleId="${Session['userSession'].roleId}">
<!-- 侧边菜单栏 -->
<div id="skin-select">
    <div id="logo">
        <h1>光谱 <span>2.0版</span></h1>
    </div>

    <a id="toggle">
        <span class="entypo-menu"></span>
    </a>
    <div class="dark">
        <form action="#">
                <span>
                    <input type="text" name="search" value="" class="search rounded id_search" placeholder="Search Menu..." autofocus="">
                </span>
        </form>
    </div>

    <div class="search-hover">
        <form id="demo-2">
            <input type="search" placeholder="Search Menu..." class="id_search">
        </form>
    </div>


    <div class="skin-part">
        <div id="tree-wrap">
            <div class="side-bar">
            	<!--个人信息 -->
                <ul class="topnav menu-left-nest">
                    <li>
                        <a href="#" style="border-left:0px solid!important;" class="title-menu-left">
                            <span >个人信息</span>
                            <i data-toggle="tooltip" class="entypo-cog pull-right config-wrap"></i>
                        </a>
                    </li>

                    <li>
                        <a class="tooltip-tip ajax-load" href="${path}/user/query/myinfo.do" title="Blog App">
                            <i class="icon-document-edit"></i>
                            <span>查看个人信息</span>
                        </a>
                    </li>
                     <li>
                        <a class="tooltip-tip ajax-load" href="${path}/view/user/updatepassword.do" title="Blog App">
                            <i class="icon-document-edit"></i>
                            <span>修改密码</span>
                        </a>
                    </li>
                    <#if "${roleId}" == "1" || "${roleId}" == "2" || "${roleId}" == "3">
	                    <li>
	                        <a class="tooltip-tip ajax-load" href="social.html" title="Social">
	                            <i class="icon-feed"></i>
	                            <span>角色申请</span>
	                        </a>
	                    </li> 
                    </#if>
                </ul>
				
				<!-- 用户管理 -->
				<#if "${roleId}" == "4">
	                <ul class="topnav menu-left-nest">
	                    <li>
	                        <a href="#" style="border-left:0px solid!important;" class="title-menu-left">
	                            <span>用户管理</span>
	                            <i data-toggle="tooltip" class="entypo-cog pull-right config-wrap"></i>
	                        </a>
	                    </li>
	
	                    <li>
	                        <a class="tooltip-tip ajax-load" href="${path}/user/query/alluser.do" title="Dashboard">
	                            <i class="icon-window"></i>
	                            <span>查看用户</span>
	                        </a>
	                    </li>
	                </ul>
				</#if>
				
				<!-- 管理员管理 -->
				<#if "${roleId}" == "5">
	                <ul class="topnav menu-left-nest">
	                    <li>
	                        <a href="#" style="border-left:0px solid!important;" class="title-menu-left">
	
	                            <span class="admin-management">管理员管理</span>
	                            <i data-toggle="tooltip" class="entypo-cog pull-right config-wrap"></i>
	
	                        </a>
	                    </li>
	
	                    <li>
	                        <a class="tooltip-tip ajax-load" href="index.html" title="Dashboard">
	                            <i class="icon-window"></i>
	                            <span>冻结管理</span>
	
	                        </a>
	                    </li>
	                    <li>
	                        <a class="tooltip-tip ajax-load" href="mail.html" title="Mail">
	                            <i class="icon-mail"></i>
	                            <span>管理员管理</span>
	                        </a>
	                    </li>
	                </ul>
				</#if>
				
				<!-- 光谱管理 -->
				<#if "${roleId}" == "1" || "${roleId}" == "2" || "${roleId}" == "3" || "${roleId}" == "4">
					<ul class="topnav menu-left-nest">
	                    <li>
	                        <a style="border-left:0px solid!important;" class="title-menu-left">
	                            <span class="spectrum-management">光谱管理</span>
	                            <i data-toggle="tooltip" class="entypo-cog pull-right config-wrap"></i>
	                        </a>
	                    </li>
						<li>
							<#if "${roleId}" == "1" || "${roleId}" == "2" || "${roleId}" == "3">
		                        <a class="tooltip-tip ajax-load" href="${path}/dir/query.do?dirtype=0&start=0&end=10" title="Social">
		                            <i class="icon-document-edit"></i>
		                            <span>光谱收藏夹管理</span>
		                        </a>
	                        </#if>
                        </li>
                        <li>
	                        <#if "${roleId}" == "4">
		                        <a class="tooltip-tip ajax-load" href="#" title="Social">
		                            <i class="icon-document-edit"></i>
		                            <span>标准库管理</span>
		                        </a>
	                        </#if>
                        </li>
                        <li>
	                        <#if "${roleId}" == "3">
		                        <a class="tooltip-tip ajax-load" href="#" title="Social">
		                            <i class="icon-document-edit"></i>
		                            <span>审核光谱</span>
		                        </a>
	                        </#if>
                    	</li> 
	                </ul>
				</#if>
				
				<!-- 统计分析 -->
				<#if "${roleId}" == "2">
					<ul class="topnav menu-left-nest">
	                    <li>
	                        <a href="#" style="border-left:0px solid!important;" class="title-menu-left">
	                            <span>统计分析</span>
	                            <i data-toggle="tooltip" class="entypo-cog pull-right config-wrap"></i>
	                        </a>
	                    </li>
	
	                </ul>
				</#if>
				
				<!-- 算法管理 -->
				<#if "${roleId}" == "3">
					<ul class="topnav menu-left-nest">
	                    <li>
	                        <a style="border-left:0px solid!important;" class="title-menu-left">
	                            <span class="spectrum-management">算法管理</span>
	                            <i data-toggle="tooltip" class="entypo-cog pull-right config-wrap"></i>
	                        </a>
	                    </li>
						<li>
							<#if "${roleId}" == "3">
		                        <a class="tooltip-tip ajax-load" href="${path}/dir/query.do?dirtype=1&start=0&end=10" title="Social">
		                            <i class="icon-document-edit"></i>
		                            <span>算法收藏夹管理</span>
		                        </a>
	                        </#if>
                        </li>     
	                </ul>
	            </#if>

				<!-- 检验线管理 -->
				<#if "${roleId}" == "3" || "${roleId}" == "4">
					<ul class="topnav menu-left-nest">
	                    <li>
	                         <a class="tooltip-tip ajax-load" href="${path}/connectionalgorithm/query.do" title="Social">
	                            <i class="icon-document-edit"></i>
	                            <span>检验线管理 </span>
		                     </a>
	                    </li>
	                </ul>
				</#if>
				
				<!-- 审核管理 -->
				<#if "${roleId}" == "4">
	                <ul class="topnav menu-left-nest">
                        <li>
	                         <a class="tooltip-tip ajax-load" href="${path}/apply/checkApply.do" title="Social">
	                            <i class="icon-document-edit"></i>
	                            <span>审核管理 </span>
		                     </a>
	                    </li>
               		</ul>
				</#if>
				
				<!-- 类型管理 -->
				<#if "${roleId}" == "4">
	                <ul class="topnav menu-left-nest">
                        <li>
	                         <a class="tooltip-tip ajax-load" href="${path}/hardware/queryAllHardware.do" title="Social">
	                            <i class="icon-document-edit"></i>
	                            <span>类型管理 </span>
		                     </a>
	                    </li>
                	</ul>
				</#if>
				
				<!-- 物质管理 -->
				<#if "${roleId}" == "4">
	                <ul class="topnav menu-left-nest">
                    	<li>
	                         <a class="tooltip-tip ajax-load" href="${path}/detect/listAllDectect.do" title="Social">
	                            <i class="icon-document-edit"></i>
	                            <span>物质管理 </span>
		                     </a>
	                    </li>
                	</ul>
                </#if>
               
               <!-- 日志管理 -->
				<#if "${roleId}" == "4" || "${roleId}" == "5">
	                <ul class="topnav menu-left-nest">
                    <li>
                        <a href="#" style="border-left:0px solid!important;" class="title-menu-left">
                            <span class="log-management"></span>
                            <i data-toggle="tooltip" class="entypo-cog pull-right config-wrap"></i>
                        </a>
                    </li>
                    <li>
                        <a class="tooltip-tip ajax-load" href="#" title="Social">
                            <i class="icon-document-edit"></i>
                            <span>日志管理</span>

                        </a>  
	                 </li>
                </ul>
                </#if>
               
                <!-- 系统维护管理 -->
                <#if  "${roleId}" == "5">
	                <ul class="topnav menu-left-nest">
	                    <li>
	                        <a href="#" style="border-left:0px solid!important;" class="title-menu-left">
	                            <span class="system-maintenance-management"></span>
	                            <i data-toggle="tooltip" class="entypo-cog pull-right config-wrap"></i>
	                        </a>
	                    </li>
	                    <li>
	                        <a class="tooltip-tip ajax-load" href="${path}/maintenance/getmaintenances.do?start0&end=9" title="Social">
	                            <i class="icon-document-edit"></i>
	                            <span>系统维护</span>
	                        </a>
		                 </li>
                	</ul>
                </#if>
                
                <!-- 回收站 -->
                <#if "${roleId}" == "2" || "${roleId}" == "3" >
	                <ul class="topnav menu-left-nest">
	                    <li>
	                        <a class="tooltip-tip ajax-load" href="${path}/recyclebin/getall.do" title="Social">
	                            <i class="icon-document-edit"></i>
	                            <span>回收站</span>
	
	                        </a>  
	                 	</li>
	                </ul>
	            </#if>
            </div>
        </div>
    </div>
</div>
<!-- 侧边菜单栏结束 -->
</#macro>