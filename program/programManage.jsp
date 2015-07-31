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
    asy_Ajax("${ctx}/jsp/program/windSearchProgram.jsp",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
	   	 $('#popWindow').html(data);
	});  
}
//--新增按钮
function add(){
	asy_Ajax("${ctx}/jsp/program/programAdd.jsp",{},'html',function(data){
		 $("#content").html(data);
	});
}
//--编辑按钮
function editor(programid){
	var data={'searchDto.doing':"editor",'searchDto.programid':programid};
    asy_Ajax("${ctx}/program/program_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
}
//--发布按钮
function publish(programid){
	var data={'searchDto.doing':"publish",'searchDto.programid':programid};
    asy_Ajax("${ctx}/program/program_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
	
}
//--查看按钮
function check(programid){
	var data={'searchDto.doing':"check",'searchDto.programid':programid};
    asy_Ajax("${ctx}/program/program_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
}
//--删除按钮
function del(programid){
    if (confirm("是否确认删除?")) {
		  asy_Ajax("${ctx}/program/program_delete.do",{'appProgramBaseDto.programid':programid},'html',function(data){
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
					<th>&nbsp;&nbsp;节目列表</th>
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
						<td style="width:10%">节目编号</td>
						<td style="width:20%;">节目名称</td>
						<td style="width:10%">电台编号</td>
						<td style="width:10%">播放数</td>
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
						<td style="width:10%">节目编号</td>
						<td style="width:15%;">节目名称</td>
						<td style="width:10%">电台编号</td>
						<td style="width:10%">播放数</td>
						<td style="width:5%">状态</td>
						<td style="width:15%">操作</td>
					</tr>
			</thead>
			<s:iterator value="appProgramBaseDtos" var="appProgramBaseDto" status="status1">
				<tr>
					   <td>${status1.index+1 }</td>
					   
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appProgramBaseDto.programid" /> </td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appProgramBaseDto.programname" /></td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appProgramBaseDto.channelid" /></td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appProgramBaseDto.playcnt" /></td>
					   <td>
						   <s:if test="#appProgramBaseDto.status==0">无效</s:if>
						   <s:if test="#appProgramBaseDto.status==1">有效</s:if>  
					   </td>
					<td class="operate">
					    <a href="javascript:check('${programid}')">查看</a>
					    <s:if test="#session.userLogin.deppositioncode=='DP0000004'">
					    <span class="gap">|</span>
					    <!--<a href="javascript:publish('${programid}')">发布</a><span class="gap">|</span>
					    --><a href="javascript:editor('${programid}')">编辑</a><span class="gap">|</span>
					    <a href="javascript:del('${programid}')">刪除</a>
					    </s:if>
					</td>
				</tr>
			</s:iterator>
		</table>
		<div class="page">
              <swtag:paginator url="${ctx}/program/program_getList.do"  showTotal="true" showAllPages="true"  strUnit="条记录" ></swtag:paginator>
         </div>
</div>