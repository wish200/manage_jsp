<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="${ctx}/newrisk/js/common/selectTime.js"></script>
<script type="text/javascript" src="${ctx }/newrisk/js/common/levCompany.js"></script>
<script type="text/javascript">
if('${session.userLogin.comcode}'=='000000'){
    initCompany("2","comCode");
}
$(".black_overlay").css("height",$(document).height());
selectOption();
addTime(5,"#muYearid","#muMonthid","");
//查询
function query(){
    var _year= $("#year").val();
    var _month= $("#month").val();
    if((_month==''&&_year=='')||(_month==''&&_year!='')){
        alert("请正确选择时间");
       return; 
    }else{
	    var  _yearMonth=_year+_month;
	    var comcode=$("input[name='searchDto.comCode']").val();
        closePopWind();
        var data={
         'searchDto.comCode':comcode,
         'searchDto.statDate':_yearMonth,
         'searchDto.doing':$("#Doing").val()
        };
        asy_Ajax("${ctx}/common/login_getHomeKRI.do",data,'html',function(data){
            $("#kripage").html(data);
        });
    }
}
//重置
function reset(){
   $('#queryForm').find('input').val('');
   $('#queryForm').find('span').text('请选择');
}

</script>
  <div class="pop_process" id="windKRIsearch">
    <div class="left">
        <a class="search active">搜索</a>
    </div>
    <div class="right">
        <a href="javascript:closePopWind();" class="close"></a>
        <form action="" id="queryForm">
           <input id="yearMonth" name="searchDto.statDate" value="" type="hidden">
        <ul>
            <li>
                <label>预警期次：</label>
                <div class="select select_3">
                    <span>请选择</span>
                     <input id="year" value="" type="hidden" >
                     <dl id="muYearid">
                    </dl>
                   
                </div>
                <div class="select select_3">
                    <span><%Date data=new Date();out.print(data.getMonth()); %> </span>
                    <input id="month" value=""   type="hidden">
                    <dl id="muMonthid">
                    </dl>
                </div>
            </li>
            <c:if test="${session.userLogin.comcode=='000000'}">
            <li>
                <label>归属机构：</label>
                <div class="select select_1">
                    <span>请选择</span>
                    <input name="searchDto.comCode"  type="hidden"/>
                    <dl id="comCode">
                    </dl>
                </div> 
            </li>
            </c:if>
            <li class="press_button" style="position:absolute;bottom:35px">
                <a href="javascript:query();" class="query">查 询</a>
                <a href="javascript:reset();" class="reset">重 置</a>
            </li>
        </ul>
        </form>
    </div>
  </div> 
