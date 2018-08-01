
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
                        <span>分析内容
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
            <li><a href="#" title="模块标题">分析内容</a>
            </li>
            <li class="pull-right">
                <div class="input-group input-widget">
                    <input style="border-radius:15px" type="text" placeholder="Search..." class="form-control">
                </div>
            </li>
        </ul>
        <!-- 面包屑导航结束 -->
        <div class="content-wrap">
        	<br>
            <!-- 空白页-->
            <div class="nest" id="Blank_PageClose">
                <div class="title-alt">
                    <h6>  分析内容</h6>
                </div>

                <div class="body-nest" id="Blank_Page_Content">
					<table class="table table-striped" id="detechLine">
					<thead>
					  <!-- On rows -->
					    <tr>
					   		<th class="text-center"><strong>编号</strong></th>
							<th class="text-center"><strong>光谱名称</strong></th>
							<th class="text-center"><strong>查看结果</strong></th>
						</tr>
					</thead>
						<tbody>
						 
						<#if spetrumList??>
						 <#assign  id=1/>
							<#list spetrumList as item>
								<tr>
									<td class="active text-center">${id}</td>
									<td class="active text-center">${item.spectrum.fileName}</td>
									<td class="active text-center"><a  class="btn btn-info" href="${path}/spectrum/reportById.do?id=${id}">查看</a></td>
								</tr>
							<#assign id = id + 1>
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