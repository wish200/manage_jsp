<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 

<!--数据导入页面(弹出窗口)-->
<div class="pop_process"><!--存放js-->
<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/newrisk/js/introduce/jquery.form.min.js"></script>
<!--以下页面的js操作-->
<script type="text/javascript">
var newdepcode="${session.userLogin.newdepcode}";
$(".black_overlay").css("height",$(document).height());
<%--模拟下拉列表框--%>
function addTimeOW(yearNums, muYearid, muMonthid, monthType) {
    var sysdate=sysDate;//session 服务器 上一个月份
    var yearStr=sysdate.substring(0,4);//年份
    var monthStr=sysdate.substring(4,6);//月份
    $(muYearid).empty();//年份清空
    $(muMonthid).empty();//月份清空
    //year:
    var resultYearStr="";
    for ( var i = parseInt(yearStr); i >= 2012; i--) {
        resultYearStr+='<dd value="'+i+'" >' + i + '</dd>';
    }$(muYearid).append(resultYearStr);
    
    var resultMonthStr="";
    for ( var i = 1; i <=12; i++) {
        if(i<10){
            resultMonthStr+='<dd value="0'+i+'" >' + "0"+i + '</dd>';
        }else{
            resultMonthStr+='<dd value="'+i+'" >' + i + '</dd>';
        }
        
    }$(muMonthid).append(resultMonthStr);
    /*显示年份和月份*/
    $(muYearid).prev().prev('span').html(yearStr);
    $(muMonthid).prev().prev('span').html(monthStr);
    $(muYearid).prev('input').val(yearStr);
    $(muMonthid).prev('input').val(monthStr);
}
addTimeOW(5,"#muYearid","#muMonthid","");

//选择时间的时候变换下拉菜单
$(".select span").click(function(){
        var thisinput=$(this);
        var thisInputvar=$(this).next("input");
        var thisul=$(this).parent().find("dl");
        if(thisul.css("display")=="none"){
            if(thisul.height()>150){thisul.css({height:"100","overflow-y":"scroll"});};
            thisul.fadeIn("100");
            thisul.parent().css("z-index","9999");
            thisul.hover(function(){},function(){thisul.fadeOut("100");thisul.parent().css("z-index","2");});
            thisinput.parent().hover(function(){},function(){thisul.fadeOut("100");thisul.parent().css("z-index","2");});
            thisul.find("dd").click(function(){
                thisinput.text($(this).text());
                 data=$(this).attr('value');
                thisInputvar.val(data);
                thisul.fadeOut("100");
                 thisul.find("dd").unbind('click'); 
              });
            }
        else{
            thisul.fadeOut("fast");
            }
    });
//导入数据
function inportBtn(){
  var ok=haveData("year","请选择报送期次")&&haveData("month","请选择报送期次");  
  if(ok){
     $('#yearMoth').val($('#year').val()+$('#month').val());//初始化报送期次
     var _statDate=$('#yearMoth').val();
       asy_Ajax("${ctx}/sysconfig/emailSendView_getEmail.do",{'searchDto.templatenum':templatenum,'searchDto.templatecatno':templatecatno,'searchDto.statDate':_statDate},'html',function(data){
              closePopWind();
              $("#content").html(data);
       }); 
  }
}
//--重置
function Reset(){
    $('#queryForm').find('input').val('');
    $('#queryForm').find('span[class!=input_1]').text('请选择');
}
</script>

    <div class="left">
        <a class="search active">搜索</a>
    </div>
    <div class="right">
        <a href="javascript:searchDiv();" class="close"></a>
        <form id="queryForm" action="" method="post">
        <ul>
           <li   style="margin-top: 50px">
                <label>报送期次：</label>
                 <input style="display: none"  id="yearMoth" name="searchDto.statDate">
                <div class="select select_3">
                    <span>请选择</span>
                     <input id="year" value="" type="hidden" >
                     <dl id="muYearid">
                    </dl>
                   
                </div>
                <div class="select select_3">
                    <span>请选择</span>
                    <input id="month" value="" type="hidden">
                    <dl id="muMonthid">
                    </dl>
                </div>
            </li>
            <li class="press_button" style="position:absolute;bottom:35px">
                <a href="javascript:inportBtn();" class="query">查询</a>
                <a href="javascript:Reset();" class="reset">重 置</a>
            </li>
        </ul>
        </form>
    </div>
  </div>
  <%-- <s:if test='#session.userLogin.newdepcode=="D5001011Y"'>  --%>
      <div style="display: none">
               <ul>
                 <dl id="report">
                        <dd value="">请选择</dd>
                        <dd value="indexGroup">指标展示及集团</dd>
                        <dd value="class">分类监管展示</dd>
                    </dl>
                 <dl  id="monthReport">
                     
                </dl>
                 <dl  id="quarReport">
                       <dd  value="G_REPT003">投资业务数据表</dd>
                       <dd  value="G_REPT009">存款信用评级表</dd>
                       <dd  value="G_REPT010">投资损益数据表</dd>
                       <dd  value="G_REPT007">分险种分保业务数据表</dd>
                 </dl>
            </ul>
      </div> 
 <%--  </s:if>  --%>
