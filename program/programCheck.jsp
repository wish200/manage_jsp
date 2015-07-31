<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-查看 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript">
$("#programForm").find('input,select,textarea').attr('disabled',true);
//--发布按钮
function keep(){
	  $("#programForm").find('input,select,textarea').attr('disabled',false);
	  $("#programForm").ajaxSubmit({
	          type : 'post',  
	          url : '${ctx}/program/program_send.do',  
	          error: function(XmlHttpRequest, textStatus, errorThrown){  
	               alert( "系统错误");  
	          },
	          success: function(data){
	               alert("发布成功");
	               asy_Ajax("${ctx}/program/program_getList.do",{},'html',function(data){
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





$("#status").val("${appProgramBaseDto.status }");
</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;节目故事信息</th>
                    </tr>
                  </table>
                </div>
          <form id="programForm" method="post">    
            <!--新生成的公告代码-->
				    <input id="programid" name="appProgramBaseDto.programid" 
				    value="${appProgramBaseDto.programid }" type="hidden" />
                <table class="school_task">
                 <tr>
                    <th style="width:120px">节目ID：</th>
                    <td >
		               ${appProgramBaseDto.programid}
                    </td>
                    <th style="width:120px">节目名称：</th>
                    <td>
		               ${appProgramBaseDto.programname }
                    </td>
                  </tr>
                  <tr>
                    <th style="width:120px">电台ID：</th>
                    <td >
		               ${appProgramBaseDto.channelid}
                    </td>
                    <th style="width:120px">时长：</th>
                    <td>
		               ${appProgramBaseDto.duration}
                    </td>
                  </tr>
                  <tr>
                    <th style="width:120px">播放量：</th>
                    <td >
		               ${appProgramBaseDto.playcnt}
                    </td>
                    <th style="width:120px">小红花数量：</th>
                    <td >
		               ${appProgramBaseDto.flowercnt}
                    </td>  
                  </tr>
                  
                  <tr>
                    <th style="width:120px">优先级：</th>
                    <td>
                      ${appProgramBaseDto.sort} 
                    </td>
					<th style="width:120px">状态：</th>
                    <td>
                      <select id="status" class="selector" name="appProgramBaseDto.status" >
                    	<option value="0">无效</option>
                    	<option value="1" >有效</option>
                    	</select>   
                    </td>               
                  </tr>
                  <tr>
                     <th>节目头像图片：</th>
                     <td colspan="3">
	                    <span id='filespan1'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appProgramBaseDto.programpic }" onclick="selectForward(this)"  />
	                    </span>
                     </td>
                  </tr>
                  <tr>
                    <th>节目音频：</th>
                     <td colspan="3">
                     	<span id='filespan2' onclick="selectForward1('${ctx}/jsp/program/play.jsp?name=${appProgramBaseDto.programurl }&path=${appProgramBaseDto.programurl }')">
	                     ${appProgramBaseDto.programurl } 
	                    </span>
                     </td>
                  </tr>
                  
                  <tr class="height_70">
                    <th style="width:120px">简介：</th>
                    <td colspan="3">${appProgramBaseDto.description}</td>
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
