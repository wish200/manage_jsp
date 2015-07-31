<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--查询实体部门页面(弹出窗口)-->


<div class="pop_process">
<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx }/newrisk/js/common/levCompany.js"></script>
<!--以下页面的js操作-->
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
<%--模拟下拉列表框--%>
selectOption();
initCompany("2","comCode",'${session.userLogin.comcode}');

<%--查询按钮--%>
function Query(){
	$('#popWindow').hide();
	$("#queryForm").ajaxSubmit({
        type : 'post',  
        url : '${ctx}/sysconfig/depManage_depList.do',
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
	$('#queryForm').find('.select span').text('请选择');
}
</script>

    <div class="left">
        <a class="search active">搜索</a>
    </div>
    <div class="right">
        <a href="javascript:closeDiv();" class="close"></a>
        <form id="queryForm" action="" method="post">
        <ul>
            <s:if test="#session.userLogin.comcode==000000">
            <li>
                <label>归属机构：</label>
                <div class="select select_1">
                    <span>请选择</span>
                    <input id="comcode" name="searchDto.comCode" value="<s:property value="session.userLogin.comcode" />" type="hidden"/>
                    <dl id="comCode">
                    </dl>
                </div>
            </li>
            </s:if>
            <li>
            	<label>部门名称：</label>
                <span class="input_1">
                <input name="searchDto.departMentName"  type="text" />
                </span>
            </li>
            <li>
            	<label>状态：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input name="searchDto.userValidstatus" type="hidden"/>
                    <dl>
                        <dd value="">请选择</dd>
                    	<dd value="1">使用</dd>
                        <dd value="0">停用</dd>
                    </dl>
                </div> 
            </li>
            <li class="press_button" style="position:absolute;bottom:35px">
                <a href="javascript:Query();" class="query">查 询</a>
                 <a href="javascript:Reset();" class="reset">重 置</a>
            </li>
        </ul>
        </form>
    </div>
  </div> 
