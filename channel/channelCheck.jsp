<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-查看 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript">
$("#channelForm").find('input,select,textarea').attr('disabled',true);
//--发布按钮
function keep(){
	  $("#channelForm").find('input,select,textarea').attr('disabled',false);
	  $("#channelForm").ajaxSubmit({
	          type : 'post',  
	          url : '${ctx}/channel/channel_send.do',  
	          error: function(XmlHttpRequest, textStatus, errorThrown){  
	               alert( "系统错误");  
	          },
	          success: function(data){
	               alert("发布成功");
	               asy_Ajax("${ctx}/channel/channel_getList.do",{},'html',function(data){
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


		
		
$("#status").val("${appChannelBaseDto.status }");
</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;微听信息</th>
                    </tr>
                  </table>
                </div>
          <form id="channelForm" method="post">    
            <!--新生成的公告代码-->
				    <input id="channelid" name="appChannelBaseDto.channelid" 
				    value="${appChannelBaseDto.channelid }" type="hidden" />
                <table class="school_task">
                 <tr>
                    <th style="width:120px">电台ID：</th>
                    <td >
		               ${appChannelBaseDto.channelid}
                    </td>
                    <th style="width:120px">电台名称：</th>
                    <td>
		               ${appChannelBaseDto.channelname }
                    </td>
                  </tr>
                  <tr>
                    <th style="width:120px">主播名称：</th>
                    <td >
		               ${appChannelBaseDto.djname}
                    </td>
                    <th style="width:120px">主播简介：</th>
                    <td>
		               ${appChannelBaseDto.djdesc}
                    </td>
                  </tr>
                  <tr>
                    <th style="width:120px">节目数量：</th>
                    <td >
		               ${appChannelBaseDto.programcnt}
                    </td>
                    <th style="width:120px">粉丝数量：</th>
                    <td>
		               ${appChannelBaseDto.fanscnt}
                    </td>
                  </tr>
                  <tr>
                    <th style="width:120px">小红花数量：</th>
                    <td >
		               ${appChannelBaseDto.flowercnt}
                    </td>  
                    <th style="width:120px"></th>
                    <td >
		               
                    </td>                   
                  </tr>
                  <tr>
                    <th style="width:120px">优先级：</th>
                    <td>
                      ${appChannelBaseDto.sort} 
                    </td>
					<th style="width:120px">状态：</th>
                    <td>
                      <select id="status" class="selector" name="appChannelBaseDto.status" >
                    	<option value="0">无效</option>
                    	<option value="1" >有效</option>
                    	</select>   
                    </td>               
                  </tr>
                  <tr>
                     <th>电台标识图片：</th>
                     <td colspan="3">
	                    <span id='filespan'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='200' width='200'  src="${appChannelBaseDto.channelpic }" 
	                    onclick="selectForward(this)"  />
	                    </span>
                     </td>
                  </tr>
                  <tr>
                     <th>电台背景图片：</th>
                     <td colspan="3">
	                    <span id='filespan'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='200' width='200'  src="${appChannelBaseDto.backgroundpic }"   
	                    onclick="selectForward(this)" />
	                    </span>
                     </td>
                  </tr>
                  
                  <tr class="height_70">
                    <th style="width:120px">简介：</th>
                    <td colspan="3">${appChannelBaseDto.channeldesc}</td>
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
