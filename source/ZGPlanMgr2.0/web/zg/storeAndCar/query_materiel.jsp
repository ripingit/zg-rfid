<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.boco.frame.sys.base.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/commons/taglibs.jsp" %>
<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
	String expandIcon = basePath+"/resources/images/frame/ico_expand.gif";
%>
<html>
<head>
	<base href="<%=basePath%>" />
	<title><%=FwEmployee.TABLE_ALIAS%>查询</title>
	<%@ include file="/commons/meta.jsp" %>
	<%@ include file="/commons/jquery.jsp" %>
	<script type="text/javascript" src="${ctx}/scripts/jquery_ex/jquery_ui_autocomplate_ex.js"></script>

	<link type="text/css" href="${ctx}/resources/css/${_theme}/tools.css" rel="stylesheet" />
	<link type="text/css" href="${ctx}/resources/css/${_theme}/form.css" rel="stylesheet" />
	<style>
		body,html {overflow:hidden}
	</style>
	<script language="javascript" event="onkeydown" for="document">  
	<!--
	if(event.keyCode==13)  
	{  
	  document.getElementById("queryBtn").click();  
	} 
	-->
	</script> 
	<script type="text/javascript">
		$(function() {
			init();
		});
		function init() {
			initSplit();
			doLayout();
			$(window).bind("resize",doLayout);
			//$("form:first").submit();
		}
		function doLayout() {
			var maxHeight = top.getContentHeight();
			var maxWidth = top.getContentWidth();
			var splitH = document.getElementById("split_1").offsetHeight;
			var queryPanelH = maxHeight - splitH;
			document.getElementById("_queryPanel").style.height = queryPanelH + 'px';
			var queryTableH = document.getElementById("query_table").offsetHeight;
			var listFrameH = queryPanelH - queryTableH;
			document.getElementById("listFrame").style.height = listFrameH + 'px';
			document.getElementById("listFrame").style.width = maxWidth + 'px';
			var operateFrameH = queryPanelH;
			document.getElementById("operateFrame").style.height = operateFrameH + 'px';
			document.getElementById("_operatePanel").style.height = operateFrameH + 'px';
		}
		
		function doQuery() {
			if(document.getElementById("_queryPanel").style.display == 'none') {
				changePanel(document.getElementById("split_1"));
			}
			if(batchValidation('listFrame','${ctx}//frame/sys/ZgBomCar/listForMateriel.do',document.forms[0])) {
				document.forms[0].submit();
			}
		}
		
		
		
		
	</script>
</head>

<body>
<div id="_queryPanel">
<form id="form1" action="${ctx}/frame/sys/ZgBomCar/listForMateriel.do?orgId=${orgId}" method="post" target="listFrame">
	<input type="hidden" name="bmClassId" value="<%=FwEmployee.BM_CLASS_ID%>"/>
	<input type="hidden"  name="s_equalBmClassIdQuery"  value="${pageRequest.filters.equalBmClassIdQuery}"/>
	<input type="hidden"  name="s_inSubBmClassIdQuery"  value="${pageRequest.filters.inSubBmClassIdQuery}"/>
	<input type="hidden" name="s_orgId" id="s_orgId" value="${orgId}"/>
	<input type="hidden" name="s_parentOrgId" id="s_parentOrgId" value="${parentOrgId}"/>
	<input type="hidden" maxlength="13" name="s_carName" id="s_carName"/>
	<input type="hidden" maxlength="13" name="s_storeName" id="s_storeName" value="${parentName }" readOnly="readOnly"/>
	<input type="hidden" maxlength="13" name="s_materielGroupName" id="s_materielGroupName" value="${materielGroupName }" readOnly="readOnly"/>
		<table  id="query_table" class="query_panel" cellpadding="0" cellspacing="0">
				<tr>
				   <td class="label">
				   		物料组编号：
				   </td>
				   <td >
			   			<input type="text" maxlength="20" name="s_materielId" id="s_materielId"/>
				   </td>
					<td>
					</td>
					<td class="label">
					</td>	
					<td>
					</td>
				</tr>
				<tr>
					<td colspan="10">
						<div class="toolbar">
								<a id="queryBtn" href="javascript:batchValidation('listFrame','${ctx}//frame/sys/ZgBomCar/listForMateriel.do?orgId=${orgId}',document.forms[0]);document.forms[0].submit()"><span><img src="<%=iconPath%>/ico_search.gif" />查询</span></a>
								<a href="javascript:document.forms[0].reset()"><span><img src="<%=iconPath%>/ico_007.gif" />重置</span></a>
						</div>
					</td>
				</tr>
		</table>
</form>
	<iframe id="listFrame" src="" name="listFrame" frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
</div>

<div id="split_1" ></div>
 
<div id="_operatePanel" class="operatorPanel" style="display: none;">
	<iframe id="operateFrame" src="" name="operateFrame" frameborder="0" width="100%" scrolling="no"></iframe>
</div>

</body>
</html>