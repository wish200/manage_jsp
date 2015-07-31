<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/page" prefix="swtag"%>

<!--人员信息管理 -->

<div>
<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<script charset="utf-8" type="text/javascript" src="${ctx }/newrisk/js/introduce/kindeditor-min.js"></script>
<script charset="utf-8" type="text/javascript" src="${ctx }/newrisk/js/introduce/zh_CN.js"></script>
<script type="text/javascript">
headerFixed();//表格表头固定
function closeDiv(){
     $('#popWindow').remove();
     $('.black_overlay').remove();  
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
    asy_Ajax("${ctx}/newrisk/jsp/sysconfig/emailSendRecor/windSearchRecor.jsp",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
	   	 $('#popWindow').html(data);
	});
}
function lookEmail(mid){
    asy_Ajax("${ctx}/newrisk/jsp/sysconfig/emailSendRecor/emailSendLook.jsp",{},'html',function(data){
            $('body').append("<div id='popWindow'></div>");
              $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
             $("#popWindow").html(data);
             $("#editor_id").html($(mid).prev().html());
             $.getScript('${ctx }/newrisk/js/introduce/kindeditor-min.js', function() {
                KindEditor.basePath = '../';
                editor=KindEditor.create('textarea[id="editor_id"]',{
                        resizeType : 1,
                        allowPreviewEmoticons : false,
                        allowImageUpload : false,
                        items : [
                            'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                            'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                            'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
                        afterBlur : function() {
                             this.sync();
                             var limitNum = 500;  //设定限制字数
                             if(this.count('text') > limitNum) {
                                   //超过字数限制自动截取
                                   var strValue = this.text();
                                   strValue = strValue.substring(0,limitNum);
                                   alert('限制500字！');
                                   this.text(strValue);
                                }
                             this.sync();
                        }   
                });
                editor.readonly(true);
            });
       });   
}
</script>
</div>

	<div class="report_form">
		<div id="form_tit" class="form_tit">
			<table>
				<tr>
					<th>&nbsp;&nbsp;邮件发送记录</th>
					<th width="6.3%"><div><a href="javascript:searchPage()" title="搜索" class="search"></a></div></th>
				</tr>
			</table>
		</div>


		<div id="form_thead">
			<table class="form_table">
				<thead>
					<tr>
						<td style="width:4%">序号</td>
                        <td style="width:6%">机构</td>
                        <td style="width:6%">部门</td>
                        <td style="width:6%">所属功能模块</td>
                        <td style="width:6%">模板类型</td>
                        <td style="width:10%">邮件标题</td>
                        <td style="width:4%">邮件内容</td>
                        <td style="width:4%">邮件附件</td>
                        <td style="width:10%">邮件收件人</td>
                        <td style="width:10%">邮件抄送人</td>
                        <td style="width:10%">发送时间</td>
					</tr>
				</thead>
			</table>
		</div>
		<table class="form_table">
			<thead>
				   <tr>
						<td style="width:4%">序号</td>
                        <td style="width:6%">机构</td>
                        <td style="width:6%">部门</td>
                        <td style="width:6%">所属功能模块</td>
                        <td style="width:6%">模板类型</td>
                        <td style="width:10%">邮件标题</td>
                        <td style="width:4%">邮件内容</td>
                        <td style="width:4%">邮件附件</td>
                        <td style="width:10%">邮件收件人</td>
                        <td style="width:10%">邮件抄送人</td>
                        <td style="width:10%">发送时间</td>
				   </tr>
			</thead>
			<s:iterator value="ccMailSendRecordDtos" var="ccMailSendRecordDto" status="status">
				<tr>
					<td>${status.index+1 }</td>
					<td>${ccMailSendRecordDto.comName }</td>
				    <td >${ccMailSendRecordDto.depName }</td>
					<td>${ccMailSendRecordDto.functionName }</td>
					<td>${ccMailSendRecordDto.moduleName }</td>
					<td>${ccMailSendRecordDto.emailthe }</td>
					<td> <textarea style="display: none"  > ${ccMailSendRecordDto.emaildetail} </textarea><a onclick="lookEmail(this)" style="cursor:pointer">查看</a>   </td>
					<td>
					
					<s:if test="#ccMailSendRecordDto.attadress!=null">
					   <a target="_blank" href="${ctx}${ccMailSendRecordDto.attadress}">下载</a>
					</s:if>
					</td>
					<td><s:iterator value="#ccMailSendRecordDto.ccMailReceiverBaseDtos" var="ccMailReceiverBaseDto">
					       <s:if test="#ccMailReceiverBaseDto.usertype==1">
					           <s:property value="#ccMailReceiverBaseDto.username" />,
					       </s:if>
					   </s:iterator>
					</td>
					<td>
					   <s:iterator value="#ccMailSendRecordDto.ccMailReceiverBaseDtos" var="ccMailReceiverBaseDto">
                           <s:if test="#ccMailReceiverBaseDto.usertype==2">
                               <s:property value="#ccMailReceiverBaseDto.username" />,
                           </s:if>
                       </s:iterator>
					</td>
					<td><s:date name="#ccMailSendRecordDto.senddate" format="yyyy-MM-dd hh:mm:ss" /> </td>
				</tr>
			</s:iterator>
		</table>
		<div class="page">
              <swtag:paginator url="${ctx}/sysconfig/emailSend_list.do"  showTotal="true" showAllPages="false"  strUnit="条记录" ></swtag:paginator>
         </div>
	</div>
