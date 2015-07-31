<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
var publicURL;//全局url地址变量
/* 左边菜单*/
$(function(){
	/*二级菜单*/
	$("#nav li[class!='newone']").mouseover(function(){
		$(this).find('.tow_nav').fadeIn(100);
	});
	$("#nav li[class!='newone']").mouseleave(function(){
	
		$(this).find('.tow_nav').fadeOut(100);
	});
	/*三级菜单*/
	$(".tow_nav li").mouseover(function(){
		$(this).find('.three_nav').fadeIn(100);
	});
	$(".tow_nav li").mouseleave(function(){
		$(this).find('.three_nav').fadeOut(100);
	});	
	/*四级菜单*/
	$(".three_nav li").mouseover(function(){
		$(this).find('.four_nav').fadeIn(100);
		});
	$(".three_nav li").mouseleave(function(){
		$(this).find('.four_nav').fadeOut(100);
	});
	var oneNA=$("#nav").find(".one_na").size();
	if(oneNA<7){
	   $(".tow_nav_last").attr("class","tow_nav");
	   var tempHtml="";
		 for(var i=oneNA;i<7;i++){
		       tempHtml+="<li class='newone'></li>";
		 }
	  $("#nav").append(tempHtml);
	  $(".newone").css("background","none");
	  $(".newone:hover").css("background","none");
	}
});
$(function(){
	if($(window).height()<$(".one_le").size()*80+60){
	    $(".sidebar").css("padding-top","0px");
	}
});

//--菜单点击
function clickmenu(data,menuUrl,addressName){
    searchDiv();
    $(window).unbind("scroll");
    publicURL=menuUrl;
    window.scrollTo(0,0);
    try{
		if(editStuts==1){
           editStuts=0;
        }
	}catch(e){
	}
	//--点击以后菜单加背景。
	$('.sidebar ul li').removeClass("active");
	$(data).parents("li[class='one_le']").addClass("active");
	
	//--地址栏显示名称
    asy_Ajax(menuUrl,"",'html',function(result){
        document.getElementById("content").innerHTML="";
		$("#content").html(result);
		//--地址栏显示名称
		$("#addressBar").html($(data).next("input").val());
		$("#addressBar").parent('div').show();
    });
}
</script>
<!--主页面--菜单页面-->
<div class="sidebar">
    <ul id="nav">
         <c:set var="flag">1</c:set>
         <c:set var="flag1">1</c:set>
          <s:if test="#session.userLogin.newdepcode=='201206252219430687ggtij'
                                ||#session.userLogin.newdepcode=='2012062522194900935s6ml'||#session.userLogin.newdepcode=='20120625221937093756pw0'||#session.userLogin.newdepcode=='201206252219380671ms6mg'
                                ||#session.userLogin.newdepcode=='2012062522193808591akt4'">
        <!--   是不是合规部   20120625221937093756pw0  再保险部  2012062522194900935s6ml 财务会计部门 201206252219430687ggtij 资金运营部 201206252219380671ms6mg 精算吧 2012062522193808591akt4-->
                                
               <c:set var="flag1">2</c:set>
           </s:if>
        <s:iterator value="#session.ccMenuDtos" var="ccMenuDto" >
            <s:if test="#ccMenuDto.menulevel==1">
                <!-- 一级菜单 -->
                <li class="one_le">
                    <a   class="<s:property value="#ccMenuDto.remark" /> one_na"><s:property value="#ccMenuDto.menuname" /></a>
                    <s:if test="#ccMenuDto.havesubmenu==1">
                        <div 
                        <s:if test="#ccMenuDto.menuname=='系统设置管理'">class="tow_nav tow_nav_last"</s:if>
                        <s:else>class="tow_nav"</s:else>
                         >
                        <div class="top"></div>
                        <ul>
                            <s:iterator  value="#session.ccMenuDtos"  var="twoCcMenuDto" >
	                                  <s:if test="#twoCcMenuDto.menuid=='M0405000'"> <!-- 数据采集报送--模型数据 -->
	                                    <c:set var="flag">2</c:set>
	                                  </s:if>
	                                  <s:else>
	                                    <c:set var="flag">3</c:set>
	                                  </s:else>
                                    <c:if test="${flag==3||(flag==2&&flag1==2)}">
		                                 <s:if test="#twoCcMenuDto.parentmenuid==#ccMenuDto.menuid">
		                                    <!-- 二级菜单 --> 
		                                        <!-- 如果有子菜单加上小箭头 --> 
		                                     <li 
		                                     <s:if test="#twoCcMenuDto.havesubmenu==1">
		                                      class="three_li" 
		                                      </s:if>
		                                      > 
		                                     <a   <s:if test='#twoCcMenuDto.menuurl!=null&&!"".equals(#twoCcMenuDto.menuurl)'>  onclick="clickmenu(this,'${ctx}<s:property value="#twoCcMenuDto.menuurl" />');"  style="cursor:pointer"     </s:if> >  <s:property value="#flag" /><s:property value="idddd" /><s:property value="%{idddd}" /><s:property value="#twoCcMenuDto.menuname" /></a>
			                                   <input type="hidden" value="<s:property value="#twoCcMenuDto.fullmenuname" />"/>
			                                     <s:if test="#twoCcMenuDto.havesubmenu==1">
			                                        <div 
			                                        <s:if test="#ccMenuDto.menuname=='系统设置管理'">class="three_nav threee_nav_last"</s:if>
		                                            <s:else>class="three_nav"</s:else>
			                                         >
								                            <div class="top"></div>
								                            <ul>
								                                   <s:iterator value="#session.ccMenuDtos" var="threeCcMenuDto">
									                                    <s:if test="#threeCcMenuDto.parentmenuid==#twoCcMenuDto.menuid"> 
									                                      <!-- 三级菜单 --> 
									                                       <li
									                                          <s:if test="#threeCcMenuDto.havesubmenu==1">
										                                      class="three_li" 
										                                      </s:if>
									                                       >
									                                       <a <s:if test='#threeCcMenuDto.menuurl!=null&&!"".equals(#threeCcMenuDto.menuurl)'> onclick="clickmenu(this,'${ctx}<s:property value="#threeCcMenuDto.menuurl" />');"  style="cursor:pointer" </s:if> ><s:property value="#threeCcMenuDto.menuname" /></a>
									                                       <input type="hidden" value="<s:property value="#threeCcMenuDto.fullmenuname" />"/>
									                                        <s:if test="#threeCcMenuDto.havesubmenu==1">
									                                        <div class="four_nav">
										                                        <div class="top"></div>
										                                        <ul>
										                                         <s:iterator value="#session.ccMenuDtos" var="fourCcMenuDto">
									                                                <s:if test="#fourCcMenuDto.parentmenuid==#threeCcMenuDto.menuid"> 
									                                                <!-- 四级菜单 --> 
										                                            <li><a <s:if test='#fourCcMenuDto.menuurl!=null&&!"".equals(#fourCcMenuDto.menuurl)'> onclick="clickmenu(this,'${ctx}<s:property value="#fourCcMenuDto.menuurl" />');"  style="cursor:pointer" </s:if>  ><s:property value="#fourCcMenuDto.menuname" /></a>
										                                            <input type="hidden" value="<s:property value="#fourCcMenuDto.fullmenuname" />"/>
										                                            </li>
										                                            </s:if>
										                                         </s:iterator>
										                                        </ul>
										                                        <div class="bottom"></div>
										                                        <i></i>
										                                    </div>
										                                    </s:if>
									                                       </li>
									                                    </s:if> 
								                                   </s:iterator>
								                            </ul>
								                               <div class="bottom"></div>
								                            <i></i>
								                        </div>
			                                     </s:if>
		                                     </li>
		                                 </s:if> 
	                                 </c:if>
                                
                             </s:iterator>
                        </ul>
                        <div class="bottom"></div>
                        <i></i>
                        </div>
                    </s:if>
                </li>
            </s:if>
        </s:iterator>
     </ul>
 </div> 
 
