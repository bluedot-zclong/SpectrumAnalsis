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
                        <span>统计分析
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
                            <strong>用户名!</strong>&nbsp;&nbsp;您上次离开时间, 16:54 PM
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
            <li><a href="#" title="模块标题">模块标题</a>
            </li>
            <li class="pull-right">
                <div class="input-group input-widget">

                    <input style="border-radius:15px" type="text" placeholder="Search..." class="form-control">
                </div>
            </li>
        </ul>

        <!-- 面包屑导航结束 -->


        <div class="content-wrap">
            <!-- 空白页-->
            <div class="nest" id="Blank_PageClose">
                <div class="title-alt">
                    <h6>
                    	<p class="description">您可以在此页面上进行统计分析</p>   
					</h6>
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

             <nav role="navigation">
			<div class="collapse navbar-collapse" id="operate_tool_navbar">
				<ul class="nav navbar-nav" style="margin-right: 10px">
					<li><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font size="3">请选择进行统计分析的条件：</font>
					</li>
					<li class="dropdown">
						<!--  <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">检测内容<b class="caret"></b>
                        </a> --> <select class="form-control" name="contents"
						id="contents" style="margin-top: 10px;" required>
							<%--遍历检测内容--%>
							<option value="检测内容">检测内容</option>
							
					</select>
				</ul>
				</li>
				</ul>
				<ul class="nav navbar-nav" style="margin-right: 10px">
					<li class="dropdown"><select class="form-control"
						name="categoryOrigins" id="categoryOrigins" style="margin-top: 10px;"
						required>
							<%--遍历所检测地区--%>
							<option value="所检测地区">所检测地区</option>
					</select></li>
				</ul>
				<ul class="nav navbar-nav">
					<li class="dropdown"><select class="form-control" name="time"
						id="time" style="margin-top: 10px;" required>
							<option value="统计时间">统计时间</option>
					</select></li>
				</ul>
				<ul class="nav navbar-nav">
					<input type="text" class="form-control datetimepicker datatimepicker1"
						id="startDate" name="startDate" readonly
						style="width: 85px; margin: 10px;" />
				</ul>
				<ul class="nav navbar-nav">
					<p style="margin-top: 14px;">—</p>
				</ul>
				<ul class="nav navbar-nav">
					<input type="text" class="form-control datetimepicker datatimepicker1"
						id="endDate" name="endDate" readonly style="width: 85px; margin: 10px;" />

				</ul>
				<ul>

					<button class="btn btn-info" style="margin: 10px;" id="analysisID">确定</button>
				</ul>
				<!-- /.col-lg-6 -->
			</div>
			<!-- /.navbar-collapse --> </nav><br/>
			<div class="row">
				<div class="col-md-12">
					<!-- Collapsed panel -->
					<div class="panel panel-success">
						<!-- Add class "collapsed" to minimize the panel -->
						<div class="panel-heading">
							<h3 class="panel-title">&nbsp;&nbsp;统计分析报告</h3>
						</div><br/>
						<div class="panel-body">
							<section class="invoice-env">
							<table class="table table-hover">
								<thead>
									<tr class="no-borders">
										<th class=" hidden-xs">检验员：张城龙</th>
										<th></th>
										<th class="hidden-xs">检测地：江西省南昌市</th>
										<th></th>
									</tr>
									<tr class="no-borders">
										<th class=" hidden-xs">检测物类别：糖类</th>
										<th></th>
										<th class=" hidden-xs">检测时间：2017-7-14</th>
										<th></th>

									</tr>
									<tr class="no-borders">
									</tr>

									<tr class="no-borders">
										<th class="text-center hidden-xs">被检测物</th>
										<th width="30%" class="text-center">检测总数</th>
										<th width="20%" class="text-center">合格数</th>
										<th width="10%" class="text-center">合格率</th>
									</tr>
								</thead>
								<tbody id="tbody">
								</tbody>
							</table>
							</section>
						</div>
					</div>
				</div>
			</div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--  END OF PAPER WRAP -->
</#macro>