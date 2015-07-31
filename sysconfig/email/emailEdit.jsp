<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--邮件模板-新增 -->
<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<link rel="stylesheet" href="${ctx }/newrisk/style/default.css" />
<div><!--存放js-->
<script charset="utf-8" type="text/javascript" src="${ctx }/newrisk/js/introduce/kindeditor-min.js"></script>
<script charset="utf-8" type="text/javascript" src="${ctx }/newrisk/js/introduce/zh_CN.js"></script>
<script charset="utf-8" type="text/javascript" src="${ctx }/newrisk/js/common/templateCatno.js"></script>
<script type="text/javascript">
var editor;
$(function() {
	//异步的去加载keditor编辑器
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
					 var limitNum = 1000;  //设定限制字数
					 if(this.count('text') > limitNum) {
					       //超过字数限制自动截取
					       var strValue = this.text();
					       strValue = strValue.substring(0,limitNum);
					       alert('限制1000字！');
					       this.text(strValue);
					    }
					 this.sync();
				}	
		});
	});
});
//模板名称-校验规则
$('#templateName').keyup(function(){
	  var value=$(this).val().replace(/[^\x00-\xff]/g, 'xx');
	  if(value.length>50){
		   alert("模板名称不能超过50个字符！");
		   var value=$(this).val();
		   value=value.substring(0,25);
		   $(this).val(value);
	  }
});
var comCode='${session.userLogin.comcode}';

//对所属功能模块进行初始化。
initTemplateCatno('${cdEmailTemplateBaseDto.moduleid}');
<%--//--初始化KindEditor插件--%>
// InitKindEditor("#editor_id");
//--返回按钮
function returnc(){
	if(confirm("取消不保存本次操作")){
		asy_Ajax(encodeURI(publicURL),{},'html',function(data){
			 $("#content").html(data);
		});
	}
}
//--点击抄送人
function clickCC(){
	$('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx }/sysconfig/emailTemplate_addressForPage.do","",'html',function(data){
         $('body').append("<div id='popWindow'></div>");
         $('body').append("<div class='black_overlay'></div>");
         $("#popWindow").html(data);
    });
}
//检查名称是否存在
function chickTemplateName(){
    var templateName=$("#templateName").val();
    var oldTemplateName=$("#oldTemplateName").val();
      if(templateName!=''&&templateName!=oldTemplateName){
              $.ajax({
                    url :'${ctx }/sysconfig/emailTemplate_exitsTepName.do',
                    type : 'POST',
                    data :{
                       'searchDto.doing':templateName,
                       'searchDto.comCode':comCode
                    },
                    dataType : 'json',
                    error : function() {
                        alert('系统错误。请与管理员联系');
                    },
                    success :function(data){
                       if(data>0){
                          alert("模板名称已经存在！");
                          $('#templateName').val('');
                       }
                    }
                }); 
         }
}
//检查邮件主题
function checkHeadoftempl(){
          var value=$("#headoftempl").val().replace(/[^\x00-\xff]/g, 'xx');
          if(value.length>50){
               alert("邮件主题不能超过50个字符！");
               var value=$("#headoftempl").val();
               value=value.substring(0,25);
               $("#headoftempl").val(value);
          }
}
//保存
function saveEmail(){
    var ok=haveData("templateName","模板名称不能为空！")&&
      haveData("headoftempl","邮件主题不能为空！")&&
      haveData("moduleid","请选择所属功能模块！")&&
      haveData("templatecatno","请选择邮件类型！")&&
      haveData("validstate","请选择使用状态！");
       $("#modulename").val($("#suoShuGongNeng").html());
      $("#templatecatname").val($("#youJianLeiXing").html());
      if(ok){
            $("#majorForm").ajaxSubmit({
                    type : 'post',  
                    url : '${ctx }/sysconfig/emailTemplate_updateEmailTle.do',  
                    error: function(XmlHttpRequest, textStatus, errorThrown){  
                         alert( "系统错误");  
                    },
                    success: function(data){
                        $("#content").html(data);
   	           	 	    publicURL="${ctx}/sysconfig/emailTemplate_queryEmailTleForList.do";
                        $('#popWindow').remove();
                        $('.black_overlay').remove();   
                    }
                 });
      }
}
$(".selectClick1 span").click(function(){
	var thisinput=$(this);
	var thisInputvar=$(this).next("input");
	var thisul=$(this).parent().find("dl");
	if(thisul.css("display")=="none"){
		if(thisul.height()>150){thisul.css({top:"-80px",height:"250"+"px","overflow-y":"scroll"});};
		thisul.fadeIn("100");
		thisul.parent().css("z-index","9999");
		thisul.hover(function(){},function(){thisul.fadeOut("100");thisul.parent().css("z-index","2");});
		thisinput.parent().hover(function(){},function(){thisul.fadeOut("200");thisul.parent().css("z-index","2");});
		thisul.find("dd").click(function(){
			thisinput.text($(this).text());
			thisInputvar.val($(this).attr('value'));
			thisul.fadeOut("100");
			
			});
		}
	else{
		thisul.fadeOut("fast");
		}
});
$("#yinMoBan").prev().click(function(){
	var thisinput=$(this);
	var thisInputvar=$(this).next("input");
	var thisul=$(this).parent().find("dl");
	if(thisul.css("display")=="none"){
		if(thisul.height()>150){thisul.css({top:"-80px",height:"250"+"px","overflow-y":"scroll"});};
		thisul.fadeIn("100");
		thisul.parent().css("z-index","9999");
		thisul.hover(function(){},function(){thisul.fadeOut("100");thisul.parent().css("z-index","2");});
		thisinput.parent().hover(function(){},function(){thisul.fadeOut("200");thisul.parent().css("z-index","2");});
		thisul.find("dd").click(function(){
			thisinput.text($(this).text());
			thisInputvar.val($(this).attr('value'));
			thisul.fadeOut("100");
            editor.html($(this).prev().val());
			thisul.find("dd").unbind("click");
		  });
		}
	else{
		thisul.fadeOut("fast");
		}
});
</script>
</div>

<div  class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;编辑邮件模板</th>
                    </tr>
                  </table>
                </div>
                <div>
                    <input style="display: none"  id="oldTemplateName" value="${cdEmailTemplateBaseDto.templatename}">
                    <input style="display: none" id="oldTemplatecatNo" value="${cdEmailTemplateBaseDto.templatecatno}">
                </div>
          <form id="majorForm" method="post"> 
                 <input id="remark" name="cdEmailTemplateBaseDto.remark"  value="1" style="display: none" />
                 <input id="modulename" name="cdEmailTemplateBaseDto.modulename"  style="display: none" />
                 <input id="templatecatname" name="cdEmailTemplateBaseDto.templatecatname" style="display: none" />    
                <table class="school_task ostyle">
                  <tr>
                    <th>模板名称：</th>
                    <td>
		               <input style="width:122px;" id="templateName" 
		               name="cdEmailTemplateBaseDto.templatename" 
		               onblur="chickTemplateName();"
		               value="${cdEmailTemplateBaseDto.templatename }" type="text" />
		               <span style="color:red">*</span>
                    </td>
                    <th>邮件主题：</th>
                    <td>
                       <input style="width:122px;" id="headoftempl" 
                       name="cdEmailTemplateBaseDto.headoftempl" onkeyup="checkHeadoftempl();"
                       value="${cdEmailTemplateBaseDto.headoftempl }" type="text" />
                       <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                    <th>所属功能模块 ：</th>
                    <td>
                        <ul>
                      	<li>
		                <div class="select select_1">
		                  <span id="suoShuGongNeng">${cdEmailTemplateBaseDto.modulename}</span>
                            <input name="cdEmailTemplateBaseDto.moduleid" value="${cdEmailTemplateBaseDto.moduleid}"  style="display: none"  id="moduleid"/>
                            <dl id="templateModuleId" >
                            </dl>
		                </div> 
		            	</li>
		               </ul>
                       <span style="color:red">*</span>
                    </td>
                    <th>邮件类型：</th>
                    <td>
                        <ul>
                      	<li>
		                <div class="select select_1 selectClick1">
		                      <span  id="youJianLeiXing" >${cdEmailTemplateBaseDto.templatecatname }</span>
                            <input name="cdEmailTemplateBaseDto.templatecatno" style="display: none" value="${cdEmailTemplateBaseDto.templatecatno}"  id="templatecatno"/>
                            <dl  id="templateEmailId">
                            </dl>
		                </div> 
		            	</li>
		               </ul>
                       <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                    <th>引用模板 ：</th>
                    <td>
                     <ul>
                      	<li>
		                <div class="select select_1">
		                	<span style="width:130px">请选择</span>
		                	 <dl id="yinMoBan">
                                <s:iterator value="cdEmailTemplateBaseDtoList" var="emailTemplatedto">
                                  <input style="display: none" value='${emailTemplatedto.bodyoftempl}'/><dd title="${emailTemplatedto.templatename}">${emailTemplatedto.templatename}</dd>
                                </s:iterator>
                            </dl>
		                </div> 
		            	</li>
		               </ul>
                    </td>
                    <th>使用状态：</th>
                    <td>
                     <ul>
                      	<li>
		                <div class="select select_1 selectClick1">
		                  <s:if test="%{cdEmailTemplateBaseDto.validstate==1}">
		                     <span>使用</span>
		                	<input id="validstate" name="cdEmailTemplateBaseDto.validstate" value="1" type="hidden"/>
		                  </s:if>
		                  <s:elseif test="%{cdEmailTemplateBaseDto.validstate==0}">
		                     <span>使用</span>
		                	<input id="validstate" name="cdEmailTemplateBaseDto.validstate" value="0" type="hidden"/>
		                  </s:elseif>
		                  <s:else>
		                     <span>请选择</span>
		                	<input id="validstate" name="cdEmailTemplateBaseDto.validstate" type="hidden"/>
		                  </s:else>
		                    <dl>
		                        <dd value="">请选择</dd>
		                        <dd value="1">使用</dd>
		                        <dd value="0">停用</dd>
		                    </dl>
		                </div> 
		            	</li>
		               </ul>
					 <span style="color:red">*</span>
                    </td>
                  </tr>
                  <%-- <tr>
                    <th>抄送人：</th>
                    <td colspan="3">
					    <input id="Caddressee"  onclick="clickCC('BCC');" 
					    type="text" style="width:350px;"  readonly="readonly" value="${BCCName}"/>
				         <input id="BCCid"  style="display: none" name="BCCCode"  value="${BCCCode}"/>
				         <input id="Depid"  style="display: none"  name="BCCDepCode"  value="${BCCDepCode}"/>
                    </td>
                  </tr> --%>
                </table>
                 <!-- 编辑器区域 -->
                 <div style="width:100%;height:300px;">
	             <textarea id="editor_id" name="cdEmailTemplateBaseDto.bodyoftempl" style="width:100%;height:300px;display: none" >${cdEmailTemplateBaseDto.bodyoftemplRe }</textarea>
	              </div>
	             <!-- 更新邮件模板所需要的邮件代码 -->
                 <input name="cdEmailTemplateBaseDto.templatenum" id="templatenum" type="hidden" value="${cdEmailTemplateBaseDto.templatenum }"/>
           </form>     
                  <div class="manual_button">
                        <a id="cancleBtn" href="javascript:returnc()" class="cancel">取&nbsp;&nbsp;消</a>
                        <a id="keepBtn" href="javascript:saveEmail()" class="save">保&nbsp;&nbsp;存</a>
                        <a id="returnBtn" style="display:none" href="javascript:returnc()" class="cancel">返&nbsp;&nbsp;回</a>
                        <a id="subBtn" style="display:none" href="javascript:submit()" class="save">提&nbsp;&nbsp;交</a>
                  </div>
                </div>
            </div>
