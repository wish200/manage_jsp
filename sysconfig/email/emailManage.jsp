<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/page" prefix="swtag"%>
<!--邮件模板管理 -->

<div><!--存放js-->
<%@include file="/jsp/common/taglibs.jsp"%>
<script type="text/javascript">
headerFixed();//表格表头固定
//--查询页面
function searchForPage(){
	$('#popWindow').remove();
	$('.black_overlay').remove();
    asy_Ajax("${ctx}/newrisk/jsp/sysconfig/email/windEmailSearch.jsp",{},'html',function(data){
    	 $('body').append("<div id='popWindow'></div>");
		 $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
		 $("#popWindow").html(data);
	});  
}
//--新增按钮
function add(){
	asy_Ajax("${ctx }/sysconfig/emailTemplate_insertEmailTleForPage.do","",'html',function(data){
		 $("#content").html(data);
<%--		 document.getElementById("content").innerHTML=data;--%>
	});
}
//--编辑按钮
function editor(templatenum){
	var data={'searchDto.templatenum':templatenum};
	asy_Ajax("${ctx}/sysconfig/emailTemplate_queryEmailTle.do",data,'html',function(data){
		 $("#content").html(data);
	});
}
//--查看按钮
function check(templatenum){
	var data={'searchDto.templatenum':templatenum,'searchDto.doing':"query"};
    asy_Ajax("${ctx}/sysconfig/emailTemplate_queryEmailTle.do",data,'html',function(data){
	     $("#content").html(data);
    });
}
//--删除按钮
function del(templatenum){
	if (confirm("是否确认删除?")) {
		  asy_Ajax("${ctx}/sysconfig/emailTemplate_deleteEmailTle.do",{'searchDto.templatenum':templatenum},'html',function(data){
			  $("#content").html(data);
		  });
	 }
}
var dianJis=1;
function sendEmail(templatenum,templatecatno){
    if(dianJis==1){
      dianJis=2;
      asy_Ajax("${ctx}/sysconfig/emailSendView_getEmail.do",{'searchDto.templatenum':templatenum,'searchDto.templatecatno':templatecatno},'html',function(data){
            /*$('body').append("<div id='popWindow'></div>");
              $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
              $("#popWindow").html(data); */
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
					<th>&nbsp;&nbsp;邮件模板信息表</th>
					<th width="6.3%"><div><a href="javascript:searchForPage()" title="搜索" class="search"></a></div></th>
					<th width="6.3%"><div><a href="javascript:add()" title="新增" class="plus"></a></div></th>
				</tr>
			</table>
		</div>


		<div id="form_thead">
			<table class="form_table">
				<thead>
					<tr>
					    <td style="width:8%">序号</td>
                        <td style="width:32%">模板名称</td>
                        <td style="width:15%">所属功能模块</td>
                        <td style="width:10%">邮件类型</td>
                        <td style="width:10%">使用状态</td>
                        <td style="width:25%">操作</td>
				   </tr>
				</thead>
			</table>
		</div>
		<table class="form_table">
			<thead>
				   <tr>
						<td style="width:8%">序号</td>
	                    <td style="width:32%">模板名称</td>
	                    <td style="width:15%">所属功能模块</td>
	                    <td style="width:10%">邮件类型</td>
	                    <td style="width:10%">使用状态</td>
	                    <td style="width:25%">操作</td>
					</tr>
			</thead>
			<s:iterator value="cdEmailTemplateBaseDtoList" var="cdEmailTemplateBaseDto" status="status">
				<tr>
					<td>${status.index+1 }</td>
					<td style="padding:0px 8px;text-align:left">${cdEmailTemplateBaseDto.templatename }</td>
					<td style="padding:0px 8px;text-align:left">${cdEmailTemplateBaseDto.modulename }</td>
					<td>${cdEmailTemplateBaseDto.templatecatname }</td>
					<td>
					    <s:if test="#cdEmailTemplateBaseDto.validstate==1">使用</s:if>
	                    <s:else>停用</s:else>
	                </td>
					<td class="operate">
					   
					    <a href="javascript:check('${cdEmailTemplateBaseDto.templatenum}')">查看</a><span class="gap">|</span>
					    <a href="javascript:editor('${cdEmailTemplateBaseDto.templatenum}')">修改</a><span class="gap">|</span>
					    <a href="javascript:del('${cdEmailTemplateBaseDto.templatenum}')">刪除</a>
					    <s:if test="#cdEmailTemplateBaseDto.templatecatno!='T0301000'">
					    <span class="gap">|</span> <a href="javascript:sendEmail('${cdEmailTemplateBaseDto.templatecatno}','${cdEmailTemplateBaseDto.templatenum}')">发送</a>
					    </s:if>
					</td>
				</tr>
			</s:iterator>
		</table>
		<div class="page">
              <swtag:paginator url="${ctx}/sysconfig/emailTemplate_queryEmailTleForList.do"  showTotal="true" showAllPages="true"  strUnit="条记录" ></swtag:paginator>
        </div>
</div>