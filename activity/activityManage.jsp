<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/page" prefix="swtag"%>
<!--公告信息管理 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript">
headerFixed();//表格表头固定
var returnUrlNotice='${searchDto.returnUrl}';
//--查询页面
function searchPage(){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/jsp/activity/windSearchActivity.jsp",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
	   	 $('#popWindow').html(data);
	});  
}
//--新增按钮
function add(){
	asy_Ajax("${ctx}/jsp/activity/activityAdd.jsp",{},'html',function(data){
		 $("#content").html(data);
	});
}
//--编辑按钮
function editor(activityid){
	var data={'searchDto.doing':"editor",'searchDto.activityid':activityid};
    asy_Ajax("${ctx}/activity/activity_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
}
//--发布按钮
function publish(activityid){
	var data={'searchDto.doing':"publish",'searchDto.activityid':activityid};
    asy_Ajax("${ctx}/activity/activity_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
	
}
//--查看按钮
function check(activityid){
	var data={'searchDto.doing':"check",'searchDto.activityid':activityid};
    asy_Ajax("${ctx}/activity/activity_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
}
//--删除按钮
function del(activityid){
    if (confirm("是否确认删除?")) {
		  asy_Ajax("${ctx}/activity/activity_delete.do",{'appActivityBaseDto.activityid':activityid},'html',function(data){
			  $("#content").html(data);
		  });
	 }
}
</script>
</div>

<div class="report_form">
		<div id="form_tit" class="form_tit">
			<table>
				<tr>
					<th>&nbsp;&nbsp;活动列表</th>
					<%--<s:if test="#request.searchDto.returnUrl!=null">
					     <th width="6.3%"><div><a href="javascript:returnUrl();" title="返回" class="arrow_left"></a></div></th>
					</s:if>
					--%><th width="6.3%"><div><a href="javascript:searchPage()" title="搜索" class="search"></a></div></th>
					 <s:if test="#session.userLogin.deppositioncode=='DP0000004'">
 					  <th width="6.3%"><div><a href="javascript:add()" title="新增" class="plus"></a></div></th> 
					</s:if>
				</tr>
			</table>
		</div>


		<div id="form_thead">
			<table class="form_table">
				<thead>
					<tr>
						<td style="width:10%">活动编号</td>
						<td style="width:20%;">活动名称</td>
						<td style="width:5%;">活动类型</td>
						<td style="width:10%">活动时间</td>
						<td style="width:5%">发布状态</td>
						<td style="width:5%">操作</td>
				   </tr>
				</thead>
			</table>
		</div>
		<table class="form_table">
			<thead>
				   <tr>
						<td style="width:10%">活动编号</td>
						<td style="width:20%;">活动名称</td>
						<td style="width:5%;">活动类型</td>
						<td style="width:10%">活动时间</td>
						<td style="width:5%">发布状态</td>
						<td style="width:25%">操作</td>
					</tr>
			</thead>
			<s:iterator value="appActivityBaseDtos" var="appActivityBaseDto" status="status">
				<tr>
					<!--<td>${status.index+1 }</td>
					   -->
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appActivityBaseDto.activityid" /> </td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appActivityBaseDto.activityname" /></td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px">
					   	
					   <s:if test="#appActivityBaseDto.activitytype==1">
					   	一起玩
					   </s:if> 
					   <s:elseif test="#appActivityBaseDto.activitytype==2">
					            小朋友圈
					   </s:elseif>
					           
					   
					   </td>
					   
					   <td><s:date name="#appActivityBaseDto.activitytime"/></td>
					   <td>
						   <s:if test="#appActivityBaseDto.validstatus==0">无效</s:if>
						   <s:if test="#appActivityBaseDto.validstatus==1">有效</s:if>  
					   </td>
					<td class="operate">
					    <a href="javascript:check('${activityid}')">查看</a>
					    <s:if test="#session.userLogin.deppositioncode=='DP0000004'">
					    <span class="gap">|</span>
					    <!--<a href="javascript:publish('${activityid}')">发布</a><span class="gap">|</span>
					    --><a href="javascript:editor('${activityid}')">编辑</a><span class="gap">|</span>
					    <a href="javascript:del('${activityid}')">刪除</a>
					    </s:if>
					</td>
				</tr>
			</s:iterator>
		</table>
		<div class="page">
              <swtag:paginator url="${ctx}/activity/activity_getList.do"  showTotal="true" showAllPages="true"  strUnit="条记录" ></swtag:paginator>
         </div>
</div>