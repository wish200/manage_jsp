<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/page" prefix="swtag"%>
<!--实体部门管理 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript">
headerFixed();//表格表头固定
//--查询页面
function searchPage(){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/newrisk/jsp/sysconfig/department/windSearchDepart.jsp",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
	   	 $('#popWindow').html(data);
	});
}
//--配置险种
function classs(newdepcode){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/sysconfig/depManage_configureClassForPage.do?searchDto.newDepCode="+newdepcode,{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'></div>");
	   	 $('#popWindow').html(data);
	});
}

//--配置渠道
function channle(newdepcode){
     $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/sysconfig/depManage_configureChannelForPage.do?searchDto.newDepCode="+newdepcode,{},'html',function(data){
	   	$('body').append("<div id='popWindow'></div>");
	   	$('body').append("<div class='black_overlay'></div>");
	   	$('#popWindow').html(data);
	});
}
</script>
</div>

<div class="report_form">
		<div id="form_tit" class="form_tit">
			<table>
				<tr>
					<th>&nbsp;&nbsp;实体部门表</th>
					<th width="6.3%"><div><a href="javascript:searchPage()" title="搜索" class="search"></a></div></th>
				</tr>
			</table>
		</div>


		<div id="form_thead">
			<table class="form_table">
				<thead>
					<tr>
						<td style="width:5%">序号</td>
                        <td style="width:10%">机构名称 </td>
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
						<td style="width:10%">机构名称 </td>
						<td style="width:10%">实体部门名称 </td>
						<td style="width:5%">状态</td>
						<td style="width:10%">操作</td>
					</tr>
			</thead>
			<s:iterator value="ccDepartmentDtos" var="ccDepartmentDto" status="status" >
				<tr>
					<td>${status.index+1 }</td>
					<td>${ ccDepartmentDto.comName}</td>
					<td style="padding:0px 8px;text-align:left">${ccDepartmentDto.depname }</td>
					<td>
	                    <s:if test="#ccDepartmentDto.validstate==1">使用</s:if>
	                    <s:else>停用</s:else>
	                </td>
					<td class="operate">
					    <a href="javascript:classs('${ccDepartmentDto.newdepcode }')">配置险种</a>
<!-- 					    <a href="javascript:channle('${ccDepartmentDto.newdepcode }')">配置渠道</a> -->
					</td> 
				</tr>
			</s:iterator>
		</table>
		<div class="page">
              <swtag:paginator url="${ctx}/sysconfig/depManage_depList.do"  showTotal="true" showAllPages="false"  strUnit="条记录" ></swtag:paginator>
         </div>
</div>