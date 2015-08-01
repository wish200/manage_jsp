<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-查看 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/js/introduce/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/js/common/app.js"></script>
<script type="text/javascript">
$("#noticeForm").find('input,select,textarea').attr('disabled',true);
//--发布按钮
function keep(){
	  $("#picbookForm").find('input,select,textarea').attr('disabled',false);
	  $("#picbookForm").ajaxSubmit({
	          type : 'post',  
	          url : '${ctx}/picbook/picbook_send.do',  
	          error: function(XmlHttpRequest, textStatus, errorThrown){  
	               alert( "系统错误");  
	          },
	          success: function(data){
	               alert("发布成功");
	               asy_Ajax("${ctx}/picbook/picbook_getList.do",{},'html',function(data){
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


$("#picbooksource").val("${appPicbookBaseDto.picbooksource }");
$("#picbookstatus").val("${appPicbookBaseDto.picbookstatus }");
</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;绘图信息</th>
                    </tr>
                  </table>
                </div>
          <form id="picbookForm" method="post">    
            <!--新生成的公告代码-->
				    <input id="picbookid" name="appPicbookBaseDto.picbookid" 
				    value="${appPicbookBaseDto.picbookid }" type="hidden" />
                <table class="school_task">
                 <tr>
                    <th style="width:120px">绘图ID：</th>
                    <td colspan="3">
		               ${appPicbookBaseDto.picbookid}
                    </td>
                  </tr>
                  
                  <tr>
                    <th style="width:120px">名称：</th>
                    <td style="width:450px">
		               ${appPicbookBaseDto.picbookname }
                    </td>
                    <th style="width:120px">发布时间：</th>
                    <td>
                      ${appPicbookBaseDto.uploadtime } 
                    </td>
                  </tr>
                  <tr>
                    <th style="width:120px">所属用户：</th>
                    <td style="width:450px">
		               ${appPicbookBaseDto.userid}
                    </td>
                    <th style="width:120px">用户昵称：</th>
                    <td>
                      ${appPicbookBaseDto.nickname } 
                    </td>
                  </tr>
                  
                  <tr>
                    <th style="width:120px">来源：</th>
                    <td style="width:450px">
		              <select id="picbooksource" name="appPicbookBaseDto.picbooksource" readonly>
		               	<option value="1">看图说话</option>
                    	<option value="2">听听画画</option>
                    	<option value="3">自说自话</option>
		               </select>
                    </td>
                    <th style="width:120px">状态：</th>
                    <td>
                      <select id="picbookstatus" class="selector" name="appPicbookBaseDto.picbookstatus" >
                    	<option value="0">无效</option>
                    	<option value="1" >有效</option>
                    	</select>   
                    </td>
                  </tr>
                  <tr>
                    <th style="width:120px">小红花：</th>
                    <td style="width:450px">
		               ${appPicbookBaseDto.flowercnt }
                    </td>
                   
                  </tr>
                  
                   <tr>
                     <th>图片：</th>
                     <td colspan="3">
	                    <span id='filespan'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appPicbookBaseDto.picbookurl }" onclick="selectForward(this)"   />
	                    </span>
                     </td>
                  </tr>
                  
                  <tr class="height_70">
                    <th style="width:120px">场景：</th>
                    <td colspan="3">${appPicbookBaseDto.picscene}</td>
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
