<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/page" prefix="swtag"%>
<!--虚拟部门管理 -->

<div><!--存放js-->
<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript">
headerFixed();//表格表头固定
//--查询页面
function searchPage(){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/newrisk/jsp/sysconfig/departmentvir/windSearchDepartVir.jsp",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
	   	 $('#popWindow').html(data);
	});
}
//--查看
function check(newdepcode){
	$('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/sysconfig/depManage_checkFictiDepForPage.do",{'searchDto.newDepCode':newdepcode},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'></div>");
	   	 $('#popWindow').html(data);
	});
}
//--配置
function config(newdepcode){
	$('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/sysconfig/depManage_configureFictiDepForPage.do",{'searchDto.newDepCode':newdepcode},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'></div>");
	   	 $('#popWindow').html(data);
	});
}
//--编辑
function edit(newdepcode){
	$('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/sysconfig/depManage_editForPageVir.do",{'searchDto.newDepCode':newdepcode},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'></div>");
	   	 $('#popWindow').html(data);
	});
}
//--新增
function add(){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/sysconfig/depManage_editForPageVir.do",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'></div>");
	   	 $('#popWindow').html(data);
	});
}
//--删除
function del(newdepcode){
	if (confirm("是否确认删除?")) {
    asy_Ajax("${ctx}/sysconfig/depManage_delVir.do",{'searchDto.newDepCode':newdepcode},'html',function(data){
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
					<th>&nbsp;&nbsp;虚拟部门表</th>
					<th width="6.3%"><div><a href="javascript:searchPage()" title="搜索" class="search"></a></div></th>
					<s:if test="#session.userLogin.comcode==000000">
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
                        <td style="width:10%">机构名称</td>
                        <td style="width:10%">实体部门名称 </td>
                        <td style="width:5%">状态</td>
                        <td style="width:10%">操作</td>
					</tr>
				</thead>
			</table>
		</div>
		<table class="form_table">
			<thead>
				   <tr>
						<td style="width:5%">序号</td>
						<td style="width:10%">机构名称</td>
						<td style="width:10%">实体部门名称 </td>
						<td style="width:5%">状态</td>
						<td style="width:10%">操作</td>
					</tr>
			</thead>
			<s:iterator value="ccDepartmentDtos" var="ccDepartmentDto" status="status" >
				<tr>
					<td>${status.index+1 }</td>
					<td>${ccDepartmentDto.comName}</td>
					<td style="padding:0px 8px;text-align:left">${ccDepartmentDto.depname }</td>
					<td>
	                    <s:if test="#ccDepartmentDto.validstate==1">使用</s:if>
	                    <s:else>停用</s:else>
	                </td>
					<td class="operate">
					    <a href="javascript:check('${ccDepartmentDto.newdepcode }')">查看</a><span class="gap">|</span>
					    <a href="javascript:edit('${ccDepartmentDto.newdepcode }')">修改</a><span class="gap">|</span>
					    <a href="javascript:config('${ccDepartmentDto.newdepcode }')">配置</a><span class="gap">|</span>
					    <a href="javascript:del('${ccDepartmentDto.newdepcode }')">删除</a>
					</td>
				</tr>
			</s:iterator>
		</table>
		<div class="page">
              <swtag:paginator url="${ctx}/sysconfig/depManage_depVirList.do"  showTotal="true" showAllPages="false"  strUnit="条记录" ></swtag:paginator>
         </div>
</div>