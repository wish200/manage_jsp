<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-查看 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/js/introduce/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/js/common/app.js"></script>
<script type="text/javascript">
$("#huibenForm").find('input,select,textarea').attr('disabled',true);
//--发布按钮
function keep(){
	  $("#huibenForm").find('input,select,textarea').attr('disabled',false);
	  $("#huibenForm").ajaxSubmit({
	          type : 'post',  
	          url : '${ctx}/huiben/huiben_send.do',  
	          error: function(XmlHttpRequest, textStatus, errorThrown){  
	               alert( "系统错误");  
	          },
	          success: function(data){
	               alert("发布成功");
	               asy_Ajax("${ctx}/huiben/huiben_getList.do",{},'html',function(data){
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


function selectForward(e){
			//var src = encodeURI(encodeURI("picPath"+picPath));
			var newwin = window.open();
			 var picPath = e.src;
			newwin.document.write("<img src='"+picPath+"'>");
		} 
		
		function selectForward1(Path){
			var newwin = window.open(Path);
		} 


$("#status").val("${appHuibenBaseDto.status }");
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
          <form id="huibenForm" method="post">    
            <!--新生成的公告代码-->
				    <input id="huibenid" name="appHuibenBaseDto.huibenid" 
				    value="${appHuibenBaseDto.huibenid }" type="hidden" />
                <table class="school_task">
                 <tr>
                    <th style="width:120px">绘本ID：</th>
                    <td colspan="3">
		               ${appHuibenBaseDto.huibenid}
                    </td>
                  </tr>
                  <tr>
                    <th>状态：</th>
                    <td>
                    	<select id="status" class="selector" name="appHuibenBaseDto.status">
                    	<option value="0">无效</option>
                    	<option value="1" selected>有效</option>
                    	</select>
                    
                    </td>
                    <th>小红花数量：</th>
                    <td>
		               ${appHuibenBaseDto.flowercnt} 
                    </td>
                  </tr> 
                  <div style="border-bottom:1px solid black"></div> 
                  <tr>
                  	<th>用户ID：</th>
                    <td>
                       ${appHuibenBaseDto.userid}
                    </td>
                    <th>用户名称：</th>
                    <td>
		               ${appHuibenBaseDto.nickname} 
                    </td>
                  </tr>
                  <tr>
                     <th>用户头像地址：</th>
                     <td colspan="3">
                     ${appHuibenBaseDto.userpic} 
                     </td>
                  </tr>
                  <tr>
                     <th>用户头像图片：</th>
                     <td colspan="3">
	                    <span id='filespan3' >
	                    <img id="userpicimg" hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appHuibenBaseDto.userpic }"   onclick="selectForward(this)"/>
	                    </span>
                     </td>
                  </tr> 
                  
                  <tr>
                  	<th>绘画ID：</th>
                    <td>
                    	${appHuibenBaseDto.picbookid}
                    </td>
                    <th>绘画名称：</th>
                    <td>
                    	${appHuibenBaseDto.picbookname}
                    </td>
                  </tr>
                  <tr>
                     <th>绘画场景：</th>
                     <td colspan="3">
                     ${appHuibenBaseDto.picscene}
                     </td>
                  </tr>
                  <tr>
                     <th>绘画图片地址：</th>
                     <td colspan="3">
                     ${appHuibenBaseDto.picbookurl}
                     </td>
                  </tr>
                  <tr>
                     <th>绘画图片：</th>
                     <td colspan="3">
	                    <span id='filespan1'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appHuibenBaseDto.picbookurl }" onclick="selectForward(this)"  />
	                    </span>
                     </td>
                  </tr>
                  <tr>
                    <th>绘音编号：</th>
                    <td>
                    	${appHuibenBaseDto.audioid}
                    </td>
                    <th>绘音名称：</th>
                    <td>
                    	${appHuibenBaseDto.audioname}
                    </td>
                  </tr>
                  <tr>
                    <th>绘音地址：</th>
                     <td colspan="2">
	                    <span id='filespan2' onclick="selectForward1('${ctx}/jsp/program/play.jsp?name=${appHuibenBaseDto.audioname }&path=${appHuibenBaseDto.audiourl }')">
	                     ${appHuibenBaseDto.audiourl } 
	                    </span>
                     </td>
                     <td>时长：${appHuibenBaseDto.audiolength}
                    </td>
                  </tr>
                  <tr class="height_70">
                    <th>绘音内容：</th>
                    <td colspan="3"><textarea style="height:300px;position:relative;float:left" id="audiocontent" name="appHuibenBaseDto.audiocontent">${appHuibenBaseDto.audiocontent}</textarea>
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
