<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.boco.zg.plan.base.model.*" %>
<%@page import="cn.org.rapid_framework.page.*" %>
<%@page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/commons/taglibs.jsp" %>
<%@ taglib uri="/framework/tag" prefix="fw" %>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";

%>
<html>
<head>
	<base href="<%=basePath%>" />
	<title><%=ZgTorder.TABLE_ALIAS%> 维护</title>
	<%@ include file="/commons/meta.jsp" %>
	<%@ include file="/commons/jquery.jsp" %>
	<link type="text/css" href="${ctx}/resources/css/${_theme}/frame.css" rel="stylesheet" />
	<script type="text/javascript">
	</script>
</head>
<body scroll="auto">
<%@ include file="/commons/messages.jsp" %>
<form id="ec" action="<c:url value="/zg/plan/ZgTorder/list.do"/>" method="post" style="display: inline;">
		<input type="hidden" name="storageId" value="${storageId}"}/>
		<input type="hidden" name="type" value="${type}"}/>
			<input type="hidden" name="productType" value="${productType}"}/>
		
	<div>
		<div>
		</div>
		<div class="datalist">
			<h2>订单管理</h2>
			<div class="toolbar">
			</div>
			<div class="eXtremeTable" >
				<table id="ec_table"  border="0"  cellspacing="1"  cellpadding="0"  class="tableRegion"  width="100%">
					<thead>
						<tr>
		<td class="tableHeader"  width="3%" ><input type='checkbox' onclick="setAllCheckboxState('items',this.checked)" ></td>
							<td class="tableHeader">
							订单号
						</td>
						<td class="tableHeader">
							生产线
						</td>
						<td class="tableHeader">
							物料号
						</td>
						<td class="tableHeader">
							物料描述
						</td>
						<td class="tableHeader">
							半成品名称
						</td>
						<td class="tableHeader">
							单位
						</td>
						<td class="tableHeader">
							组件单台用量
						</td>
						<td class="tableHeader">
						
						 <c:if test="${type=='2'}">可出库数量</c:if>
							 <c:if test="${type=='1'}">组件需求总数</c:if>
						</td>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${bomList}" var="obj" varStatus="n">
						<c:set var="trcss" value="${n.count%2==0?'odd':'even'}"/>
						<tr class="${trcss}" onmouseover="this.style.backgroundColor = '#EBF1FF'"  onmouseout="this.style.backgroundColor = '#FFFFFF'">
							<td width="3%" >
							<input type="checkbox"
								value="orderAufnr=${obj.orderAufnr }&arbpl=${obj.arbpl}&matnr=${obj.matnr }&idnrk=${obj.idnrk }&msehl1=${obj.msehl1 }&menge=${obj.menge }&orderBomId=${obj.orderBomId }&storageId=${storageId }" name="items" />
							</td>
							<td>
									${obj.orderAufnr}
								</td>
								<td>
									${obj.arbpl}
								</td>
								<td>
									${obj.matnr}
								</td>
								<td>
									${obj.maktx1}
								</td>
								<td>
									${obj.idnrk }
								</td>
								<td>
									${obj.msehl1}
								</td>
								<td>
									${obj.zdtyl}
								</td>
									<td>
									${obj.menge}
								</td>
					</c:forEach>
						<tr style="padding: 0px;" >
							<td colspan="12" >
							</td>
						</tr>
				</tbody>
			</table>
		</div>
	</div>
</form>
</body>
</html>