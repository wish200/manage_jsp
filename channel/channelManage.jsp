<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/page" prefix="swtag"%>
<!--信息管理 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript">
headerFixed();//表格表头固定
var returnUrlNotice='${searchDto.returnUrl}';
//--查询页面
function searchPage(){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/jsp/channel/windSearchChannel.jsp",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
	   	 $('#popWindow').html(data);
	});  
}
//--新增按钮
function add(){
	asy_Ajax("${ctx}/jsp/channel/channelAdd.jsp",{},'html',function(data){
		 $("#content").html(data);
	});
}
//--编辑按钮
function editor(channelid){
	var data={'searchDto.doing':"editor",'searchDto.channelid':channelid};
    asy_Ajax("${ctx}/channel/channel_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
}
//--发布按钮
function publish(channelid){
	var data={'searchDto.doing':"publish",'searchDto.channelid':channelid};
    asy_Ajax("${ctx}/channel/channel_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
	
}
//--查看按钮
function check(channelid){
	var data={'searchDto.doing':"check",'searchDto.channelid':channelid};
    asy_Ajax("${ctx}/channel/channel_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
}
//--删除按钮
function del(channelid){
    if (confirm("是否确认删除?")) {
		  asy_Ajax("${ctx}/channel/channel_delete.do",{'appChannelBaseDto.channelid':channelid},'html',function(data){
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
					<th>&nbsp;&nbsp;微听列表</th>
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
						<td style="width:5%">序号</td>
						<td style="width:10%">电台编号</td>
						<td style="width:20%;">电台名称</td>
						<td style="width:10%">节目数量</td>
						<td style="width:5%">状态</td>
						<td style="width:5%">操作</td>
				   </tr>
				</thead>
			</table>
		</div>
		<table class="form_table">
			<thead>
				   <tr>
				   		<td style="width:5%">序号</td>
						<td style="width:10%">电台编号</td>
						<td style="width:20%;">电台名称</td>
						<td style="width:5%">节目数量</td>
						<td style="width:5%">状态</td>
						<td style="width:15%">操作</td>
					</tr>
			</thead>
			<s:iterator value="appChannelBaseDtos" var="appChannelBaseDto" status="status1">
				<tr>
					   <td>${status1.index+1 }</td>
					   
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appChannelBaseDto.channelid" /> </td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appChannelBaseDto.channelname" /></td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appChannelBaseDto.programcnt" /></td>
					   <td>
						   <s:if test="#appChannelBaseDto.status==0">无效</s:if>
						   <s:if test="#appChannelBaseDto.status==1">有效</s:if>  
					   </td>
					<td class="operate">
					    <a href="javascript:check('${channelid}')">查看</a>
					    <s:if test="#session.userLogin.deppositioncode=='DP0000004'">
					    <span class="gap">|</span>
					    <!--<a href="javascript:publish('${channelid}')">发布</a><span class="gap">|</span>
					    --><a href="javascript:editor('${channelid}')">编辑</a><span class="gap">|</span>
					    <a href="javascript:del('${channelid}')">刪除</a>
					    </s:if>
					</td>
				</tr>
			</s:iterator>
		</table>
		<div class="page">
              <swtag:paginator url="${ctx}/channel/channel_getList.do"  showTotal="true" showAllPages="true"  strUnit="条记录" ></swtag:paginator>
         </div>
</div>