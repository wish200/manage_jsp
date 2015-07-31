<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--邮件模板-查看 -->
<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<link rel="stylesheet" href="${ctx }/newrisk/style/default.css" />
<div><!--存放js-->
<script charset="utf-8" type="text/javascript" src="${ctx }/newrisk/js/introduce/kindeditor-min.js"></script>
<script charset="utf-8" type="text/javascript" src="${ctx }/newrisk/js/introduce/zh_CN.js"></script>
<script type="text/javascript">
$(function() {
	//异步的去加载keditor编辑器
	$.getScript('${ctx }/newrisk/js/introduce/kindeditor-min.js', function() {
		KindEditor.basePath = '../';
		var editor=KindEditor.create('textarea[id="editor_id"]',{
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
//--返回按钮
function returnc(){
	asy_Ajax(encodeURI(publicURL),{},'html',function(data){
		 $("#content").html(data);
	});
}
</script>
</div>

<div  class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;查看邮件模板</th>
                    </tr>
                  </table>
                </div>
          <form id="majorForm" method="post">    
                <table class="school_task ostyle">
                  <tr>
                    <th>模板名称：</th>
                    <td>
		               ${cdEmailTemplateBaseDto.templatename }
                    </td>
                    <th>邮件主题：</th>
                    <td>
                       ${cdEmailTemplateBaseDto.headoftempl }
                    </td>
                  </tr>
                  <tr>
                    <th>所属功能模块 ：</th>
                    <td>
                        ${cdEmailTemplateBaseDto.modulename}
                    </td>
                    <th>邮件类型：</th>
                    <td>
                         ${cdEmailTemplateBaseDto.templatecatname}
                    </td>
                  </tr>
                  <tr>
                    <th>使用状态：</th>
                    <td colspan="3">
	                    <s:if test="%{cdEmailTemplateBaseDto.validstate=1}">使用
	                    </s:if>
	                    <s:else>停用</s:else>
                    </td>
                  </tr>
                </table>
                 <!-- 编辑器区域 -->
                 <div style="width:100%;height:300px;">
	             <textarea id="editor_id" name="cdEmailTemplateBaseDto.bodyoftempl" style="width:100%;height:300px;display: none"  > ${cdEmailTemplateBaseDto.bodyoftemplRe }</textarea>
	             </div>
           </form>     
                  <div class="manual_button">
                        <a id="returnBtn" href="javascript:returnc()" class="cancel">返&nbsp;&nbsp;回</a>
                  </div>
                </div>
            </div>
