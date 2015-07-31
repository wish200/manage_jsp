<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--部门岗位管理 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript">
headerFixed();//表格表头固定
//--查询页面
function searchPage(){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/newrisk/jsp/sysconfig/depposition/windSearchDeppos.jsp",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
	   	 $('#popWindow').html(data);
	});  
}
//--配置按钮
function config(depPositionCode){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/sysconfig/depPosMan_configureForPage.do?searchDto.depPositionCode="+depPositionCode,{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'></div>");
	   	 $('#popWindow').html(data);
	});
}

//--查看按钮
function check(depPositionCode){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/sysconfig/depPosMan_checkConfigureForPage.do?searchDto.depPositionCode="+depPositionCode,{},'html',function(data){
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
					<th>&nbsp;&nbsp;部门岗位表</th>
					<th width="6.3%"><div><a href="javascript:searchPage()" title="搜索" class="search"></a></div></th>
				</tr>
			</table>
		</div>


		<div id="form_thead">
			<table class="form_table">
				<thead>
					<tr>
						<td style="width:10%">序号</td>
						<td style="width:10%">岗位名称</td>
						<td style="width:10%">状态</td>
						<td style="width:10%">操作</td>
					</tr>
				</thead>
			</table>
		</div>
		<table class="form_table">
			<thead>
				  <tr>
						<td style="width:5%">序号</td>
						<td style="width:10%">岗位名称</td>
						<td style="width:5%">状态</td>
						<td style="width:10%">操作</td>
					</tr>
			</thead>
			<s:iterator value="ccDepPositionDtoList" var="ccDepPositionDto" status="status">
				<tr>
					<td>${status.index+1 }</td>
					<td style="padding:0px 8px;text-align:left">${ccDepPositionDto.deppositionname }</td>
					<td>
	                    <s:if test="#ccDepPositionDto.validstate==1">使用</s:if>
	                    <s:else>停用</s:else>
	                </td>
					<td class="operate">
					    <a href="javascript:check('${ccDepPositionDto.deppositioncode }')">查看</a><span class="gap">|</span>
					    <a href="javascript:config('${ccDepPositionDto.deppositioncode }')">配置</a>
					</td>
				</tr>
			</s:iterator>
		</table>
</div>