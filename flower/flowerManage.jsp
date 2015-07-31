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
    asy_Ajax("${ctx}/jsp/flower/windSearchFlower.jsp",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
	   	 $('#popWindow').html(data);
	});  
}
//--新增按钮
function add(){
	asy_Ajax("${ctx}/jsp/flower/flowerAdd.jsp",{},'html',function(data){
		 $("#content").html(data);
	});
}
//--编辑按钮
function editor(busiid,userid){
	var data={'searchDto.doing':"editor",'searchDto.busiid':busiid,'searchDto.userid':userid};
    asy_Ajax("${ctx}/flower/flower_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
}
//--发布按钮
function publish(busiid,userid){
	var data={'searchDto.doing':"publish",'searchDto.busiid':busiid,'searchDto.userid':userid};
    asy_Ajax("${ctx}/flower/flower_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
	
}
//--查看按钮
function check(busiid,userid){
	var data={'searchDto.doing':"check",'searchDto.busiid':busiid,'searchDto.userid':userid};
    asy_Ajax("${ctx}/flower/flower_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
}
//--删除按钮
function del(busiid,userid){
    if (confirm("是否确认删除?")) {
		  asy_Ajax("${ctx}/flower/flower_delete.do",{'appFlowerBaseDto.busiid':busiid,'searchDto.userid':userid},'html',function(data){
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
					<th>&nbsp;&nbsp;小红花列表</th>
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
				   		<td style="width:15%">业务ID</td>
				   		<td style="width:10%">用户ID</td>
				   		<td style="width:5%">小红花</td>
						<td style="width:10%;">评论时间</td> 
						<td style="width:15%">操作</td>
					</tr>
				</thead>
			</table>
		</div>
		<table class="form_table">
			<thead>
				   <tr>
				   		<td style="width:5%">序号</td>
				   		<td style="width:15%">业务ID</td>
				   		<td style="width:10%">用户ID</td>
				   		<td style="width:5%">小红花</td>
						<td style="width:10%;">评论时间</td> 
						<td style="width:15%">操作</td>
					</tr>
			</thead>
			<s:iterator value="appFlowerBaseDtos" var="appFlowerBaseDto" status="status1">
				<tr>
						<td>${status1.index+1 }</td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appFlowerBaseDto.busiid" /> </td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appFlowerBaseDto.userid" /></td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appFlowerBaseDto.flowercnt" /></td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appFlowerBaseDto.commentime" /></td>
					   
					<td class="operate">
					    <a href="javascript:check('${busiid}','${userid}')">查看</a>
					    <s:if test="#session.userLogin.deppositioncode=='DP0000004'">
					    <span class="gap">|</span>
					    <!--<a href="javascript:publish('${flowerid}')">发布</a><span class="gap">|</span>
					    --><a href="javascript:editor('${busiid}','${userid}')">编辑</a><span class="gap">|</span>
					    <a href="javascript:del('${busiid}','${userid}')">刪除</a>
					    </s:if>
					</td>
				</tr>
			</s:iterator>
		</table>
		<div class="page">
              <swtag:paginator url="${ctx}/flower/flower_getList.do"  showTotal="true" showAllPages="true"  strUnit="条记录" ></swtag:paginator>
         </div>
</div>