<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-查看 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/js/introduce/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/js/common/app.js"></script>
<script type="text/javascript">
$("#audiohuibenForm").find('input,select,textarea').attr('disabled',true);
//--发布按钮
function keep(){
	  $("#audiohuibenForm").find('input,select,textarea').attr('disabled',false);
	  $("#audiohuibenForm").ajaxSubmit({
	          type : 'post',  
	          url : '${ctx}/audiohuiben/audiohuiben_send.do',  
	          error: function(XmlHttpRequest, textStatus, errorThrown){  
	               alert( "系统错误");  
	          },
	          success: function(data){
	               alert("发布成功");
	               asy_Ajax("${ctx}/audiohuiben/audiohuiben_getList.do",{},'html',function(data){
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




$("#status").val("${appAudioHuibenBaseDto.status }");
</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;绘本信息</th>
                    </tr>
                  </table>
                </div>
          <form id="audiohuibenForm" method="post">    
            <!--新生成的公告代码-->
				    <input id="huibenid" name="appAudioHuibenBaseDto.huibenid" 
				    value="${appAudioHuibenBaseDto.huibenid }" type="hidden" />
                <table class="school_task">
                 <tr>
                    <th style="width:120px">绘本ID：</th>
                    <td colspan="3">
		               ${appAudioHuibenBaseDto.huibenid}
                    </td>
                  </tr>
                  <tr>
                    <th>状态：</th>
                    <td>
                    	<select id="status" class="selector" name="appAudioHuibenBaseDto.status">
                    	<option value="0">无效</option>
                    	<option value="1" selected>有效</option>
                    	</select>
                    
                    </td>
                    <th>小红花数量：</th>
                    <td>
		               ${appAudioHuibenBaseDto.flowercnt} 
                    </td>
                  </tr> 
                  <div style="border-bottom:1px solid black"></div> 
                  <tr>
                  	<th>用户ID：</th>
                    <td>
                       ${appAudioHuibenBaseDto.userid}
                    </td>
                    <th>用户名称：</th>
                    <td>
		               ${appAudioHuibenBaseDto.nickname} 
                    </td>
                  </tr>
                  <tr>
                     <th>用户头像地址：</th>
                     <td colspan="3">
                     ${appAudioHuibenBaseDto.userpic} 
                     </td>
                  </tr>
                  <tr>
                     <th>用户头像图片：</th>
                     <td colspan="3">
	                    <span id='filespan3' >
	                    <img id="userpicimg" hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${ctx}${appAudioHuibenBaseDto.userpic }"   onclick="selectForward(this)"/>
	                    </span>
                     </td>
                  </tr> 
                  
                  <tr>
                  	<th>绘画ID：</th>
                    <td>
                    	${appAudioHuibenBaseDto.picbookid}
                    </td>
                    <th>绘画名称：</th>
                    <td>
                    	${appAudioHuibenBaseDto.picbookname}
                    </td>
                  </tr>
                  <tr>
                     <th>绘画场景：</th>
                     <td colspan="3">
                     ${appAudioHuibenBaseDto.picscene}
                     </td>
                  </tr>
                  <tr>
                     <th>绘画图片地址：</th>
                     <td colspan="3">
                     ${appAudioHuibenBaseDto.picbookurl}
                     </td>
                  </tr>
                  <tr>
                     <th>绘画图片：</th>
                     <td colspan="3">
	                    <span id='filespan1'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appAudioHuibenBaseDto.picbookurl }" onclick="selectForward(this)"  />
	                    </span>
                     </td>
                  </tr>
                  <tr>
                    <th>绘音编号：</th>
                    <td>
                    	${appAudioHuibenBaseDto.audioid}
                    </td>
                    <th>绘音名称：</th>
                    <td>
                    	${appAudioHuibenBaseDto.audioname}
                    </td>
                  </tr>
                  <tr>
                    <th>绘音地址：</th>
                     <td colspan="2">
	                    <span id='filespan2' onclick="selectForward1('${ctx}/jsp/program/play.jsp?name=${appAudioHuibenBaseDto.audioname }&path=${appAudioHuibenBaseDto.audiourl }')">
	                     ${appAudioHuibenBaseDto.audiourl } 
	                    </span>
                     </td>
                     <td>时长：${appAudioHuibenBaseDto.audiolength}
                    </td>
                  </tr>
                  <tr class="height_70">
                    <th>绘音内容：</th>
                    <td colspan="3"><textarea style="height:300px;position:relative;float:left" id="audiocontent" name="appAudioHuibenBaseDto.audiocontent">${appAudioHuibenBaseDto.audiocontent}</textarea>
                    </td>
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
