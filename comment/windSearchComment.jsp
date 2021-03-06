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
    var ajaxUrlNotice='${ctx}/comment/comment_getList.do';
    if(returnUrlNotice!=''){
        ajaxUrlNotice+='?searchDto.returnUrl='+returnUrlNotice;
    }
    publicURL="${ctx}/comment/comment_getList.do?searchDto.commentid="+$("input[name='searchDto.commentid']").val()
	+"&searchDto.commentname="+$("input[name='searchDto.commentname']").val();
	
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
            	<label>评论编号：</label>
                <span class="input_1">
                <input name="searchDto.commentid" type="text" />
                </span>
            </li>
            <li>
            	<label>评论用户：</label>
                <span class="input_1">
                <input name="searchDto.userid" type="text" />
                </span>
            </li>
            <li>
            	<label>模块：</label>
                <span class="input_1">
                <input name="searchDto.modular" type="text" />
                </span>
            </li>
            <li>
            	<label>业务ID：</label>
                <span class="input_1">
                <input name="searchDto.busiid" type="text" />
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
