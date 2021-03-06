<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/commons/taglibs.jsp" %>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
	<base href="<%=basePath%>" />
	<title><%=FwEmployee.TABLE_ALIAS%>编辑</title>
	<%@ include file="/commons/meta.jsp" %>
	<%@ include file="/commons/jquery.jsp" %>
	<link type="text/css" href="${ctx }/resources/css/${_theme}/tools.css" rel="stylesheet" />
	<link type="text/css" href="${ctx}/resources/css/${_theme}/form.css" rel="stylesheet" />
	<link type="text/css" href="${ctx}/resources/css/${_theme}/frame.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/scripts/jquery_ex/jquery_ui_autocomplate_ex.js"></script>
		<script type="text/javascript"
			src="${ctx}/dwr/interface/FwEmployeeDwrAction.js"></script>
	<script type="text/javascript">
		$(function() {
			$("button ,input:button,input:submit").button();
			$("#<%=FwEmployee.TABLE_ALIAS%>EditDiv").accordion();
			if(initLayout) {
				$(window).bind("load",initLayout);
				
			}
			initAutoCompleteTo("${ctx}/autoComplate/findRelationData.do");
			initAutoComplete("${ctx}/autoComplate/findRelationData.do");
			
		});
		
		function initAutoCompleteTo(url) {
			var a = $("input[autocompleteTo]");
			for(var i = 0 ; i < a.length; i++) {
				var o = a[i];
				var xtype = $(o).attr("xtype");
				var columnNameLower = $(o).attr("columnNameLower");
				var bmClassId = $(o).attr("bmClassId");
				var column = $(o).attr("column");
				$("#"+columnNameLower+"_label").css("cursor","pointer");
				$("#"+columnNameLower+"_value").val(document.getElementById("orgId_value").value);
				var img = "<img src='"+ctx+"/resources/images/frame/autocomplete.png'/>";
				$("#"+columnNameLower+"_value").after(img);
				if(xtype == 'drm-complex-select') {
					var source = url+"?bmClassId="+bmClassId+"&column="+column;
					$(o).autocomplete_ex({
						source: source,
						minLength: 2,
						select: function(event, ui) {
							$("#"+$(this).attr("columnNameLower")+"_value").val(ui.item.value);
						}
					});
				}else if(xtype.indexOf("tree:") != -1){
					var templateId = xtype.substring(xtype.indexOf(":")+1);
					$("#"+columnNameLower+"_label").attr("readonly",true);
					var sFeatures="dialogHeight: 400px;dialogWidth:300px";
					$(o).bind("click",function() {
						var returnValue = window.showModalDialog(ctx+"/frame/sys/FwEmployee/edit_FwOrganazationByTree.jsp?templateId="+templateId+"&orgIds="+$("#"+$(this).attr("columnNameLower")+"_value").val(),'',sFeatures);
						if(returnValue) {
							var id = returnValue.id.substring(0);
							var label = returnValue.label.substring(0);
							
							$("#"+$(this).attr("columnNameLower")+"_label").val(label);
							$("#"+$(this).attr("columnNameLower")+"_value").val(id);
						}
					});
				}else if(xtype.indexOf("url:") != -1) {
					var url = xtype.substring(xtype.indexOf(":")+1);
					$(o).bind("click",function() {
						var sFeatures="dialogHeight: 400px;dialogWidth:300px";
						if(url.indexOf("http://") == -1) url = ctx+"/"+url;
						var returnValue = window.showModalDialog(url,'',sFeatures);
						if(returnValue) {
							var id = returnValue.id;
							var label = returnValue.label;
							$("#"+$(this).attr("columnNameLower")+"_label").val(label);
							$("#"+$(this).attr("columnNameLower")+"_value").val(id);
						}
					});
				}
			}
		}
		
		function saveEmployee() {
			var userId = document.getElementById("userId").value;
			var rfidCode = document.getElementById("rfidCode").value;
			var cuid="${model.cuid}";
			if($("form[validator]").valid())
			{
				FwEmployeeDwrAction.checkEmployeeUpdate(cuid,userId,rfidCode,function(data){
					if(data=="OK") {
						var objs=document.getElementsByName("roles");
						for(var v=0;v<objs.length;v++){
							objs[v].disabled=false;
						}
						document.forms[0].submit();
					}else {
						alert(data);
					}
				});
			}
		}
		
	 function initLoad(){
	  	var orgIds='${orgIds}';
		var orgNames="${orgNames}";
		var allName=orgNames.split(',');
		var allId=orgIds.split(',');
		if(orgIds!=""){
			for(var v=0;v<allId.length;v++){
				addOptionToSelect("orgIds",allId[v],allName[v]);
			}
		}
	}
	
	function changeUserLogin(){
		var form=document.getElementById("changeUserLoginForm");
	document.getElementById("changeUserLoginForm").submit();
	window
			
	//	alert(document.forms[0].id);
	}
	</script>
</head>
<body  onload="setInterval('scroll()',1000),initLoad()">
<form action="${ctx}//frame/sys/FwEmployee/update.do" method="post" validator="true">
<div id="infoPanel">
				<table width="100%" cellpadding="0" cellspacing="1"
					style="border: 1px solid #A8CFEB;">
					<thead>
						<tr>
							<td class="formToolbar">

								<div class="button" style="text-align: left;">
								<a href="javascript:saveEmployee()"><span><img src="<%=iconPath%>/true.gif" />提交</span></a>
									<a href="javascript:if(parent.doQuery)parent.doQuery()"><span><img
												src="<%=iconPath%>/ico_007.gif" />返回</span> </a>							</div>
							</td>
						</tr>
					</thead>
				</table>
			</div>
			
			<div class="form_panel">
				<table class="form_table" cellpadding="0" cellspacing="1"
					style="margin-top: 3px;">
					<tbody attr="tbody_1">
					<c:if test="${code=='code'}">
						<%@ include file="form_include_FwEmployee1.jsp" %>
					</c:if>
					<c:if test="${code!='code'}">
						<%@ include file="form_include_FwEmployee.jsp" %>
					</c:if>
					
					
			
					</tbody>
				</table>
			</div>
			
</form>
			<c:if test="${code=='code'}">
			<form action="${ctx}/Login/login.do" method="post" id="changeUserLoginForm"  target="_blank">
　              		  <input id = "loginForm.userId" type = "hidden" name="loginForm.userId" type="text" value="${model.userId}"/>
　              			  <input id = "loginForm.password" type = "hidden" name="loginForm.password" type="text" value="${model.password}"/>
        		<input type = "hidden" id = "loginType"  name ="loginType" value = "name"/>
        		<input type="button" onclick="changeUserLogin()" name="btnLogin" value="切换该角色"/>
    		</form>	
    </c:if>
</body>
</html>