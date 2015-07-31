<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-查看 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/js/introduce/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/js/common/app.js"></script>
<script type="text/javascript">
$("#userForm").find('input,select,textarea').attr('disabled',true);
//--发布按钮
function keep(){
	  $("#userForm").find('input,select,textarea').attr('disabled',false);
	  $("#userForm").ajaxSubmit({
	          type : 'post',  
	          url : '${ctx}/user/user_send.do',  
	          error: function(XmlHttpRequest, textStatus, errorThrown){  
	               alert( "系统错误");  
	          },
	          success: function(data){
	               alert("发布成功");
	               asy_Ajax("${ctx}/user/user_getList.do",{},'html',function(data){
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

		
$("#sex").val("${appUserBaseDto.sex }");
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
          <form id="userForm" method="post">    
           
                <table class="school_task">
                 <tr>
                    <th style="width:120px">用户ID：</th>
                    <td >
		               ${appUserBaseDto.userid}
                    </td>
                    <th style="width:120px">用户昵称：</th>
                    <td>
		               ${appUserBaseDto.nickname }
                    </td>
                  </tr>
                  <tr>
                    <th style="width:120px">生日：</th>
                    <td >
		               ${appUserBaseDto.birthday}
                    </td>
                    <th style="width:120px">性别：</th>
                    <td>
		               <select id="sex" class="selector" name="appUserBaseDto.sex">
                    	<option value="1">男</option>
                    	<option value="2" >女</option>
                    	<option value="0">保密</option>
                    	</select>
                    </td>
                  </tr>
                  <tr>
                    <th style="width:120px">真实姓名：</th>
                    <td >
		               ${appUserBaseDto.realname}
                    </td>
                    <th style="width:120px">电话：</th>
                    <td>
		               ${appUserBaseDto.phonenumber }
                    </td>
                  </tr>
                  <tr>
                    <th style="width:120px">微信：</th>
                    <td >
		               ${appUserBaseDto.weixin}
                    </td>
                    <th style="width:120px">QQ：</th>
                    <td>
		               ${appUserBaseDto.qq }
                    </td>
                  </tr>
                  <tr>
                    <th style="width:120px">email：</th>
                    <td >
		               ${appUserBaseDto.mail}
                    </td>
                    <th style="width:120px">创建时间：</th>
                    <td>
		               ${appUserBaseDto.createtime }
                    </td>
                  </tr>
                   <tr>
                     <th>图片地址：</th>
                     <td colspan="3">
		               ${appUserBaseDto.userpic}
                    </td>
                  </tr>
                  <tr>
                     <th>头像图片：</th>
                     <td colspan="3">
	                    <span id='filespan'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='200' width='200'  src="${appUserBaseDto.userpic }" 
	                    onclick="selectForward(this)"  />
	                    </span>
                     </td>
                  </tr>
                  <tr>
                     <th>背景图片地址：</th>
                     <td colspan="3">
		               ${appUserBaseDto.backgroundpic}
                    </td>
                  </tr>
                  <tr>
                     <th>背景图片：</th>
                     <td colspan="3">
	                    <span id='filespan'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='200' width='200'  src="${appUserBaseDto.backgroundpic }"   
	                    onclick="selectForward(this)" />
	                    </span>
                     </td>
                  </tr>
                  
                  <tr class="height_70">
                    <th style="width:120px">简介：</th>
                    <td colspan="3">${appUserBaseDto.description}</td>
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
