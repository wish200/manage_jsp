<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-查看 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/js/introduce/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/js/common/app.js"></script>
<script type="text/javascript">
$("#commentForm").find('input,select,textarea').attr('disabled',true);
//--发布按钮
function keep(){
	  $("#commentForm").find('input,select,textarea').attr('disabled',false);
	  $("#commentForm").ajaxSubmit({
	          type : 'post',  
	          url : '${ctx}/comment/comment_send.do',  
	          error: function(XmlHttpRequest, textStatus, errorThrown){  
	               alert( "系统错误");  
	          },
	          success: function(data){
	               alert("发布成功");
	               asy_Ajax("${ctx}/comment/comment_getList.do",{},'html',function(data){
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
		
		
$("#commentstatus").val("${appCommentBaseDto.commentstatus }");
$("#modular").val("${appCommentBaseDto.modular }");
</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;评论信息</th>
                    </tr>
                  </table>
                </div>
          <form id="commentForm" method="post">    
            <!--新生成的公告代码-->
				    <input id="commentid" name="appCommentBaseDto.commentid" 
				    value="${appCommentBaseDto.commentid }" type="hidden" />
                <table class="school_task">
                 <tr>
                    <th style="width:120px">评论ID：</th>
                    <td colspan="3">
		               ${appCommentBaseDto.commentid}
                    </td>
                    
                  </tr>
                  <tr>
                    <th style="width:120px">评论用户ID：</th>
                    <td >
		               ${appCommentBaseDto.concerneduserid}
                    </td>
                    <th style="width:120px">用户昵称：</th>
                    <td>
		               ${appCommentBaseDto.concernednickname}
                    </td>
                  </tr>
                  <tr>
                     <th>用户头像地址：</th>
                     <td>
		               ${appCommentBaseDto.concerneduserpic}
                    </td>
                  </tr>
                  <tr>
                     <th>用户头像：</th>
                     <td colspan="3">
	                    <span id='filespan'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='200' width='200'  src="${appCommentBaseDto.concerneduserpic }" 
	                    onclick="selectForward(this)"  />
	                    </span>
                     </td>
                  </tr>
                  
                  <tr>
                  	<th style="width:120px">模块：</th>
                    <td>
                      <select id="modular" class="selector" name="appCommentBaseDto.modular" >
                    	<option value="1">看图说话</option>
                    	<option value="2" >听听画画</option>
                    	<option value="3" >自说自话</option>
                    	</select>   
                    </td> 
                    <th style="width:120px">业务号：</th>
                    <td >
		               ${appCommentBaseDto.busiid}
                    </td>
                     
                  </tr>
                  <tr>
                    <th style="width:120px">评论时间：</th>
                    <td >
		               ${appCommentBaseDto.commenttime}
                    </td>
                    <th style="width:120px">状态：</th>
                    <td>
                      <select id="commentstatus" class="selector" name="appCommentBaseDto.commentstatus" >
                    	<option value="0">无效</option>
                    	<option value="1" >有效</option>
                    	</select>   
                    </td>  
                  </tr>
                   
                  
                  <tr class="height_70">
                    <th style="width:120px">评论内容：</th>
                    <td colspan="3">${appCommentBaseDto.commenttext}</td>
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
