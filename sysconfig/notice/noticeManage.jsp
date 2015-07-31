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
    asy_Ajax("${ctx}/jsp/sysconfig/notice/windSearchNotice.jsp",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
	   	 $('#popWindow').html(data);
	});  
}
//--新增按钮
function add(){
	asy_Ajax("${ctx}/jsp/sysconfig/notice/noticeAdd.jsp",{},'html',function(data){
		 $("#content").html(data);
	});
}
//--编辑按钮
function editor(systemcode){
	var data={'searchDto.doing':"editor",'searchDto.systemcode':systemcode};
    asy_Ajax("${ctx}/sysconfig/sysPosMan_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
}
//--发布按钮
function publish(systemcode){
	var data={'searchDto.doing':"publish",'searchDto.systemcode':systemcode};
    asy_Ajax("${ctx}/sysconfig/sysPosMan_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
	
}
//--查看按钮
function check(systemcode){
	var data={'searchDto.doing':"check",'searchDto.systemcode':systemcode};
    asy_Ajax("${ctx}/sysconfig/sysPosMan_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
}
//--删除按钮
function del(systemcode){
    if (confirm("是否确认删除?")) {
		  asy_Ajax("${ctx}/sysconfig/sysPosMan_delete.do",{'ccSystemPostBaseDto.systemcode':systemcode},'html',function(data){
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
					<th>&nbsp;&nbsp;公告列表</th>
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
						<td style="width:5%">公告编号</td>
						<td style="width:20%;">公告概要</td>
						<td style="width:20%;">公告内容</td>
						<td style="width:10%">创建时间</td>
						<td style="width:10%">发布时间</td>
						<td style="width:10%">过期时间</td>
						<td style="width:5%">发布状态</td>
						<td style="width:5%">操作</td>
				   </tr>
				</thead>
			</table>
		</div>
		<table class="form_table">
			<thead>
				   <tr>
						<td style="width:5%">公告编号</td>
						<td style="width:15%;">公告概要</td>
						<td style="width:15%;">公告内容</td>
						<td style="width:8%">创建时间</td>
						<td style="width:8%">发布时间</td>
						<td style="width:8%">过期时间</td>
						<td style="width:5%">发布状态</td>
						<td style="width:25%">操作</td>
					</tr>
			</thead>
			<s:iterator value="ccSystemPostBaseDtos" var="ccSystemPostBaseDto" status="status">
				<tr>
					<td>${status.index+1 }</td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#ccSystemPostBaseDto.postdesc" /> </td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#ccSystemPostBaseDto.remark" /></td>
					   <td><s:date name="#ccSystemPostBaseDto.createdate" format="yyyy-MM-dd" /></td>
					   <td><s:date name="#ccSystemPostBaseDto.startdate" format="yyyy-MM-dd" /></td>
					   <td><s:date name="#ccSystemPostBaseDto.enddate" format="yyyy-MM-dd" /></td>
					   <td>
						   <s:if test="#ccSystemPostBaseDto.validstatus==0">待发布</s:if>
						   <s:if test="#ccSystemPostBaseDto.validstatus==1">发布中</s:if>
						   <s:if test="#ccSystemPostBaseDto.validstatus==2">已过期</s:if>    
					   </td>
					<td class="operate">
					    <a href="javascript:check('${systemcode}')">查看</a>
					    <s:if test="#session.userLogin.deppositioncode=='DP0000004'">
					    <span class="gap">|</span><a href="javascript:publish('${systemcode}')">发布</a><span class="gap">|</span>
					    <a href="javascript:editor('${systemcode}')">编辑</a><span class="gap">|</span>
					    <a href="javascript:del('${systemcode}')">刪除</a>
					    </s:if>
					</td>
				</tr>
			</s:iterator>
		</table>
		<div class="page">
              <swtag:paginator url="${ctx}/sysconfig/sysPosMan_getSystrmPoseList.do"  showTotal="true" showAllPages="true"  strUnit="条记录" ></swtag:paginator>
         </div>
</div>