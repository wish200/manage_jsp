<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	var contextRootPath = "${ctx}";
</script>


<script type="text/javascript"
	src="${ctx}/newrisk/resource/js/jquery-1.10.2.min.js"></script>
<link href="${ctx}/newrisk/resource/styles/layout.css" rel="stylesheet" />


