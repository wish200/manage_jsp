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
	          url : '${ctx}/sysconfig/sysPosMan_sendSysPost.do',  
	          error: function(XmlHttpRequest, textStatus, errorThrown){  
	               alert( "系统错误");  
	          },
	          success: function(data){
	               alert("发布成功");
	               asy_Ajax("${ctx}/sysconfig/sysPosMan_getSystrmPoseList.do",{},'html',function(data){
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
          <form id="noticeForm" method="post">    
            <!--新生成的公告代码-->
				    <input id="systemcode" name="ccSystemPostBaseDto.systemcode" 
				    value="${ccSystemPostBaseDto.systemcode }" type="hidden" />
                <table class="school_task">
                  <tr>
                    <th style="width:120px">公告摘要：</th>
                    <td style="width:450px">
		               ${ccSystemPostBaseDto.postdesc }
                    </td>
                    <th style="width:120px">截止日期：</th>
                    <td>
                      <s:date name="ccSystemPostBaseDto.enddate" format="yyyy-MM-dd"/>
                    </td>
                  </tr>
                  <tr class="height_70">
                    <th style="width:120px">内容：</th>
                    <td colspan="3">${ccSystemPostBaseDto.remark }</td>
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
