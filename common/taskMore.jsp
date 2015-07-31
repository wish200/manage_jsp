<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib uri="/page" prefix="swtag"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@taglib prefix="s" uri="/struts-tags"%>
<div>
    <!--主页面--指标值表格-->
<script type="text/javascript">
//表头固定
headerFixed();
//查询按钮
function searchKRI(){
    closePopWind();
    asy_Ajax("${ctx}/newrisk/jsp/common/windKRIsearch.jsp","","html",function(data){
        $("body").append("<div id='popWindow'><div>");
        $("#popWindow").append(data);
    });
}
//添加收藏
function divLike(data,indexCode){
    var _class=$(data).attr("class");
    var _ajaxData={'ccDivBaseDto.indexcode':indexCode};
    if(_class=='like-no'){
        if(confirm("是否收藏?")){
             asy_Ajax('${ctx}/monitorwarn/index_addDiv.do',_ajaxData,'html',function(){
                $(data).removeClass('like-no'); 
                $(data).addClass('like');
             });
        }
    }else{
         if(confirm("是否取消收藏?")){
             asy_Ajax('${ctx}/monitorwarn/index_removeDiv.do',_ajaxData,'html',function(){
                $(data).removeClass('like');
                $(data).addClass('like-no'); 
             });
         }
    }
}
//弹出附表对话框
function alertIndexAtt(data,indexName){
     closePopWind();
    asy_Ajax("${ctx}/newrisk/jsp/monitorwarn/windIndexArrt.jsp",'',"html",function(ajaxData){
        $("body").append("<div id='popWindow'><div>");
        $("#popWindow").append(ajaxData);
        $("#schedule_list").html($(data).next('ul').html());
         $("#title").html("("+indexName+")附表列表");
    });  
}
//邮件发送
function sendEmail(){
    var statDate='${searchDto.statDate}';
    alert("邮件发送成功！");
    asy_Ajax('${ctx}/monitorwarn/index_sendEmail.do',{'searchDto.statDate':statDate},'html',function(){
    });
} 
//返回首页
function returnUrl(){
      window.location='${ctx}/common/login_login.do';
}
</script >
</div>
  <div class="report_form">
                    <div id="form_tit" class="form_tit">
                        <table>
                          <tr>
                            <th>&nbsp;&nbsp;我的任务</th>
                                 <th width="6.3%"><div><a href="javascript:returnUrl();" class="arrow_left"></a></div></th>
                          </tr>
                        </table>
                    </div>
                    <div id="form_thead" >
                        <table class="form_table">
                          <thead >
                            <tr>
		                        <td width="5%">任务编号</td>
		                        <td width="10%">工作内容</td>
		                        <td width="10%">所属模块</td>
		                        <td width="10%">创建时间</td>
		                        <td width="10%">操作</td>
                          </tr>
                          </thead>
                      </table>
                    </div>
                    <table class="form_table">
                      <thead >
                        <tr>
                              <td width="5%">任务编号</td>
                              <td width="10%">工作内容</td>
                              <td width="10%">所属模块</td>
                              <td width="10%">创建时间</td>
                              <td width="10%">操作</td>
                      </tr>
                      </thead>
                    <s:iterator value="ccTaskDtoList" var="ccTaskDto" status="stat">
	                    <tr>
	                       <td>${stat.index+1}</td>
	                       <td style="padding:0px 8px;text-align:left">${taskcontent}</td>
	                       <td>${ccTaskModuleBaseDto.modulename }</td>
	                       <td><s:date name="%{createtime }" format="yyyy-MM-dd" /></td>
	                       <td>
	                        <s:if test="#ccTaskDto.taskstatus==0">
	                              <a href="javascript:Handle('${ccTaskModuleBaseDto.moduleurl }',
	                              '${ccTaskModuleBaseDto.moduleparm1 }','${taskparam1 }',
	                              '${ccTaskModuleBaseDto.moduleparm2 }','${taskparam2 }'
	                              )" style="color:red">去处理</a>
	                        </s:if>
	                        <s:else>
	                               <span style="color:black">已处理
	                               </span>
	                        </s:else>
	                       </td>
	                    </tr>
                    </s:iterator>
                  </table>
                  <div class="page">
                     <swtag:paginator url="${ctx}/sysconfig/mytask_list.do"  showTotal="true" showAllPages="false"  strUnit="条记录" ></swtag:paginator>
                 </div>
   </div> 
              
            