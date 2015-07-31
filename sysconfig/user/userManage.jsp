<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/page" prefix="swtag"%>

<!--人员信息管理 -->

<div>
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript">
headerFixed();//表格表头固定
//--添加人员
function addUser(){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/newrisk/jsp/sysconfig/user/windAddUser.jsp","",'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'></div>");
	   	 $('#popWindow').html(data);
	});
}
//--修改用户
function editorUser(usercode){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/sysconfig/userManage_updateUserForPage.do",{"ccUserDto.usercode":usercode},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'></div>");
	   	 $('#popWindow').html(data);
	});
}
//--删除用户
function deleteUser(usercode) {
	if (confirm("是否确认删除?")) {
		 asy_Ajax("${ctx}/sysconfig/userManage_deleteUser.do",{'ccUserDto.usercode':usercode},'html',function(data){
				  $("#content").html(data);
		 });
	}
}
//--查询页面
function searchPage(){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/newrisk/jsp/sysconfig/user/windSearchUser.jsp",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
	   	 $('#popWindow').html(data);
	});
}
</script>
</div>

	<div class="report_form">
		<div id="form_tit" class="form_tit">
			<table>
				<tr>
					<th>&nbsp;&nbsp;人员信息表</th>
					<th width="6.3%"><div><a href="javascript:searchPage()" title="搜索" class="search"></a></div></th>
					<th width="6.3%"><div><a href="javascript:addUser()" title="新增" class="plus"></a></div></th>
				</tr>
			</table>
		</div>


		<div id="form_thead">
			<table class="form_table">
				<thead>
					<tr>
						<td style="width:5%">序号</td>
                        <td style="width:5%">人员代码</td>
                        <td style="width:8%">人员名称</td>
                        <td style="width:5%">归属机构</td>
                        <td style="width:12%">归属部门</td>
                        <td style="width:12%">部门岗位</td>
                        <td style="width:5%">状态</td>
                        <td style="width:8%">登陆次数</td>
                        <td style="width:10%">操作</td>  
					</tr>
				</thead>
			</table>
		</div>
		<table class="form_table">
			<thead>
				   <tr>
						<td style="width:5%">序号</td>
						<td style="width:5%">人员代码</td>
						<td style="width:8%">人员名称</td>
						<td style="width:5%">归属机构</td>
						<td style="width:12%">归属部门</td>
						<td style="width:12%">部门岗位</td>
						<td style="width:5%">状态</td>
						<td style="width:8%">登陆次数</td>
						<td style="width:10%">操作</td>
				   </tr>
			</thead>
			<s:iterator value="ccUserDtoList" var="ccUserDto" status="status">
				<tr>
					<td>${status.index+1 }</td>
					<td>${ccUserDto.usercode }</td>
				    <td style="padding:0px 8px;text-align:left">${ccUserDto.username }</td>
					<td>${ccUserDto.cdCompanyBaseDto.comname }</td>
					<td style="padding:0px 8px;text-align:left">${ccUserDto.ccDepartmentBaseDto.depname }</td>
					<td style="padding:0px 8px;text-align:left">${ccUserDto.ccDepPositionBaseDto.deppositionname }</td>
					<td><s:if test="#ccUserDto.validstatus==1">使用中</s:if> <s:else>已停用</s:else></td>
					<td>${ccUserDto.logintimes }</td>
					<td class="operate">
					    <a href="javascript:editorUser('${ccUserDto.usercode }')">编辑</a><span class="gap">|</span>
					    <a href="javascript:deleteUser('${ccUserDto.usercode }')">删除</a>
					</td>
				</tr>
			</s:iterator>
		</table>
		<div class="page">
              <swtag:paginator url="${ctx}/sysconfig/userManage_queryUserList.do"  showTotal="true" showAllPages="false"  strUnit="条记录" ></swtag:paginator>
         </div>
	</div>
