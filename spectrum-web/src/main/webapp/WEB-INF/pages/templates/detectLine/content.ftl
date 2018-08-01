
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
                        <span>检验线管理
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
                            <strong>${Session["userSession"].userName!"unknown"}</strong>&nbsp;&nbsp;您上次离开时间, 16:54 PM
                            
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
            <li><a href="#" title="模块标题">检验线管理</a>
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
        	<button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal11">新建检验线</button>
            <!-- 空白页-->
            <div class="nest" id="Blank_PageClose">
                <div class="title-alt">
                    <h6>  检验线目录</h6>
                </div>

                <div class="body-nest" id="Blank_Page_Content">
					<table class="table table-striped" id="detechLine">
					<thead>
					  <!-- On rows -->
					    <tr>
					   		<th class="text-center"><strong>检验线编号</strong></th>
							<th class="text-center"><strong>检验线名称</strong></th>
							<th class="text-center"><strong>硬件设备</strong></th>
							<th class="text-center"><strong>预处理算法</strong></th>
							<th class="text-center"><strong>分析算法</strong></th>
							<th class="text-center"><strong>国际标准</strong></th>
							<th class="text-center"><strong>创建人员</strong></th>
							<th class="text-center"><strong>分析内容</strong></th>
							<th class="text-center"><strong>最后修改</strong></th>
						</tr>
					</thead>
						<tbody>
						 
						<#if detectLines??>
							<#list detectLines as item>
								<tr>
									<td class="active text-center">${item.connectionAlgorithmVersion}</td>
									<td class="active text-center">${item.connectionAlgorithmName}</td>
									<td class="active text-center">${item.hardwareName}</td>
									<td class="active text-center"><button onClick="showPreAlgorithm(${item.pretreatmentAlgorithm.algorithmId})">${item.pretreatmentAlgorithm.algorithmName}</button></td>
									<td class="active text-center"><button onClick="showAnaAlgorithm(${item.analysisAlgorithm.algorithmId})">${item.analysisAlgorithm.algorithmName}</button></td>
									<td class="active text-center">${item.standardName}</td>
									<td class="active text-center">${item.userName}</td>
									<td class="active text-center"><button onClick="alert('${item.connectionAlgorithmDescribe}')">分析细节</button></td>
									<td class="active text-center">${item.gmtModified?datetime}</td>							 
								</tr>
							</#list>
						</#if >
	
						</tbody>
					</table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
	var data = ${detectLinesJson};
	function showPreAlgorithm(id) {
		for (var i=0;i<data.length;i++)
		{
			if (data[i].pretreatmentAlgorithm.algorithmId === id) {
				alert(JSON.stringify(data[i].pretreatmentAlgorithm));
			} 
		}
	}
	function showAnaAlgorithm(id) {
		for (var i=0;i<data.length;i++)
		{
			if (data[i].analysisAlgorithm.algorithmId === id) {
				alert(JSON.stringify(data[i].analysisAlgorithm));
			} 
		}
	}
	
//初始化dataTabale
	$('#detechLine').DataTable( {
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

</#macro>