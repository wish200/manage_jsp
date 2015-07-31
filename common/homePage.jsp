<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%@include file="/jsp/common/taglibs.jsp"%>
<head>
<!--主页面-->

<title>绘听网络信息平台</title>
<meta http-equiv="X-UA-Compatible" content="IE=9"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="${ctx }/images/title.jpg"
    type="/x-icon" />

<script type="text/javascript"><!--

     $(function() {
        $(window).unbind("scroll");
        //--岗位代码
        var deppositioncode = "${session.userLogin.ccDepPositionBaseDto.deppositioncode}";
        //--任务和公告
        asy_Ajax("${ctx}/common/login_getHomePage.do", "", 'html', function(
                data) {
            $("#taskNotice").html(data);
        });
        //--如果是总裁的话。
        if (deppositioncode == 'DP0000001') {
            //--全集指标
            asy_Ajax("${ctx}/common/login_getHomeKRI.do", "", 'html',
                    function(data) {
                        $("#kripage").html(data);
                    });
            //--不需要显示菜单条。
            $(".content").css("margin-left", "0px");
        } else {
            $(".content").css("margin-left", "120px");
            //--KRI主指标
            var data = {
                'searchDto.statDate' : '${searchDto.statDate}'
            };
            //asy_Ajax("${ctx}/common/login_getHomeKRI.do", data, 'html',
             //       function(data) {
            //            $("#kripage").html(data);
             //       });
        }

    });  
    function getPage(ajaxUrl){
       publicURL=ajaxUrl;
        asy_Ajax(encodeURI(ajaxUrl),{},'html',function(data){
               window.scrollTo(0,0);
               $(window).unbind("scroll");
               $("#content").html(data);
        });
    }
    //--窗口关闭
function searchDiv(){
     $('#popWindow').remove();
     $('.black_overlay').remove();
}
    
--></script>
</head>
<body>
    <div class="box">
        <form style="display: none" id="fromHtmlData"  action="${ctx}/common/exl_getDownloadFile.do" method="post">
             <input id="kHtmlDataTitle" name="htmlTitle" value="" />
             <input id="kHtmlData" name="htmlData" value="" />
       </form>
        <!--引入菜单页面-->
        <s:include value="/jsp/common/menu.jsp"></s:include>
       
        <div class="content">
            <div class="wrap_con">
                <!--引入head页面-->
                <s:include value="/jsp/common/head.jsp"></s:include>
                <!--地址栏-->
                <div id="addRessDiv"
                    style="height:36px;margin-top:0px;background:#f5f8fb;display:none">
                    <span
                        style="height:20px; padding:10px 15px 0 10px; font-size:14px; color:#3a8fc8; line-height:30px;"
                        id="addressBar"></span>
                </div>
                <div class="base_con" id="content">
                    <!--引入公告和任务页面-->
                    <div id="taskNotice">
                        <%--     <s:include value="/jsp/common/taskNotice.jsp"></s:include> --%>
                    </div>
                    <!--引入KRI表页面-->
                    <div id="kripage"></div>
                    <%--                 <s:include value="/jsp/common/homeKRI.jsp"></s:include>
 --%>
                </div>
            </div>
        </div>
    </div>
    <div style="padding-top:35px"></div>
    <div class="footer"
        style="position:fixed;z-index:999;bottom:0px;width:100%;height:32px">版权所有
        ${Copyright}</div>
</body>
</html>
