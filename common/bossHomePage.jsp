<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<!--总裁 主页面-->
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/newrisk/jsp/common/temptaglibs2.jsp"%>
<script src="${ctx}/newrisk/resource/js/riskjs/selectTime.js"></script>
<script type="text/javascript">
$(function(){
	changeBtn();//按钮切换
	asy_Ajax('${ctx}/common/login_getAllIndex.do',{},function(data){
		$('#AllKRIShowDiv').html(data);
	});
	asy_Ajax('${ctx}/common/login_getHomeKRI.do',{},function(data){
		$('#KRIShowDiv').html(data);
	});
	allKRIIndex();
	KRIIndex();
});
function changeBtn(){//按钮切换
	  $('#AllKRIIndex').attr('class','btnMod').css('color',"");
	  $('#KRIIndex').attr('class','cbtnMod').css('color',"black");
}
function allKRIIndex(html){//全集指标
	  $('#AllKRIIndex').click(function(){
	      $(this).attr('class','btnMod').css('color',"");
	      $('#KRIIndex').attr('class','cbtnMod').css('color',"black");
	      $('#AllKRIShowDiv').show();
	      $('#KRIShowDiv').hide();
	      window.onscroll=function(){
	    		var top;
	    		if(document.documentElement&&document.documentElement.scrollTop){
	    		      top=document.documentElement.scrollTop;
	    	    }else if(document.body){
	    	          top=document.body.scrollTop;
	    	    }
	    	    if(top>$('#AllKRIShowDiv').offset().top+$('#searchDIv').height()+1){
	    	       $('#fixed').show();
	    	    }else{
	    	       $('#fixed').hide();
	    	    }
	    	};
	  });
}
function KRIIndex(html){//KRI主指标
	$('#KRIIndex').click(function(){
	      $(this).attr('class','btnMod').css('color',"");
	      $('#AllKRIIndex').attr('class','cbtnMod').css('color',"black");
	      $('#KRIShowDiv').show();
	      $('#AllKRIShowDiv').hide();
	      window.onscroll=function(){
	    		var top;
	    		if(document.documentElement&&document.documentElement.scrollTop){
	    		      top=document.documentElement.scrollTop;
	    	    }else if(document.body){
	    	          top=document.body.scrollTop;
	    	    }
	    	    if(top>$('#KRIShowDiv').offset().top+$('#searchDIv').height()+1){
	    	       $('#fixed2').show();
	    	    }else{
	    	       $('#fixed2').hide();
	    	    }
	    	};
	});
}
function asy_Ajax(url,data,successfm){
    $.ajax({
        url :url,
        type : 'POST',
        data :data,
        dataType : 'html',
        error : function() {
            alert('系统错误。请与管理员联系');
        },
        success :successfm
    }); 
}

</script>
</head>
<body class="indexBg">

<div class="indexMain" >
  
    <div class="indexMode" >
       <div style="margin-left:1%;">
	         <br/>
		     <br/>
		     <br/>
		     <br/>
		    <div class="fullScreen">
			    <p>
				    <input id="AllKRIIndex" type="button" value="全指标表" class="btnMod" />&nbsp;&nbsp;&nbsp;
				    <input id="KRIIndex" type="button" value="KRI指标表" class="btnMod" />
			    </p>
		    </div>
	   </div>
	   <!-- KRI页面显示 -->
        <div id="AllKRIShowDiv" style="position:relative;width:1000px;float:left;margin-top:10px;">
          <div style="position:absolute;top:50%; left:45%;margin-top:20%;">
            <b><span style="font-size:14px;">系统正在加载，请稍后.....</span></b><img src="${ctx}/risk/images/window_loading.gif" alt="正在加载。。" />
          </div>
        </div>
       <!-- KRI页面显示 -->
       
       <!-- KRI页面显示 -->
        <div id="KRIShowDiv" style="display:none;position:relative;width:1000px;float:left;margin-top:10px;">
          <div style="position:absolute;top:50%; left:45%;margin-top:20%;">
            <b><span style="font-size:14px;">系统正在加载，请稍后.....</span></b><img src="${ctx}/risk/images/window_loading.gif" alt="正在加载。。" />
          </div>
        </div>
       <!-- KRI页面显示 -->
    </div>
</div>
<div class="showbox"  style="position:fixed">
        <h2>附表列表<a class="close" href="#">关闭</a></h2>
        <div class="mainlist">
            <ul>
                <li><span>▪</span><a href="http://www.17sucai.com/" target="_blank">用jquery特效制作左侧侧边浮动导航菜单滑动显示或隐藏</a></li>
            </ul>
        </div>
    </div>
</body>
</html>
