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
    asy_Ajax("${ctx}/jsp/comment/windSearchComment.jsp",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
	   	 $('#popWindow').html(data);
	});  
}
//--新增按钮
function add(){
	asy_Ajax("${ctx}/jsp/comment/commentAdd.jsp",{},'html',function(data){
		 $("#content").html(data);
	});
}
//--编辑按钮
function editor(commentid){
	var data={'searchDto.doing':"editor",'searchDto.commentid':commentid};
    asy_Ajax("${ctx}/comment/comment_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
}
//--发布按钮
function publish(commentid){
	var data={'searchDto.doing':"publish",'searchDto.commentid':commentid};
    asy_Ajax("${ctx}/comment/comment_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
	
}
//--查看按钮
function check(commentid){
	var data={'searchDto.doing':"check",'searchDto.commentid':commentid};
    asy_Ajax("${ctx}/comment/comment_check.do",data,'html',function(data){
    	$("#content").html(data);
	});
}
//--删除按钮
function del(commentid){
    if (confirm("是否确认删除?")) {
		  asy_Ajax("${ctx}/comment/comment_delete.do",{'appCommentBaseDto.commentid':commentid},'html',function(data){
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
				   		<td style="width:10%">评论编号</td>
						<td style="width:20%;">评论用户</td>
						<td style="width:5%">用户昵称</td>
						<td style="width:5%">业务ID</td>
						<td style="width:5%">模块</td>
						<td style="width:5%">状态</td>
						<td style="width:15%">操作</td>
					</tr>
				</thead>
			</table>
		</div>
		<table class="form_table">
			<thead>
				   <tr>
				   		<td style="width:15%">评论编号</td>
						<td style="width:5%;">评论用户</td>
						<td style="width:10%">用户昵称</td>
						<td style="width:15%">业务ID</td>
						<td style="width:8%">模块</td>
						<td style="width:5%">状态</td>
						<td style="width:15%">操作</td>
					</tr>
			</thead>
			<s:iterator value="appCommentBaseDtos" var="appCommentBaseDto" status="status1">
				<tr>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appCommentBaseDto.commentid" /> </td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appCommentBaseDto.concerneduserid" /></td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appCommentBaseDto.concernednickname" /></td>
					   <td style="word-break:break-all;text-align:left;padding:0px 8px"><s:property  value="#appCommentBaseDto.busiid" /></td>
					   <td>
						   <s:if test="#appCommentBaseDto.modular==1">看图说话</s:if>
						   <s:if test="#appCommentBaseDto.modular==2">听听画画</s:if>  
						   <s:if test="#appCommentBaseDto.modular==3">自说自话</s:if>
					   </td>
					   <td>
						   <s:if test="#appCommentBaseDto.status==0">无效</s:if>
						   <s:if test="#appCommentBaseDto.status==1">有效</s:if>  
					   </td>
					<td class="operate">
					    <a href="javascript:check('${commentid}')">查看</a>
					    <s:if test="#session.userLogin.deppositioncode=='DP0000004'">
					    <span class="gap">|</span>
					    <!--<a href="javascript:publish('${commentid}')">发布</a><span class="gap">|</span>
					    --><a href="javascript:editor('${commentid}')">编辑</a><span class="gap">|</span>
					    <a href="javascript:del('${commentid}')">刪除</a>
					    </s:if>
					</td>
				</tr>
			</s:iterator>
		</table>
		<div class="page">
              <swtag:paginator url="${ctx}/comment/comment_getList.do"  showTotal="true" showAllPages="true"  strUnit="条记录" ></swtag:paginator>
         </div>
</div>