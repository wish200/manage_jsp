<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--查询User页面(弹出窗口)-->


<div class="pop_process">
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx }/newrisk/js/common/levCompany1.js"></script>
<!--以下页面的js操作-->
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
<%--主责部门名称选择--%>
// initDepartment();
initCompany("2","comCode",'${session.userLogin.comcode}');
<%--模拟下拉列表框--%>
$("#validstatus").parent('div').find('span').click(function(){
    var thisinput=$(this);
    var thisInputvar=$(this).next("input");
    var thisul=$(this).parent().find("dl");
    if(thisul.css("display")=="none"){
        if(thisul.height()>150){thisul.css({height:"100"+"px","overflow-y":"scroll"});};
        thisul.fadeIn("100");
        thisul.parent().css("z-index","9999");
        thisul.hover(function(){},function(){thisul.fadeOut("100");thisul.parent().css("z-index","2");});
        thisinput.parent().hover(function(){},function(){thisul.fadeOut("100");thisul.parent().css("z-index","2");});
        thisul.find("dd").click(function(){
            thisinput.text($(this).text());
            thisInputvar.val($(this).attr('value'));
            thisul.fadeOut("100");
            });
        }
    else{
        thisul.fadeOut("fast");
        }
});
<%--查询按钮--%>
function QueryT(){
	$('#popWindow').hide();
	$("#queryForm").ajaxSubmit({
        type : 'post',  
        url : '${ctx }/sysconfig/userManage_queryUserList.do',
        error: function(XmlHttpRequest, textStatus, errorThrown){  
             alert( "系统错误");  
        },
        success: function(result){
        	$("#content").html(result);
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
            <li>
            	<label>人员名称：</label>
                <span class="input_1">
                <input name="searchDto.userName" type="text" />
                </span>
            </li>
             <s:if test="#session.userLogin.comcode=='000000'">
            <li>
            	<label>归属机构：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input name="searchDto.comCode" type="hidden"/>
                    <dl id="comCode">
                    </dl>
                </div> 
            </li>
            </s:if>
            <li>
            	<label>归属部门：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input  name="searchDto.newDepCode" type="hidden"/>
                    <dl id="department">
                    </dl>
                </div> 
            </li>
            <li>
            	<label>状态：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input name="searchDto.userValidstatus" type="hidden"/>
                    <dl id="validstatus">
                        <dd value="">请选择</dd>
                    	<dd value="1">使用</dd>
                        <dd value="0">停用</dd>
                    </dl>
                </div> 
            </li>
            <li class="press_button" style="margin-top:-20px">
                <a href="javascript:QueryT();" class="query">查 询</a>
                <a href="javascript:Reset();" class="reset">重 置</a>
            </li>
        </ul>
        </form>
    </div>
  </div> 
