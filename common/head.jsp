<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
 
<div>
<script type="text/javascript">
function getUrl(ajaxUrl){
    asy_Ajax(ajaxUrl,"","html",function(data){
        $("body").html(data);
    });
}
//修改密码
function updatePass(ajaxUrl){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/jsp/common/passwordSet.jsp","","html",function(data){
         $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'></div>");
	   	 $('#popWindow').html(data);
    });
}
//我的收藏夹
function favorite(ajaxUrl){
    var url="${ctx }/monitorwarn/index_getHaveDivList.do";
    var data={
    'searchDto.returnUrl':"/common/login_login.do"
    };
    asy_Ajax("${ctx }/monitorwarn/index_getHaveDivList.do",data,"html",function(data){
	   	 $('#content').html(data);
	   	 $("#addRessDiv").hide();
    });
}
function headpage(){
    $(window).unbind("scroll");
    window.location='${ctx}/common/login_login.do';
    
}
</script>
</div>
<!--主页面--头部页面-->
  <div class="header">
  	<h1 class="logo" style="float:left;margin-left:20px;">
      	<a title="绘听网络信息平台">
      	<img src="${pageContext.request.contextPath}/images/login_logo_1.png" width="254"  height="29" alt="logo" />
      	</a>
      </h1>
     
      <div class="top_nav">
       
      	<div class="tool">
          	  <a href="javascript:headpage()" class="home" title="首页"></a>
              <!--<a href="javascript:favorite()" class="cdollect" title="收藏夹"></a>
              -->
              <a href="javascript:updatePass()" class="site" title="设置"></a>
              <a href="${ctx }/common/login_logout.do" class="quit" title="退出"></a>
          </div>
           <div class="user" style="text-align:right;">欢迎您：${session.userLogin.username} </div>
      </div>
  </div>
