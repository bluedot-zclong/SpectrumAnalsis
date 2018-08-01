<#assign path="${basePath}">
<#macro datatablestatic basepage_css=["/assets/css/dataTables.bootstrap.min.css","/assets/css/jquery.dataTables.min.css"]
 basepage_js=["/assets/js/jquery.dataTables.min.js"]>

	<#list basepage_css as css>
	<link rel="stylesheet" href="${path}${css}"/>
	</#list>
	<#list basepage_js as js>
	<script type="text/javascript" src="${path}${js}"></script>
	</#list>
</#macro> 