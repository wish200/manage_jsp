<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<!--查看指标计算公式的因子页面(弹出窗口)-->

<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<!--以下页面的js操作-->
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
<%--窗口关闭--%>
</script>
  <div class="searchpop_big" style="background:0;padding-top:0px;margin-top:-30px;padding-left:20px">
  <div class="title" style="">邮件内容<a href="javascript:closeDiv()" title="关闭" class="close"></a></div>
    <div class="con" style="width:520px;">
         <div  style="width:100%;height:400px;">
          <textarea id="editor_id"  name="cdEmailTemplateBaseDto.bodyoftempl" style="width:103%;height:400px;display: none" ></textarea>
        </div>
    </div>
  </div>