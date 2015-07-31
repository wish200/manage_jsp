<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
 <head>
  <title> play</title>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <style type="text/css">
[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak,.ng-hide{display:none !important;}
ng\:form{display:block;}.ng-animate-block-transitions{transition:0s all!important;-webkit-transition:0s all!important;}</style>
   <%@include file="/jsp/common/taglibs.jsp"%>
   <link rel="stylesheet" href="${ctx}/jsp/program/js/player.css" type="text/css">
   <link rel="stylesheet" href="${ctx}/jsp/program/js/huiting.css" type="text/css">
    
    
    
    
            <script  type="text/javascript" src="${ctx}/jsp/program/js/jquery-1.10.1.min.js"></script>
            <script type="text/javascript" src="${ctx}/jsp/program/js/jquery.jplayer.js"></script>
           <script type="text/javascript" src="${ctx}/jsp/program/js/jplayer.cleanskin.js"></script>
	
   <script type="text/javascript">
                $(document).ready(function(){
                    $(document).find('.webPlayer').each(function() { $('#'+this.id).videoPlayer(); });
                });
            </script>
 </head>

<% String path = request.getParameter("path");
String name = request.getParameter("name");
System.out.println("1----"+path+"-"+name);

%>	
 
    
<body style="">
	 <div class="mainBox ng-scope" ng-view="" style="width:80%; overflow: hidden; height: auto;">
	    <div class="carouseTitle fontYaHei clearfix ng-scope">
	     <div class="left"><a href="#">绘听</a>
	    	<span ng-bind-html="from_band" class="ng-binding"></span>
	    	 
			<a href="#" class="ng-binding">故事</a>
			<span class="noArrow ng-binding">好听的故事</span>
	    </div>
	   </div>
	<div >
	
	
	
	<div style="width:50%;height:300px;border:black 1px solid;  position:relative; ">
		<img style="position:absolute;left:0px;top:0px;width:100%;height:100%; border:1px solid blue" src="/htmanage/images/title.jpg" />
	</div>

<div  id="demoAudio1" STYLE="2px solid #6699cc"  border:black 10px solid;><div>
  <div id="uniquePlayer-41" class="webPlayer  light audioPlayer">
   <div id="uniqueContainer-42" class="videoPlayer"></div>
    <div style="display:none;" class="playerData"> {
                  "name": "<%=name %>",
                  "size": {
                  "width": "515px" },
                  "backgroundColor":"#0000FF",
                  "media": {
                  "mp3": "<%=path %>"
                  }
                  } </div>
  </div>
            </div>
	
	
	
	
<div class="desc fontYaHei ng-scope" ng-if="data.audio.desc">
		<div class="divider"></div>
		<div class="desText">
			介绍: 
				<div style="white-space: pre-line; padding-left: 15px;" class="ng-binding">
				【绘听】人生,从绘色启蒙, 从聆听开始, 让陪伴成为一种习惯, 会说会画绘听 孩子成长的必需品。

				</div>
		</div>
	</div><!-- end ngIf: data.audio.desc -->

	</div>
 

</body></html>