<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>人保风险管理系统</title>
<%@include file="/newrisk/jsp/common/temptaglibs2.jsp"%>
<link href="${ctx}/newrisk/resource/styles/head.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<div class="BreadNav" >
	<%-- href="${ctx}/risk/jsp/common/frameMain.jsp" --%>
	         <a style="cursor:default;" target="_parent"><s:property value="titleName"/></a>
	         <a style="cursor:default;" target="frameContent" ><s:property value="oneMenu"/> </a> 
	         <a style="cursor:default;" target="frameContent"> <s:property value="threeMenu"/> </a> 
	         <a style="cursor:default;" target="frameContent"> <s:property value="twoMenu"/> </a> 
	</div>
	<%--  <img src="${ctx}/images/btn_expand.gif" width="181" height="36" border="0"
            onClick=" JavaScript:setFramesWidth(this);" style="cursor: pointer"> --%>
</body>
</html>