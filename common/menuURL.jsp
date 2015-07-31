<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>菜单展现</title>
        <%@include file="/newrisk/jsp/common/temptaglibs2.jsp"%>
        <link href="${ctx}/newrisk/resource/styles/left.css" rel="stylesheet" />
        <script type="text/javascript">
            //左侧导航
            $(function() {
             var titleName='${searchDto.menuname}';
                //左侧菜单
                $('.menuDiv').find('dd,span,li a').hover(function() {
                    $(this).toggleClass('hover');
                });
				//一级菜单没有子节点
                $('.menuDiv dd').click(function() {
                  var oneMenu=$(this).find('a').html();
                  /* var oneUrl=$(this).find('a').attr('href'); */
                  var param="?oneMenu="+oneMenu+"&titleName="+titleName+" &gt";
                  window.parent['framePathName'].location.href="${ctx}/common/menu_pathTitle.do"+param;
                   $(this).siblings('dt,dd').slideDown();
                   $('.menuDiv a').removeClass('active');
                   $('.menuDiv').find('a,span,dt,dd').removeClass('active');
                   $(this).addClass('active');
                   $('.menuDiv').find('ul').slideUp();
                });
                
                $('.menuDiv dt a').click(function() {
                    var twoMenu=$(this).html();
                    /* var twoMenuUrl=$(this).attr('href'); */
                    var oneMenu=$(this).parents('ul').prev().text();
                    /* var threeMenu=$(this).parents('ol').prev().text(); */
                    /* var threeUrl=$(this).parents('ol').prev().find('a').attr('href'); */
                    var param;
                    /* if(threeMenu!=''){
                       param="?oneMenu="+oneMenu+"&twoMenu= &gt"+twoMenu+"&threeMenu="+threeMenu+"&titleName="+titleName+" &gt";
                    }else */ 
                    if(oneMenu==''){
                       param="?twoMenu="+twoMenu+"&titleName="+titleName+" &gt";
                    }else{
                       param="?twoMenu= &gt"+twoMenu+"&oneMenu="+oneMenu+"&titleName="+titleName+" &gt";
                    }
                     if ($(this).parent('li').length) {
                        $(this).next('ol').slideToggle();
                    } else {
                        $(this).next('ul').slideToggle();
                    }
                    window.parent['framePathName'].location.href="${ctx}/common/menu_pathTitle.do"+param;
                    $('.menuDiv').find('a,span,dd').removeClass('active');
                    $(this).addClass('active');
                });
                
                $('.menuDiv dt span').click(function() {
                    $(this).parent().toggleClass('active');
                    $(this).parent().siblings().removeClass('active');
                    $(this).parent().siblings('dt').find('ul').slideUp();
                    if ($(this).parent('li').length) {
                        $(this).next('ol').slideToggle();
                    } else {
                        $(this).next('ul').slideToggle();
                    }
                }); 
                $('.menuDiv dt li h1').click(function() {
                    $(this).addClass('color');
                    $(this).parent().siblings('dt').find('ul').slideUp();
                    if ($(this).parent('li').length) {
                        $(this).next('ol').slideToggle();
                    } else {
                        $(this).next('ul').slideToggle();
                    }
                }); 
                var ht=$('a:first').attr("href");
                window.parent['frameContent'].location.assign(ht);
            });
        </script>
    </head>
    <body>
        ${menuUrl }
        <!--子导航-->
        <div class="menuDiv">
            <dl>
                <s:iterator value="menuMap.get(2)" id="_ccMenuBaseDto">
                    <s:if test="#_ccMenuBaseDto.havesubmenu==0&&#_ccMenuBaseDto.menulevel==2">
                        <dd>
                        	<!-- 一级目录，并且不包含子节点 -->
                            <a href="${ctx}<s:property value="#_ccMenuBaseDto.menuurl"/>" target="frameContent"> 
                            	<s:property value="#_ccMenuBaseDto.menuname" /> 
                            </a>
                        </dd>
                    </s:if>
                    <s:elseif test="#_ccMenuBaseDto.havesubmenu==1&&#_ccMenuBaseDto.menulevel==2">
                        <dt>
                            <span>
                            	<!-- 一级目录，并且包含子节点 -->
                            	<s:if test="%{#_ccMenuBaseDto.menuurl!=null&&#_ccMenuBaseDto.menuurl!=''}">
                            	<a href="${ctx }<s:property value="#_ccMenuBaseDto.menuurl"/>" target="frameContent">
                            		<s:property value="#_ccMenuBaseDto.menuname" />
                            	</a>
                            	 </s:if>
                            	 <s:else>
                            	    <s:property value="#_ccMenuBaseDto.menuname" />
                            	 </s:else>
                            </span>
                            <ul class="clearfix">
                                <s:iterator value="menuMap.get(3)" var="_ccMenuBaseDto2">
                                    <s:if test="%{#_ccMenuBaseDto2.parentmenuid==#_ccMenuBaseDto.menuid&&#_ccMenuBaseDto2.havesubmenu==0}">
                                        <li>
                                        	<!-- 二级目录，并且不包含子节点 -->
                                            <a href="${ctx}<s:property value="#_ccMenuBaseDto2.menuurl"/>" target="frameContent"> 
                                                <s:property value="#_ccMenuBaseDto2.menuname" /> 
                                            </a>
                                        </li>
                                    </s:if>
                                    <s:elseif  test="%{#_ccMenuBaseDto2.parentmenuid==#_ccMenuBaseDto.menuid&&#_ccMenuBaseDto2.havesubmenu==1}">
                                        <li>
                                        		<!-- 二级目录，并且包含子节点 -->
                                        		<s:if test="%{#_ccMenuBaseDto2.menuurl!=null&&#_ccMenuBaseDto2.menuurl!=''}">
                                        		<h1 >
                                        		 <a href="${ctx}<s:property value="#_ccMenuBaseDto2.menuurl"/>" target="frameContent">
                                                  <s:property value="#_ccMenuBaseDto2.menuname" /> 
                                                 </a>
                                                </h1>
                                                </s:if>
                                            <ol>
                                                <s:iterator value="menuMap.get(4)" var="_ccMenuBaseDto3">
                                                    <s:if  test="%{#_ccMenuBaseDto3.parentmenuid==#_ccMenuBaseDto2.menuid}">
                                                        <li>
                                                        		<!-- 三级目录 -->
                                                            <a  href="${ctx}<s:property value="#_ccMenuBaseDto3.menuurl"/>"  target="frameContent">
                                                                <s:property  value="#_ccMenuBaseDto3.menuname" />
                                                            </a>
                                                        </li>
                                                    </s:if>
                                                </s:iterator>
                                            </ol>
                                        </li>
                                    </s:elseif>
                                </s:iterator>
                            </ul>
                        </dt>
                    </s:elseif>
                </s:iterator>
            </dl>

 
        </div>
    </body>
</html>