<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--公告概要查询页面(弹出窗口)-->

<div class="pop_process">
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/js/introduce/WdatePicker.js"></script>
<!--以下页面的js操作-->
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
<%--模拟下拉列表框--%>
selectOption();
<%--查询按钮--%>
function Query(){
    $('#popWindow').hide();
    var ajaxUrlNotice='${ctx}/sysconfig/sysPosMan_getSystrmPoseList.do';
    if(returnUrlNotice!=''){
        ajaxUrlNotice+='?searchDto.returnUrl='+returnUrlNotice;
    }
    publicURL="${ctx}/sysconfig/sysPosMan_getSystrmPoseList.do?searchDto.postdesc="+$("input[name='searchDto.postdesc']").val()
	+"&searchDto.remark="+$("input[name='searchDto.remark']").val()
	+"&searchDto.startdate="+$("input[name='searchDto.startdate']").val();//返回地址
	alert(publicURL);
	$("#queryForm").ajaxSubmit({
        type : 'post',  
        url : ajaxUrlNotice,
        error: function(XmlHttpRequest, textStatus, errorThrown){  
             alert( "系统错误");  
        },
        success: function(data){
        	$("#content").html(data);
        	$('.black_overlay').remove();
            $('#popWindow').remove();
        }
    });
}
<%--窗口关闭--%>
function closeDiv(){
	 $('#popWindow').remove();
	 $('.black_overlay').remove();	
}
//--重置
function Reset(){
	$('#queryForm').find('input').val('');
}
</script>

    <div class="left">
        <a class="search active">搜索</a>
    </div>
    <div class="right">
        <a href="javascript:closeDiv();" class="close"></a>
        <form id="queryForm" action="" method="post">
        <ul>
            <li>
            	<label>公告概要：</label>
                <span class="input_1">
                <input name="searchDto.postdesc" type="text" />
                </span>
            </li>
            <li>
            	<label>公告内容：</label>
                <span class="input_1">
                <input name="searchDto.remark" type="text" />
                </span>
            </li>
            <li>
            	<label>发布日期：</label>
                <span class="input_1"  >
                <input name="searchDto.startdate"  type="text"  class="Wdate" onclick="WdatePicker({startDate:'<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>'})">
                </span>
            </li>
            <li class="press_button" style="position:absolute;bottom:35px">
                <a href="javascript:Query();" class="query">查 询</a>
                <a href="javascript:Reset();" class="reset">重 置</a>
            </li>
        </ul>
        </form>
    </div>
  </div> 
