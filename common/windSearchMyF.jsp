<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--分类监管评估页面(弹出窗口)-->


<div class="pop_process">
<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/newrisk/js/common/selectTime.js"></script>
<!--以下页面的js操作-->
<script type="text/javascript">
<%--模拟下拉列表框--%>
selectOption();
addTime(5,"#muYearid","#muMonthid","");
<%--查询按钮--%>
function Query(){
	var year= $("#year").val();
    var month= $("#month").val();
    if(month==''||year==''){
        alert("请选择时间");
       return; 
    }else{
        var  yearMonth=year+month;
        var data={
         'searchDto.statDate':yearMonth
        };
        asy_Ajax("${ctx }/monitorwarn/index_getHaveDivList.do",data,'html',function(data){
            $("#content").html(data);
            $('#popWindow').remove();
            $('.black_overlay').remove();
        });
    }
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
    <div class="right" id="queryForm">
        <a href="javascript:closeDiv();" class="close"></a>
        <input id="yearMonth" name="searchDto.statDate" value="" type="hidden">
        <ul>
            <li>
            	<label>数据期次：</label>
                <div class="select select_3">
                    <span>请选择</span>
                     <input id="year" value="" type="hidden" >
                     <dl id="muYearid">
                        <dd value="我选择的是1" >请选择1</dd>
                        <dd value="我选择的是2" >请选择2</dd>
                        <dd value="我选择的是2" >请选择3</dd>
                    </dl>
                   
                </div>
                <div class="select select_3">
                    <span>请选择</span>
                    <input id="month" value="" type="hidden">
                    <dl id="muMonthid">
                        <dd>请选择1</dd>
                        <dd>请选择2</dd>
                        <dd>请选择3</dd>
                    </dl>
                </div>
            </li>
            <li class="press_button" style="margin-top:-10px">
                <a href="javascript:Query()" class="query">查 询</a>
                <a href="javascript:Reset()" class="reset">重 置</a>
            </li>
        </ul>
    </div>
  </div> 
