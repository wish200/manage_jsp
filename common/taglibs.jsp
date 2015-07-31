<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%--fmt国际化格式化  --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%--fn处理字符串的标签  --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="Copyright" value="绘听网络科技" />
<script type="text/javascript">
	var contextRootPath = "${ctx}";
	var sysDate="${session.sysDate}";
	var sysDateQ="${session.sysDateQ}";
</script>


<%--支持jquery--%>
<script type="text/javascript" src="${ctx}/js/introduce/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/introduce/base_js.js"></script>
<script type="text/javascript" src="${ctx}/js/common/public.js"></script>
<!--打印预览、下载Excel-->
<script type="text/javascript" src="${ctx}/js/introduce/LodopFuncs.js"></script>

<%--ajax表单提交--%>
<script type="text/javascript" src="${ctx}/js/introduce/jquery.form.min.js"></script>
<link href="${ctx}/style/style.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/style/base.css" rel="stylesheet" type="text/css" />

