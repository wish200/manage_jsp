<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="${ctx}/newrisk/js/common/selectTime.js"></script>
<script type="text/javascript">
selectOption();
addTime(5,"#muYearid","#muMonthid","");
//查询
function query(){
    var _year= $("#year").val();
    var _month= $("#month").val();
    if(_month==''||_year==''){
        alert("请选择时间");
       return; 
    }else{
        var  _yearMonth=_year+_month;
        closePopWind();
        var data={
         'searchDto.statDate':_yearMonth,
         'searchDto.doing':$("#Doing").val()
        };
        asy_Ajax("${ctx}/common/login_getAllIndex.do",data,'html',function(data){
            $("#kripage").html(data);
        });
    }
}
//重置
function reset(){
   $("input").each(function(){
    $(this).val("");   
   });
  $(".select").each(function(){
        $(this).find('span').each(function(){
            $(this).html("请选择");
        });   
  });
  
}

</script>
  <div class="pop_process" id="windKRIsearch">
    <div class="left">
        <a class="search active">搜索</a>
    </div>
    <div class="right">
        <a href="javascript:closePopWind();" class="close"></a>
           <input id="yearMonth" name="searchDto.statDate" value="" type="hidden">
        <ul>
           <!--  <li>
                <li>
                <label>指标名称：</label>
                <span class="input_1">
                   <input id="indexName" type="text" />
                </span>
            </li> -->
            <li>
                <label>预警期次：</label>
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
            <li class="press_button">
                <a href="javascript:query();" class="query">查 询</a>
                <a href="javascript:reset();" class="reset">重 置</a>
            </li>
        </ul>
    </div>
  </div> 
