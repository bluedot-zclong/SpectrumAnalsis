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
                        <span>光谱信息
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

       <!-- 面包屑导航结束 -->
        <div class="content-wrap">
       	<br>
        <button type="button" class="btn btn-info" onclick="getInfo()">修改信息</button>
        <a class="btn btn-info" href="${path}/spectrum/queryDetechLine.do?id=${spectrum.spectruminfoId}">分析光谱</a>
            <!-- 空白页-->
            <div class="nest" id="Blank_PageClose">
                <div class="title-alt">
                    <h6>
                        光谱名称</h6>
                </div>

                <div class="body-nest" id="Blank_Page_Content">
                	<p><strong>光谱名称：</strong>${spectrum.spectrumName}</p>
               		<p><strong>光谱描述：</strong>${spectrum.spectrumDescription}</p>
                </div>
            </div>
        </div>
        
         <!-- 面包屑导航结束 -->
        <div class="content-wrap">
        	<br>
            <!-- 空白页-->
            <div class="nest" id="Blank_PageClose">
                <div class="title-alt">
                    <h6>
                       光谱详细信息</h6>
                    <div class="titleToggle">
                         <a href="javascript:;" onclick="window.print();" class="btn btn-block btn-secondary btn-icon btn-icon-standalone btn-icon-standalone-right btn-single text-left">
				                  <span>打印</span>
				          </a>
                    </div>
                </div>
<!-- Invoice Options Buttons -->
                <div class="body-nest" id="Blank_Page_Content">
                	 <section class="invoice-env">
				                    <!-- Invoice header -->
				                    <div class="invoice-header">
				                        <!-- Invoice Data Header -->
				                        <div class="invoice-logo">
				                            <ul class="list-unstyled">
				                                <li class="upper">
				                                    <strong>光谱类型：</strong>${spectrum.spectrumTypeName}
				                                </li>
				                                <li>
				                                    <strong>光谱文件类型：</strong>${spectrum.spectrumTypeName}
				                                </li>
				                                <li>
				                                    <strong>硬件类型：</strong>${spectrum.hardwareName}
				                                </li>
				                                <li>
				                                    <strong>是否标准库：</strong>
				                                    ${(spectrum.isStandardSpectrum==0)?string('否','是')}
				                                                                        </li>
				                                <li>
				                                    <strong>采用标准：</strong>${spectrum.spectrumDescription}
				                                </li>
				                                <li>
				                                    <strong>保存时间：</strong>${spectrum.saveTime?date}
				                                </li>
				                            </ul>
				                        </div>
				                    </div>
				                    <!-- Client and Payment Details -->
				                    <div class="invoice-details">
				                        <div class="invoice-client-info">
				                            <strong>被检测物</strong>
				                            <table id="example">
				                            	<tbody>
				                            		<tr>
							                                <td>学名：</td>
							                                <td>${spectrum.spectrumDescription}</td>
							                                
				                            		</tr>
				                            		<tr>
				                            			 <td>产地：</td>
				                            			 <td>${spectrum.categoryOrigin}</td>
				                            		</tr>
				                           	 </tbody>
				                            </table>
				                        </div>
				                        <div class="invoice-payment-info">
				                            <strong>检测内容</strong>
				                            <ul class="list-unstyled">
				                                    <li>${spectrum.spectrumDescription}</li>
				                                    <li>${spectrum.spectrumDescription}</li>
				                            </ul>
				                        </div>
				                    </div>
				                    <hr>
				                    <div class="invoice-details">
				                        <div class="invoice-client-info">
				                            <strong>特征峰值：</strong>
				                            <ul class="list-unstyled">
				                                <li>${spectrum.spectrumDescription}</li>
				                                <li>${spectrum.spectrumDescription}</li>
				                                <li>${spectrum.spectrumDescription}</li>
				                                <li>${spectrum.spectrumDescription}</li>
				                            </ul>
				                        </div>
				                    </div>
				                    <hr>
				                </section>
			<div class="nest" id="Blank_PageClose">
                <div class="title-alt">
                    <h6>
                       光谱图像</h6>
                    <div class="titleToggle">
                         <a href="javascript:;" onclick="window.print();" class="btn btn-block btn-secondary btn-icon btn-icon-standalone btn-icon-standalone-right btn-single text-left">
				                  <span>下载</span>
				          </a>
                    </div>
                </div>     
				                
					<div class="row">
						 <div id="main" style="width: 1000px;height:400px;"></div>
					</div>
				</section>
                </div>
            </div>
        </div>
        
    </div>
</div>
<div class="modal fade" id="uploadmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">修改光谱信息</h4>
					</div>
					<div class="modal-body">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">修改</h3>
							</div>
							<div class="panel-body">
								<form id="spectrum" action="${path}/spectrum/update.do" role="form" class="form-horizontal" method="post" enctype="multipart/form-data">
									<div class="form-group">
										<label class="col-sm-3 control-label" for="pluginName">光谱名称 <font color="red">*</font></label>
										<div class="col-sm-6">
											<input type="text" class="form-control" name="spectrumName" id="spectrumName" placeholder="请填写您的光谱名称" maxlength="16" required>
											<input type="text" class="form-control hidden" name="spectruminfoId" value="${spectrum.spectruminfoId}" placeholder="如氨基酸" maxlength="16" required>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label" for="pluginName">被检测物产地<font color="red">*</font></label>
										<div class="col-sm-6">
											<input type="text" class="form-control" name="categoryOrigin" id="categoryOrigin" placeholder="请填写被检测物" maxlength="16" required>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label" for="pluginName">被检测物<font color="red">*</font></label>
										<div class="col-sm-6">
											<input type="text" class="form-control" name="plugin.version" id="detectedObject" placeholder="如氨基酸" maxlength="16" required>
											<input type="text" class="form-control hidden" name="detectedId" id="detectedObjectId" placeholder="如氨基酸" maxlength="16" required>
										</div>
									</div>
									
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label">光谱类型 <font color="red">*</font></label>
										<div class="col-sm-6">
											<select class="form-control" name="spectrumTypeName" id="type" required>
											</select>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label">存放位置<font color="red">*</font></label>
										<div class="col-sm-6">
											<select class="form-control" name="fileId" id="fileList" required>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label">XUnit<font color="red">*</font></label>
										<div class="col-sm-3">
											<select class="form-control" name="XUnit" id="pluginType" required>
												<option value="波数">波数</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label">YUnit<font color="red">*</font></label>
										<div class="col-sm-3">
											<select class="form-control" name="YUnit" id="pluginType" required>
												<option value="吸光度">吸光度</option>
											</select>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label" for="description">光谱描述 <font color="red">*</font></label>
										<div class="col-sm-6">
											<textarea class="form-control autogrow" cols="5" name="spectrumDescription" id="description" placeholder="请填写您的光谱描述" maxlength="200" required></textarea>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group col-sm-6 pull-right" >
										<button type="submit" id="update" class="btn btn-success">修改</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
<!-- 检验线模态框 -->		
<div class="modal fade" id="detechLine" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">修改光谱信息</h4>
					</div>
					<div class="modal-body">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">修改</h3>
							</div>
							<div class="panel-body">
								<form id="spectrum" action="${path}/spectrum/update.do" role="form" class="form-horizontal" method="post" enctype="multipart/form-data">
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label">光谱类型 <font color="red">*</font></label>
										<div class="col-sm-6">
											<select class="form-control" name="spectrumTypeName" id="type" required>
											</select>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label">存放位置<font color="red">*</font></label>
										<div class="col-sm-6">
											<select class="form-control" name="fileId" id="fileList" required>
											</select>
										</div>
									</div>
									<div class="form-group-separator"></div>
									<div class="form-group col-sm-6 pull-right" >
										<button type="submit" id="update" class="btn btn-success">修改</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


<script type="text/javascript">
	function getInfo(){
		 var id = ${spectrum.spectruminfoId};
		 $.post("${path}/spectrum/query/ajax.do",
			  {
			    spectrumId:id,
			  },
			  function(data,status){
			  		$("#spectrumName").val(data.obj.spectrum.spectrumName)
			  		$("#categoryOrigin").val(data.obj.spectrum.categoryOrigin)
			  		$("#description").val(data.obj.spectrum.spectrumDescription)
			  		$("#detectedObject").val(data.obj.detectedObject.detectedObjectsName)
			  		$("#detectedObjectId").val(data.obj.detectedObject.detectedObjectsId)
					foreachFile(data.obj.fileList)
					getfileName(data.obj.spectrum.fileId,data.obj.fileList)
								  		
			  		foreachSpectrumType(data.obj.spectrumType)
			  		
			  		$('#uploadmodal').modal('show')
			  });
		
	}
	
	function foreachFile(FileList){
		for(var i=0;i<FileList.length;i++){
		    var file = FileList[i];
			$("#fileList").append("<option value='"+file.dirId+ "'>"+file.dirName+"</option>")
		}
	}
	function foreachSpectrumType(spectrumTypeList){
		for(var i=0;i<spectrumTypeList.length;i++){
		    var spectrumType = spectrumTypeList[i];
			$("#type").append("<option>"+spectrumType.spectrumtypeName+"</option>")
		}
	}
	function getfileName(id,FileList){
		for(var i=0;i<FileList.length;i++){
		    var file = FileList[i];
		    if(id===file.dirId){
				$("#fileList").find("option[value='"+file.dirName+"']").attr("selected","selected")
			}
		}
	}
	
	function getdetechLines(){
		$('#detechLine').modal('show')
	}
</script>
<script type="text/javascript">
	var id = ${spectrum.spectruminfoId};
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
    $.ajax({
        type: "POST",//请求方式
        url: "${path}/spectrum/getSpectrumImage/ajax.do",//地址，就是json文件的请求路径
        data:{spectrumId:id},
        success: function (data, status) {
            alert(status);
            console.log(data);
            myChart.setOption(option = {
                title: {
                    text: 'Spectrum'
                },
                tooltip: {
                    trigger: 'axis'
                },
                xAxis: {
                    data: data.obj.points.map(function (item) {
                        console.log(data);
                        return item.x;
                    })
                },
                yAxis: {
                    splitLine: {
                        show: false
                    }
                },
                toolbox: {
                    left: 'center',
                    feature: {
                        dataZoom: {
                            yAxisIndex: 'none'
                        },
                        restore: {},
                        saveAsImage: {}
                    }
                },
                dataZoom: [{
                    startValue: '2012-06-01'
                }, {
                    type: 'inside'
                }],
                visualMap: {
                    top: 10,
                    right: 10,
                    pieces: [{
                        gt: 0,
                        lte: 50,
                        color: '#096'
                    }, {
                        gt: 50,
                        lte: 100,
                        color: '#ffde33'
                    }, {
                        gt: 100,
                        lte: 150,
                        color: '#ff9933'
                    }, {
                        gt: 150,
                        lte: 200,
                        color: '#cc0033'
                    }, {
                        gt: 200,
                        lte: 300,
                        color: '#660099'
                    }, {
                        gt: 300,
                        color: '#7e0023'
                    }],
                    outOfRange: {
                        color: '#999'
                    }
                },
                series: {
                    name: 'Beijing AQI',
                    type: 'line',
                    data: data.obj.points.map(function (item) {
                        console.log(item.y);
                        return item.y;
                    }),
                    markLine: {
                        silent: true,
                        data: [{
                            yAxis: 50
                        }, {
                            yAxis: 100
                        }, {
                            yAxis: 150
                        }, {
                            yAxis: 200
                        }, {
                            yAxis: 300
                        }]
                    }
                }
            });

        }
    });

</script>
<!--  END OF PAPER WRAP -->
</#macro>