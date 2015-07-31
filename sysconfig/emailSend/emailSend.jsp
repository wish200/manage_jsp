<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<!--查看指标计算公式的因子页面(弹出窗口)-->

<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<script charset="utf-8" type="text/javascript" src="${ctx }/newrisk/js/introduce/kindeditor-min.js"></script>
<script charset="utf-8" type="text/javascript" src="${ctx }/newrisk/js/introduce/zh_CN.js"></script>
<!--以下页面的js操作-->
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
var templatenum='${searchDto.templatenum}';
var templatecatno='${searchDto.templatecatno}';
<%--窗口关闭--%>
function closeDiv(){
     $('#popWindow').remove();
     $('.black_overlay').remove();  
}
var strindex="";
    /*修改内容*/
function bodyQueDing(){
       $('#bodyoftempl'+strindex).html($('#editor_id').val());
       closeDiv();
}
String.prototype.replaceAll = function(s1,s2) { 
    return this.replace(new RegExp(s1,"gm"),s2); 
//     .replaceAll("&","&amp").replaceAll("<","&lt").replaceAll(">","&gt")
};
function editEmail(mid,index){
    strindex=index;
    asy_Ajax("${ctx}/newrisk/jsp/sysconfig/emailSend/emailSendEdit.jsp",{},'html',function(data){
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
		    });
       });   
}
//--返回按钮
function returnc(){
    asy_Ajax(encodeURI(publicURL),{},'html',function(data){
         $("#content").html(data);
    });
}
$('.stcs').each(function (i,n){
    var userMessages=n.value.split(',');
    var user='';
    for(var j=0;j<userMessages.length-1;j++){
        var userMessage=userMessages[j].split('-');
        user+=$.trim(userMessage[1]);
        if(j!=userMessages.length-2){
            user+=",";
        }
    }
    $('.stcsShow').eq(i).val(user);   
});
$('.bccs').each(function (i,n){
    var userMessages=n.value.split(',');
    var user='';
    for(var j=0;j<userMessages.length-1;j++){
        var userMessage=userMessages[j].split('-');
        user+=$.trim(userMessage[1]);
        if(j!=userMessages.length-2){
            user+=",";
        }
    }
    $('.bccsShow').eq(i).val(user);   
});
function sendEmail(){
    $('#sendEmail').ajaxSubmit({
               type: "post",  
               url: "${ctx}/sysconfig/emailSendView_sendEmail.do" ,  
               success: function(data){ 
                  alert("发送成功");
                  returnc();
               },  
               error: function(XmlHttpRequest, textStatus, errorThrown){  
                  alert( "系统错误");  
               }  
          }); 
}
var iiii="";
var userType="";
function chengUser(type,index){
    iiii=index;
    userType=type;
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx }/sysconfig/emailSendView_addressForPage.do","",'html',function(data){
         $('body').append("<div id='popWindow'></div>");
         $('body').append("<div class='black_overlay'></div>");
         $("#popWindow").html(data);
    }); 
}
//--查询页面
function searchForPage(){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/newrisk/jsp/sysconfig/emailSend/windSendEmailDate.jsp",{},'html',function(data){
         $('body').append("<div id='popWindow'></div>");
         $('body').append("<div class='black_overlay'><div class='loading'></div></div>");
         $("#popWindow").html(data);
    });  
}
</script>
        <div id="form_tit" class="form_tit">
            <table>
                <tr>
                    <th>&nbsp;&nbsp;邮件发送</th>
                    <s:if test='"T0201000".equals(searchDto.templatenum)'>
                    <th width="6.3%"><div><a href="javascript:searchForPage()" title="搜索" class="search"></a></div></th>
                    </s:if>
                </tr>
            </table>
        </div>
       <div class="report_form">
        <form action="${ctx}/sysconfig/emailSendView_sendEmail.do"  id="sendEmail">
            <input style="display: none"  name="searchDto.templatenum"    value="<s:property value="searchDto.templatenum"/>" > 
	         <table class="form_table" style="border-top:1px solid #c6dcea">
	            <thead>
	                   <tr style="border-top:1px solid #c6dcea">
	                    <td width="5%">序号</td>
	                    <td width="10%">部门</td>
	                    <td width="30%">发送人</td>
	                    <td width="30%">抄送人</td>
	                    <td width="20%">标题</td>
	                    <td width="5%">内容</td>
	                    </tr>
	            </thead>
	             <s:iterator value="emailSendDtos"  var="emailSendDto" status="stat">
	                <tr>
	                    <td>${stat.index+1} <input style="display: none"  name="emailMessageDtos[${stat.index}].templatenum"    value="<s:property value="searchDto.templatenum"/>" >
	                           <input style="display: none"  name="emailMessageDtos[${stat.index}].statdate"    value="<s:property value="#emailSendDto.statdate"/>" >
	                       </td>
	                    <td>${emailSendDto.depname} <input style="display: none"  name="emailMessageDtos[${stat.index}].newdepcode"    value="<s:property value="#emailSendDto.newdepcode"/>" > </td>
	                    <td style="text-align: left;padding-left: 10px" >
	                        <input class="stcs"  style="display: none" name="emailMessageDtos[${stat.index}].stcs"   value="<s:iterator value="#emailSendDto.ccUserBaseDtos" var="ccUserBaseDto" >
	                            <s:if test="#ccUserBaseDto.deppositioncode=='DP0000004'||#ccUserBaseDto.deppositioncode=='DP0000005'||#ccUserBaseDto.deppositioncode=='DP0000009'||#ccUserBaseDto.deppositioncode=='DP0000010'"><s:property value="#ccUserBaseDto.email"/>-<s:property value="#ccUserBaseDto.username"/>-<s:property value="#ccUserBaseDto.usercode"/>,</s:if>
	                        </s:iterator>">
	                        <input style="width: 98%;height: 30px" class="stcsShow" readonly="readonly" onclick="chengUser('stcs','${stat.index}');" >
	                    </td>
	                    <td  style="text-align: left;padding-left: 10px">
	                        <input class="bccs" style="display: none"  name="emailMessageDtos[${stat.index}].bccs"   value="<s:iterator value="#emailSendDto.ccUserBaseDtos" var="ccUserBaseDto">
	                            <s:if test="#ccUserBaseDto.deppositioncode!='DP0000004'&&#ccUserBaseDto.deppositioncode!='DP0000005'&&#ccUserBaseDto.deppositioncode!='DP0000009'&&#ccUserBaseDto.deppositioncode!='DP0000010'"><s:property value="#ccUserBaseDto.email"/>-<s:property value="#ccUserBaseDto.username"/>-<s:property value="#ccUserBaseDto.usercode"/>,</s:if>
	                        </s:iterator>">
                            <input style="width:98%;height: 30px" class="bccsShow" readonly="readonly" onclick="chengUser('bccs','${stat.index}');" >
	                    </td>
	                   <td style="padding: 10px" >
	                       <input   name="emailMessageDtos[${stat.index}].headoftempl"   style="width: 100%;height: 30px" value="${emailSendDto.headoftempl}">
	                    </td>
	                    <td>  
	                     <textarea  name="emailMessageDtos[${stat.index}].bodyoftempl"   style="display: none"    id="bodyoftempl${stat.index}" > ${emailSendDto.bodyoftempl} </textarea><a onclick="editEmail(this,'${stat.index}')" style="cursor:pointer">编辑</a>   
	                    </td>
	                </tr>
	             </s:iterator>
	       </table>
       </form>
       </div>
       <div class="manual_button">
           
          <s:if test="emailSendDtos.size>0">
             <a id="class_Cancle" href="javascript:returnc();" class="cancel">取&nbsp;&nbsp;消</a>
             <a id="class_Submit" href="javascript:sendEmail();" class="save">发&nbsp;&nbsp;送</a>
          </s:if>
          <s:else>
            <a id="class_Cancle" href="javascript:returnc();" class="cancel">返&nbsp;&nbsp;回</a>
          </s:else>
        </div>