<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib prefix="s" uri="/struts-tags"%>
 <div>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="${ctx}/newrisk/js/common/selectTime.js"></script>
<script type="text/javascript" src="${ctx}/newrisk/js/introduce/jquery.form.min.js"></script>
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
selectOption();
addTime(5,"#muYearid","#muMonthid","");
//查询
function query(){
        $('#popWindow').hide();
         publicURL="${ctx}/sysconfig/emailTemplate_queryEmailTleForList.do?searchDto.templatename="
         +$("input[name='searchDto.templatename']").val()
		+"&searchDto.moduleid="+$("input[name='searchDto.moduleid']").val()
		+"&searchDto.validstate="+$("input[name='searchDto.validstate']").val();//返回地址
        $("#from2").ajaxSubmit({
                       type: "post",  
                       url: "${ctx}/sysconfig/emailTemplate_queryEmailTleForList.do",  
                       success: function(data){
                         $("#content").html(data);
                          closePopWind();
                       },  
                       error: function(XmlHttpRequest, textStatus, errorThrown){  
                          alert( "系统错误");  
                       }  
       });
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
function closeDiv(){
     $('#popWindow').remove();
	 $('.black_overlay').remove();
}
</script>
</div>

  <div class="pop_process" id="windKRIsearch">
    <div class="left">
        <a class="search active">搜索</a>
    </div>
    <div class="right">
        <a href="javascript:closeDiv();" class="close"></a>
        <form id="from2" action="">
        <ul>
              <li>
                <label>模板名称：</label>
                <span class="input_1">
                   <input  name="searchDto.templatename" type="text" />
                </span>
            </li>   
            <li>
                <label>所属功能模板：</label>
                <div class="select select_1">
                    <span>请选择</span>
                     <input  name="searchDto.moduleid" value="" type="hidden" >
                     <dl>
                       
                        <dd value="T0100000" >问题推送与整改</dd>
                        <s:if test='#session.userLogin.comcode=="000000"'>
                        <dd value="T0200000" >数据采集与报送</dd>
                        </s:if>
                    </dl>
                   
                </div>
            </li>
            
            <li>
                <label>使用状态：</label>
                <div class="select select_1">
                    <span>请选择</span>
                     <input  name="searchDto.validstate" value="" type="hidden" >
                     <dl>
                        <dd value="" >请选择</dd>
                        <dd value="1" >使用</dd>
                        <dd value="0" >停用</dd>
                    </dl>
                   
                </div>
            </li>
            <li class="press_button" style="position:absolute;bottom:35px">
                <a href="javascript:query();" class="query">查 询</a>
                <a href="javascript:reset();" class="reset">重 置</a>
            </li>
        </ul>
        </form>
    </div>
  </div> 
