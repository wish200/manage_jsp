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
    var ajaxUrlNotice='${ctx}/huiben/huiben_getList.do';
    if(returnUrlNotice!=''){
        ajaxUrlNotice+='?searchDto.returnUrl='+returnUrlNotice;
    }
    publicURL="${ctx}/huiben/huiben_getList.do?searchDto.huibenid="+$("input[name='searchDto.huibenid']").val()
    +"&searchDto.picbookid="+$("input[name='searchDto.picbookid']").val()
	+"&searchDto.picbookname="+$("input[name='searchDto.picbookname']").val()
	+"&searchDto.audioid="+$("input[name='searchDto.audioid']").val()
	+"&searchDto.audioname="+$("input[name='searchDto.audioname']").val()
	+"&searchDto.userid="+$("input[name='searchDto.userid']").val()
	+"&searchDto.validstate="+$("input[name='searchDto.validstate']").val();
	
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
            	<label>绘本编号：</label>
                <span class="input_1">
                <input name="searchDto.huibenid" type="text" />
                </span>
            </li>
            <li>
            	<label>绘画编号：</label>
                <span class="input_1">
                <input name="searchDto.picbookid" type="text" />
                </span>
            </li>
            <li>
            	<label>绘画名称：</label>
                <span class="input_1">
                <input name="searchDto.picbookname" type="text" />
                </span>
            </li>
            <li>
            	<label>绘音编号：</label>
                <span class="input_1">
                <input name="searchDto.audioid" type="text" />
                </span>
            </li>
            <li>
            	<label>绘音名称：</label>
                <span class="input_1">
                <input name="searchDto.audioname" type="text" />
                </span>
            </li>
            <li>
            	<label>用户ID：</label>
                <span class="input_1">
                <input name="searchDto.userid" type="text" />
                </span>
            </li>
            <li>
            	<label>状态：</label>
                <span >
               		 <select id="validstate" class="selector" name="searchDto.validstate">
                    	<option value="">全部</option>
                    	<option value="0">无效</option>
                    	<option value="1" selected>有效</option>
                     </select>
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
