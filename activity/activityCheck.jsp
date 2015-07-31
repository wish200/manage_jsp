<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-查看 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript">
$("#noticeForm").find('input,select,textarea').attr('disabled',true);
//--发布按钮
function keep(){
	  $("#noticeForm").find('input,select,textarea').attr('disabled',false);
	  $("#noticeForm").ajaxSubmit({
	          type : 'post',  
	          url : '${ctx}/activity/activity_send.do',  
	          error: function(XmlHttpRequest, textStatus, errorThrown){  
	               alert( "系统错误");  
	          },
	          success: function(data){
	               alert("发布成功");
	               asy_Ajax("${ctx}/sysconfig/activity_getList.do",{},'html',function(data){
	          		 $("#content").html(data);
	               });
	          }
	  });
}
//--返回按钮
function returnc(){
	   if(typeof(publicURL)=='undefined'){
		  history.go(0);
	   }else{
			asy_Ajax(encodeURI(publicURL),{},'html',function(data){
				 $("#content").html(data);
			});
	   }
}
$("#activitytype").val("${appActivityBaseDto.activitytype }");
$("#validstatus").val("${appActivityBaseDto.validstatus }");
</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;公告信息</th>
                    </tr>
                  </table>
                </div>
          <form id="activityForm" method="post">    
            <!--新生成的公告代码-->
				    <input id="activityid" name="appActivityBaseDto.activityid" 
				    value="${appActivityBaseDto.activityid }" type="hidden" />
                <table class="school_task">
                 <tr>
                    <th style="width:120px">活动名称ID：</th>
                    <td colspan="3">
		               ${appActivityBaseDto.activityid}
                    </td>
                  </tr>
                  
                  <tr>
                    <th style="width:120px">活动名称：</th>
                    <td style="width:450px">
		               ${appActivityBaseDto.activityname }
                    </td>
                    <th style="width:120px">活动时间：</th>
                    <td>
                      ${appActivityBaseDto.activitytime } 
                    </td>
                  </tr>
                  
                  <tr>
                    <th style="width:120px">活动类型：</th>
                    <td style="width:450px">
		              <select id="activitytype" name="appActivityBaseDto.activitytype" readonly>
		               	<option value="1" >一起玩</option>
                    	<option value="2">小朋友圈</option>
		               </select>
                    </td>
                    <th style="width:120px">活动状态：</th>
                    <td>
                      <select id="validstatus" class="selector" name="appActivityBaseDto.validstatus" >
                    	<option value="0">无效</option>
                    	<option value="1" >有效</option>
                    	</select>   
                    </td>
                  </tr>
                  
                   <tr>
                     <th>活动图片：</th>
                     <td colspan="3">
	                    <span id='filespan'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appActivityBaseDto.activitypicurl }"  />
	                    </span>
                     </td>
                  </tr>
                  
                  <tr class="height_70">
                    <th style="width:120px">内容：</th>
                    <td colspan="3">${appActivityBaseDto.activitydesc}</td>
                  </tr>
                </table>
           </form>     
                  <div class="manual_button">
                        <a id="returnBtn" href="javascript:returnc()" class="cancel">返&nbsp;&nbsp;回</a>
                        <s:if test="%{searchDto.doing=='publish'}">
                        <a id="keepBtn" href="javascript:keep()" class="save" >发&nbsp;&nbsp;布</a>
                        </s:if>
                  </div>
                </div>
            </div>
