<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-查看 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/js/introduce/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/js/common/app.js"></script>
<script type="text/javascript">
$("#firstpageForm").find('input,select,textarea').attr('disabled',true);
//--发布按钮
function keep(){
	  $("#firstpageForm").find('input,select,textarea').attr('disabled',false);
	  $("#firstpageForm").ajaxSubmit({
	          type : 'post',  
	          url : '${ctx}/firstpage/firstpage_send.do',  
	          error: function(XmlHttpRequest, textStatus, errorThrown){  
	               alert( "系统错误");  
	          },
	          success: function(data){
	               alert("发布成功");
	               asy_Ajax("${ctx}/firstpage/firstpage_getList.do",{},'html',function(data){
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
		
		
$("#status").val("${appFirstPageBaseDto.status }");
</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;启动页图片信息</th>
                    </tr>
                  </table>
                </div>
          <form id="firstpageForm" method="post">    
            <!--新生成的公告代码-->
				    <input id="id" name="appFirstPageBaseDto.id"  value="${appFirstPageBaseDto.id }" type="hidden" />
                <table class="school_task">
                 <tr>
                    <th style="width:120px">评论ID：</th>
                    <td colspan="3">
		               ${appFirstPageBaseDto.id}
                    </td>
                    
                  </tr>
                  
                  <tr>
                     <th>图片地址：</th>
                     <td colspan="3">
		               ${appFirstPageBaseDto.picurl}
                    </td>
                  </tr>
                  <tr>
                     <th>图片：</th>
                     <td colspan="3">
	                    <span id='filespan'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='200' width='200'  src="${appFirstPageBaseDto.picurl }" 
	                    onclick="selectForward(this)"  />
	                    </span>
                     </td>
                  </tr>
                   
                  <tr>
                    <th style="width:120px">评论时间：</th>
                    <td >
		               ${appFirstPageBaseDto.createtime}
                    </td>
                    <th style="width:120px">状态：</th>
                    <td>
                      <select id="status" class="selector" name="appFirstPageBaseDto.status" >
                    	<option value="0">无效</option>
                    	<option value="1" >有效</option>
                    	</select>   
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
