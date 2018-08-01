<#assign path="${basePath}">
<#macro recyclepagebody>
 	
			<div class="row">
				<div class="col-md-12">
					<div class="tab-content">
						<div class="tab-pane active" id="profile">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h3 class="panel-title">回收站列表</h3>
								</div>
								<div class="panel-body">

									<table class="table table-striped table-bordered"
										id="example-4">
										<thead>
											<tr class="replace-inputs">
												<th>编号</th>
												<th>文件名称</th>
												<th>文件类型</th>
												<th>删除时间</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${recyclebin }" var="recycle">
												<c:if test="${recycle.isDelete == 1 }">
													<tr>
														<c:if test="${recycle.spectrumName != null }">
															<td>${recycle.Id }</td>
															<td>${recycle.spectrumName }</td>
															<td>光谱文件</td>
															<td>${recycle.saveTime }</td>
															<td><a href="javascript:;"
																onclick="recover(${recycle.Id}, 'spectrum', this)"
																class="btn btn-secondary btn-sm btn-icon icon-left">
																	恢复 </a> <a href="javascript:;"
																onclick="delete_file(${recycle.Id}, 'spectrum', this)"
																class="btn btn-danger btn-sm btn-icon icon-left"> 删除
															</a>
														</c:if>
														<c:if test="${recycle.algorithmName != null }">
															<td>${recycle.id }</td>
															<td>${recycle.algorithmName }</td>
															<td>算法文件</td>
															<td>${recycle.algorithmUploadtime }</td>
															<td><a href="javascript:;"
																onclick="recover(${recycle.id}, 'algorithm', this)"
																class="btn btn-secondary btn-sm btn-icon icon-left">
																	恢复 </a> <a href="javascript:;"
																onclick="delete_file(${recycle.id}, 'algorithm', this)"
																class="btn btn-danger btn-sm btn-icon icon-left"> 删除
															</a></td>
														</c:if>
													</tr>
												</c:if>
											</c:forEach>
										</tbody>
										
									</table>

								</div>
							</div>

						</div>
					</div>

				</div>

			</div>

			<%--页脚 --%>
			<jsp:include page="/WEB-INF/jsps/footer.jsp"></jsp:include>
		</div>
	</div>

	<div class="page-loading-overlay">
		<div class="loader-2"></div>
	</div>
	<!-- Imported styles on this page -->
	<link rel="stylesheet"
		href="../assets/js/datatables/dataTables.bootstrap.css">

	<!-- Modal 1 (Custom Width)-->
	<form action='<c:url value="/filehandle.do" />' method="post">
		<div class="modal fade" id="modal-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">确认提示（警告！）</h4>
					</div>

					<div class="modal-body">您确定要删除么？（删除后将无法找回！）</div>

					<div class="modal-footer">
						<input type="hidden" name="handle" value="delete"> <input
							type="hidden" id="fileid" name="id" value=""> <input
							type="hidden" id="tablename" name="table" value="">
						<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-info">删除</button>
					</div>
				</div>
			</div>
		</div>
	</form>

	<!-- Modal 6 (Custom Width)-->
	<div class="modal fade" id="modal-6">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">确认提示</h4>
				</div>

				<div class="modal-body">您确定要恢复么？</div>

				<div class="modal-footer">
					<form action='<c:url value="/filehandle.do" />' method="post">
						<input type="hidden" name="handle" value="recover"> <input
							type="hidden" id="fileid1" name="id1" value="123"> <input
							type="hidden" id="tablename1" name="table1" value="123">
						<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-info">update</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</#macro>

