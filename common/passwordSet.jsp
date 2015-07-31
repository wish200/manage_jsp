<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--修改密码页面(弹出窗口)-->

<%@include file="/jsp/common/tempTaglibs.jsp"%>
<!--以下页面的js操作-->
<script src="${ctx}/js/introduce/MD5.js"></script> 
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
<%--窗口关闭--%>
function closeDiv(){
	 $('#popWindow').remove();
	 $('.black_overlay').remove();	
}
function subBtn(){
    var oldPass=$.trim($('#oldPass').val());
    var password='${session.userLogin.password}';
    var hash = hex_md5(oldPass);
    var pass2=$('#pass2').val();
    var pass1=$('#pass1').val();
    var ok=haveData("oldPass", "旧密码不能为空！")
		 &&haveData("pass1", "新密码不能为空！")
		 &&haveData("pass2", "确认密码不能为空！");
    if(ok){
		     if(hash!=password){
		       alert("旧密码不正确！");
		     }else if(pass2!=pass1){
		       alert("两次密码不一样！");
		     }else{
		       $('#Aform').submit();
		     }
    }
}
//帮助文档下载
function help(name){
     window.location="${ctx}/common/login_help.do?searchDto.helpname="+encodeURI(name);
}
</script>
  <div class="searchpop_big" style="background:0;padding-top:0px;margin-top:-30px;padding-left:20px">
  <div class="title" style="">修改密码<a href="javascript:closeDiv()" title="关闭" class="close"></a></div>
  	<div class="con" style="width:520px;">
   	         <div class="ostyle" style="text-align:center"> 
  	          <form id="Aform" action="${ctx }/common/login_ediPassWord.do" method="post">
	  	         <table style="width:50%;margin:auto;padding-top:20px;">
	  	         <tr>
	  	           <td>旧密码:</td>
	  	           <td><input id="oldPass" type="password" maxLength=10 style="width:140px;"><br/></td>
	  	         </tr>
	  	         <tr>
	  	           <td>新密码:</td>
	  	           <td><input id="pass1" name="ccUserDto.password" type="password" style="width:140px;" maxLength=10><br/></td>
	  	         </tr>
	  	         <tr>
	  	           <td> 确认新密码:</td>
	  	           <td><input id="pass2" type="password" style="width:140px;"><br/></td>
	  	         </tr>
	  	         </table>
	  	         </form>
  	         </div> 
             <a href="javascript:subBtn()"  class="define">确&nbsp;定</a> 
    </div>
   
    <div class="bottom" style="width:520px;padding:8px 0 0 41px;"></div>
  </div>