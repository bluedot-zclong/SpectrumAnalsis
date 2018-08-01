<#macro updateAlgorithmFile>
<!-- update modal -->
<div class="modal fade" id="upload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">查看算法</h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-default">
                    <div class="panel-body" style="width:120%">
                        <form  role="form" id="algorithmFile" class="form-horizontal"  >        
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="algorithmName">算法名称 <font color="red">*</font></label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="algorithmName" id="algorithmName"  maxlength="16" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="algorithmUploadtime">上传时间 <font color="red">*</font></label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="algorithmUploadtime1" id="algorithmUploadtime" maxlength="16" readonly="readonly" required>
                                </div>
                            </div>
                            <div class="form-group-separator"></div>

                            <div class="form-group-separator"></div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="algorithmVersion">算法版本号 <font color="red">*</font></label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="algorithmVersion" id="algorithmVersion" maxlength="16" required>
                                </div>
                            </div>
                            <div class="form-group-separator"></div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="algorithmSort">算法类型 <font color="red">*</font></label>
                                <div class="col-sm-6">
								    <select class="form-control" id="algorithmSort" name="algorithmSort">
								      <option value="0">预处理算法</option>
								      <option value="1">分析算法</option>
								    </select>
                                </div>
                            </div>
                            <div class="form-group-separator"></div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="algorithmLanguage">算法语言<font color="red">*</font></label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="algorithmLanguage" id="algorithmLanguage" maxlength="16" required>
                                </div>
                            </div>
                            <div class="form-group-separator"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="dirFileId">存放文件夹 <font
									color="red">*</font></label>
								<div class="col-sm-6">
									<select class="form-control" name="dirFileId" id="dirFileId" required>

									</select>
								</div>
							</div>
                            <div class="form-group-separator"></div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="algorithmDscription">算法描述 <font color="red">*</font></label>
                                <div class="col-sm-6">
                                    <textarea class="form-control autogrow" cols="5" name="algorithmDscription" id="algorithmDscription" maxlength="200" required></textarea>
                                </div>
                            </div>
                            <div class="form-group-separator"></div>
                            <div class="form-group col-sm-6 pull-right" >
                            	<input type="text" class="hidden" name="algorithmId" id="algorithmId" maxlength="16" required>
                            	<button type="button" class="btn btn-default" id="updateAlgorithm">修改</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</#macro>