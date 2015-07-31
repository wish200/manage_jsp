<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@taglib prefix="s" uri="/struts-tags"%>
<div>
<script type="text/javascript" src="${ctx}/newrisk/js/introduce/json2.js"></script>
<script type="text/javascript" src="${ctx}/newrisk/js/introduce/Raphael.js"></script>
    <!--主页面--指标值表格-->
<script type="text/javascript">
var flashDate='${flashData}';
var width=20;//高度
var height=20;//宽度
var offset=50;//偏移
var offsetDown=60;//偏移
var alt=3;//圆半径
$(function(){
	    $("#container").html("");
        var flashdata='${flashData}'; 
        var data=JSON.parse(flashdata);
        var container = document.getElementById("container") ;
        var paper = Raphael(container, 300,300);
        var rowsg=10;//绿色的排数
        var clsg=11;//绿色偏移的排数
        var colerg="#71cfa2";//绿色
        var downg=0;//
        rectGrren(paper,rowsg,clsg,colerg,downg);
        var rowsy=7;//黄色的排数
        var clsy=8;//黄色偏移的排数
        var colery="#eac85d";//黄色
        var downy=3;
        rectGrren(paper,rowsy,clsy,colery,downy);
        var rowsr=4;//红色的排数
        var clsr=4;//红色偏移的排数
        var colerr="#e97458";//红色
        var downr=6;
        rectGrren(paper,rowsr,clsr,colerr,downr);
        //修补绿色
        var rowSg=4;
        var clsSg=4;
        var downSg=3;
        var rightSg=4;
        rectGrren22(paper,rowSg,clsSg,colerg,downSg,rightSg);
        //修补黄色
        var rowSy=2;
        var clsSy=2;
        var downSy=6;
        var rightSy=2;
        rectGrren22(paper,rowSy,clsSy,colery,downSy,rightSy);
          paper.text(160,20,"全集指标热力图").attr({"font-weight":"bold","font-size":"18px","fill":"#000000"});
        paper.text(offset-10, rowsg*height-rowsr/2*height+offsetDown,"红").attr({"font-size":"12px"});
        paper.text(offset-10, rowsg*height-rowsr*height-(rowsy-rowsr)/2*height+offsetDown,"黄").attr({"font-size":"12px"});
        paper.text(offset-10, rowsg*height-rowsy*height-(rowsg-rowsy)/2*height+offsetDown,"绿").attr({"font-size":"12px"});
        
        paper.text(offset+clsr/2*width,height*rowsg+10+offsetDown,"红").attr({"font-size":"12px"});
        paper.text(offset+clsy*width-clsr/2*width,height*rowsg+10+offsetDown,"黄").attr({"font-size":"12px"});
        paper.text(offset+clsg*width-(clsg-clsy)/2*width,height*rowsg+10+offsetDown,"绿").attr({"font-size":"12px"});
        
        var coler;//1代表红色区域,2代表huan
        var rx,ry;
        var zNodes=new Array();
        var zNodesR=new Array();
        var zNodesG=new Array();
        var zNodesY=new Array();
        for(var i=0;i<data.length;i++){
            var kk=0;
            if(data[i].color=='R'){//红
                coler=1;
            }else if(data[i].color=='G'){
                coler=3;
            }else  if(data[i].color=='Y'){
                coler=2;
            }else{
                continue;
            }
            if(data[i].indexvalue!=null&&data[i].indexvalue!='--'){
                kk=data[i].indexvalue;
            }
             if(coler==1){
                var flag=true;
                while(flag){
                    ry=height*downr+Math.random()*height*rowsr;
                    rx=Math.random()*width*clsr;
                    if(rx>(width*rightSy)&&ry<height*(downr+rightSy)){
                    }else{
                        rx=rx>alt*2?((width*clsr-rx>alt*2)?rx:width*clsr-alt*2):alt*2;//最边上的数据处理
                        ry=ry-height*downr>alt*2?height*(downr+rowsr)-ry<alt*2?height*(downr+rowsr)-alt*2:ry:height*downr+alt*2;
                        var flag1=true;
                        for(var ri=0;ri<zNodesR.length;ri++){
                            if(zNodesR[ri].x-rx>-alt*2&&zNodesR[ri].x-rx<alt*2&&zNodesR[ri].y-ry>-alt*2&&zNodesR[ri].y-ry<alt*2){
                                flag1=false;
                            }
                        }
                        if(flag1){
                             var date={x:rx,y:ry,name:data[i].cdIndexBaseDto.indexname+kk};
                             zNodes.push(date);
                             zNodesR.push(date);
                            flag=false;
                        };
                    }
                }
            }
            if(coler==2){//黄色区域
                var flag=true;
                while(flag){
                    ry=height*downy+Math.random()*height*rowsy;
                    rx=Math.random()*width*clsy;
                    if(rx>ry||rx<ry-4*width){
                    }else{
                       
                        rx=rx>alt*2?width*clsy-rx>alt*2?rx:width*clsy-alt*2:4;//最边上的数据处理
                        ry=rowsg*height-ry>alt*2?ry-height*downy>alt*2?ry:height*downy+alt*2:height*rowsg-alt*2;
                        var flag1=true;
                        for(var ri=0;ri<zNodesY.length;ri++){
                            if(zNodesY[ri].x-rx>-alt*2&&zNodesY[ri].x-rx<alt*2&&zNodesY[ri].y-ry>-alt*2&&zNodesY[ri].y-ry<alt*2){
                                flag1=false;
                            }
                        }
                        if(flag1){
                             var date={x:rx,y:ry,name:data[i].cdIndexBaseDto.indexname+kk};
                             zNodes.push(date);
                             zNodesY.push(date);
                            flag=false;
                        };
                    }
                }
            }
            if(coler==3){//绿色区域
                var flag=true;
                while(flag){
                    ry=height*downg+Math.random()*height*rowsg;
                    rx=Math.random()*width*clsg;
                    if(rx<ry+width){
                    }else{
                        rx=rx>alt*2?clsg*width-rx>alt*2?rx:clsg*width-alt*2:alt*2;//最边上的数据处理
                        ry=ry>alt*2?height*rowsg-ry>alt*2?ry:height*rowsg-alt*2:alt*2;
                        var flag1=true;
                        for(var ri=0;ri<zNodesG.length;ri++){
                            if(zNodesG[ri].x-rx>-alt*2&&zNodesG[ri].x-rx<alt*2&&zNodesG[ri].y-ry>-alt*2&&zNodesG[ri].y-ry<alt*2){
                                flag1=false;
                            }
                        }
                        if(flag1){
                             var date={x:rx,y:ry,name:data[i].cdIndexBaseDto.indexname+kk};
                             zNodes.push(date);
                             zNodesG.push(date);
                            flag=false;
                        };
                    }
                }
            }
        }
        var c1;
        for(var i=0;i<zNodes.length;i++){
            c1=paper.circle(zNodes[i].x+offset,zNodes[i].y+offsetDown,alt).attr({"stroke":"#4F4F4F","fill":"#4F4F4F"});
            c1.name=zNodes[i].name;
            c1.mouseover(function(){
                var x = this.attr("cx") ;
                var y = this.attr("cy") ;
                this.attr({"r":8,"stroke":"#ffffff","fill":"#f00"});
                this.text = this.paper.text(160,42,this.name).attr({"stroke":"#297fc3","font-size":"13px"}) ;
//              this.circle1=paper.circle(x,y,10).attr({"stroke":"#ffffff","fill":"#f00"});
                
            }) ;
            c1.mouseout(function(){
                    this.text.hide();
                    this.attr({"r":alt,"stroke":"#4F4F4F","fill":"#4F4F4F"});
//                  this.circle1.hide();
            }) ;
        } 
});
//画方块
function rectGrren(paper,rows,clss,coler,down){
    for(var row=0;row<rows;row++){
        for(var cls=0;cls<clss;cls++){
             paper.rect(height*cls+offset,width*(row+down)+offsetDown, height,width).attr({"fill":coler,"stroke-width":"1","stroke":"#fff"});
        }
     }
}

function rectGrren22(paper,rows,clss,coler,down,right){
    for(var row=0;row<rows;row++){
        for(var cls=0;cls<clss;cls++){
            if(cls>=row){
                 paper.rect(height*(cls+right)+offset,width*(row+down)+offsetDown, height,width).attr({"fill":coler,"stroke-width":"1","stroke":"#fff"});
            }
        }
    }

} 

//查询按钮
function searchKRI(){
    closePopWind();
    asy_Ajax("${ctx}/newrisk/jsp/common/windAllIndexSearch.jsp","","html",function(data){
        $("body").append("<div id='popWindow'><div>");
        $("#popWindow").append(data);
    });
}
//添加收藏
function divLike(data,indexCode){
    var _class=$(data).attr("class");
    var _ajaxData={'ccDivBaseDto.indexcode':indexCode};
    if(_class=='like-no'){
        if(confirm("是否收藏?")){
             asy_Ajax('${ctx}/monitorwarn/index_addDiv.do',_ajaxData,'html',function(){
                $(data).removeClass('like-no'); 
                $(data).addClass('like');
             });
        }
    }else{
         if(confirm("是否取消收藏?")){
             asy_Ajax('${ctx}/monitorwarn/index_removeDiv.do',_ajaxData,'html',function(){
                $(data).removeClass('like');
                $(data).addClass('like-no'); 
             });
         }
    }
}
//弹出附表对话框
function alertIndexAtt(data,indexName){
     closePopWind();
    asy_Ajax("${ctx}/newrisk/jsp/monitorwarn/windIndexArrt.jsp",'',"html",function(ajaxData){
        $("body").append("<div id='popWindow'><div>");
        $("#popWindow").append(ajaxData);
        $("#schedule_list").html($(data).next('ul').html());
         $("#title").html("("+indexName+")附表列表");
    });  
}
//邮件发送
function sendEmail(){
    if(confirm("确认发送给${session.userLogin.email}?")){
	    var statDate='${searchDto.statDate}';
	    alert("邮件发送成功！");
	    asy_Ajax('${ctx}/monitorwarn/index_sendEmail.do',{'searchDto.statDate':statDate},'html',function(){
	    });
    }
}
function downloadOW(){
    var printHtml=$('.form_table').eq(1);
   var printHtmlCopy=printHtml.clone();
   
   printHtmlCopy.find("a").remove();
   printHtmlCopy.find("br").remove();
   printHtmlCopy.find("span").remove();
   printHtmlCopy.find('.color').each(function(){
     var value=$(this).find("#colorValue").val();
     if(value=='G'){$(this).html("绿");}
     else if(value=='R'){$(this).html("红");}
     else if(value=='Y'){$(this).html("黄");}
     else{$(this).html("--");}
   });
   var title=$("#downTitle").html();
   download(printHtmlCopy.prop("outerHTML"),title);
  /*  var printHtml=$('.report_form');
   var printHtmlCopy=printHtml.clone();
   printHtmlCopy.find("#form_tit").removeClass('address');
   printHtmlCopy.find('#form_thead').removeClass('address');
   printHtmlCopy.find('.delDown').each(function(){
     $(this).remove();
   });
   printHtmlCopy.find(".kri").remove();
   printHtmlCopy.find('.color').each(function(){
     var value=$(this).find("#colorValue").val();
     if(value=='G'){$(this).html("绿");}
     else if(value=='R'){$(this).html("红");}
     else if(value=='Y'){$(this).html("黄");}
     else{$(this).html("");}
   });
   printHtmlCopy.find("#form_thead").remove();
   download(printHtmlCopy.html()); */
} 
//打印
function wordpressOWA(){
   var printHtml=$('#AKRI');
   var printHtmlCopy=printHtml.clone();
   printHtmlCopy.find("#form_tit").removeClass('address');
   printHtmlCopy.find('#form_thead').removeClass('address');
   wordpress(printHtmlCopy.html());
}
$(function(){
//表头固定
     var width=$("#AKRI>table").width();
    $(window).unbind("scroll");
    $(window).scroll(function(){
         var scroH = $(window).scrollTop();
         var navH = $(".report_form").offset().top; 
         if(scroH>0){
            $("#AKRI #form_tit").css({"position":"fixed","top":navH-scroH+"px","width":width}).show();
        	$("#AKRI #form_thead").css({"position":"fixed","top":navH-scroH+49+"px","width":width}).show();
         }else{
            if($("#AKRI").scrollTop()<=0){
            $("#AKRI #form_tit").css({"position":"static"});
        	$("#AKRI #form_thead").css({"position":"fixed"}).hide();
            }else{
            $("#AKRI #form_tit").css({"position":"fixed","top":navH+"px","width":width}).show();
        	$("#AKRI #form_thead").css({"position":"fixed","top":navH+49+"px","width":width}).show();
        	}
         }
    });
    $("#AKRI").unbind("scroll");
    $("#AKRI").scroll(function(){
        var scroH = $(this).scrollTop();
        var navH = $(".report_form").offset().top; 
        var widthArray = new Array();
        if (scroH>=5){
        	$("#AKRI>table thead tr td").each(function(){
        		 widthArray.push($(this).width());
        	});
        	for(var i=0;i<widthArray.length;i++){
        		$("#AKRI #form_thead").find("td").eq(i).width(widthArray[i]);
        	}
        	if($(window).scrollTop()>0){
        	$("#AKRI #form_tit").css({"position":"fixed","top":navH-$(window).scrollTop()+"px","width":width}).show();
        	$("#AKRI #form_thead").css({"position":"fixed","top":navH-$(window).scrollTop()+49+"px","width":width}).show();
        	}else{
        	$("#AKRI #form_tit").css({"position":"fixed","top":navH+"px","width":width}).show();
        	$("#AKRI #form_thead").css({"position":"fixed","top":navH+49+"px","width":width}).show();
        	}
        }else{
        	$("#AKRI #form_tit").css({"position":"static"});
        	$("#AKRI #form_thead").css({"position":"fixed"}).hide();
        }
    });
});
//--查看全部
function checkIndexALL(){
     window.open("${ctx}/common/login_getAllIndex.do?searchDto.doing=more");
}
</script >
</div>
  <div class="report_form" style="margin-top:-40px;position:relative">
       <div class="kri" style="float:left;width:26%;height:293px;">
	       	<!-- <h2 style="margin-left:80px;margin-top:20px">全集指标热力图</h2> -->
	           <div id="container" style="position:relative;float:left;text-align: center;height:293px;padding-top: 10px">
	           </div>
       </div>
       <div id="AKRI" style="position:relative;float:left;width:72.5%;height:293px;overflow-y:scroll;overflow-x:hidden;margin:0;padding:0;">
                    <div id="form_tit" class="form_tit">
                        <table>
                          <tr>
                            <th id="downTitle" >&nbsp;&nbsp;全集指标(${searchDto.statDate}) &nbsp;&nbsp;&nbsp;</th>
                            <th width="6.3%"><div><a href="javascript:checkIndexALL();" title="查看全部" class="open"></a></div></th>
                            <th width="6.3%"><div><a href="javascript:searchKRI();" title="搜索" class="search"></a></div></th>
                            <th width="6.3%"><div><a href="javascript:downloadOW();" title="下载" class="download"></a></div></th>
                            <th width="6.3%"><div><a href="javascript:wordpressOWA();" title="打印" class="wordpress"></a></div></th>
                            <th width="6.3%"><div><a href="javascript:sendEmail();" title="发送邮件" class="mail"></a></div></th>
                          </tr>
                        </table>
                    </div>
                     
                    <div id="form_thead" >
                        <table class="form_table">
                          <thead >
                            <tr>
                            <td width="6.8%">序号</td>
                            <td width="4.8%">预警</td>
                            <td width="9.5%">一级风险</td>
                            <td width="10.5%">二级风险</td>
                            <td width="19.2%">指标名称</td>
                            <td width="9.8%">累计值</td>
                            <td width="9.8%">同比值</td>
                            <td width="9.8%">环比值</td>
                            <td width="5.1%">更新频率</td>
                            <td width="5.4%">详细信息</td>
                            <td width="5.2%">附表</td>
                            <td>收藏</td>
                          </tr>
                          </thead>
                      </table>
                    </div>
                    <table class="form_table">
                      <thead >
                        <tr>
                          <td width="6.8%">序号</td>
                            <td width="4.8%">预警</td>
                            <td width="9.5%">一级风险</td>
                            <td width="10.5%">二级风险</td>
                            <td width="19.2%">指标名称</td>
                            <td width="9.8%">累计值</td>
                            <td width="9.8%">同比值</td>
                            <td width="9.8%">环比值</td>
                            <td width="5.1%">更新频率</td>
                            <td width="5.4%">详细信息</td>
                            <td width="5.2%">附表</td>
                            <td>收藏</td>
                      </tr>
                      </thead>
                      <s:iterator value="#request.indexKRIDtos" var="indexKRIDto" status="status">
	                         <tr>
		                        <td><s:property value="#status.index+1"/></td>
		                        <td class="color">
		                        <input id="colorValue" value="${indexKRIDto.color}" type="hidden"/>
                                <s:if test='"R".equals(#indexKRIDto.color)'> <div class="alert_red" ></div></s:if>
                                <s:elseif test='"G".equals(#indexKRIDto.color)'><div class="alert_green" ></div></s:elseif>
                                <s:elseif test='"Y".equals(#indexKRIDto.color)'><div class="alert_yellow" ></div></s:elseif>
                                <s:else>--</s:else></td>
		                        <td><s:property value="#indexKRIDto.cdIndexBaseDto.lev1riskname"/> </td>
		                        <td> <s:property value="#indexKRIDto.cdIndexBaseDto.lev2riskname"/></td>
		                        <td   style="padding-left:10px;text-align: left;"><s:property value="#indexKRIDto.cdIndexBaseDto.indexname"/></td>
		                        <td>${indexKRIDto.indexvalue}</td>
		                        <td>${indexKRIDto.lyearvalue}</td>
		                        <td>${indexKRIDto.lmonvalue}</td>
		                        <td><s:if test='#indexKRIDto.cdIndexBaseDto.fetchrate.equals("M")'>月度
                                </s:if><s:elseif test='#indexKRIDto.cdIndexBaseDto.fetchrate.equals("Q")'> 季度
                                </s:elseif><s:elseif test='#indexKRIDto.cdIndexBaseDto.fetchrate.equals("H")'>半年
                                </s:elseif><s:elseif test='#indexKRIDto.cdIndexBaseDto.fetchrate.equals("Y")'>年度
                                </s:elseif></td>
		                        <td class="delDown"><div><div><a target="_blank"  href="${ctx}/monitorwarn/index_getIndexDetails.do?searchDto.indexCode=<s:property value="#indexKRIDto.indexcode"/>&searchDto.statDate=<s:date name="#indexKRIDto.statdate" format="yyyyMM"/>&searchDto.fetchrate=<s:property value="#indexKRIDto.cdIndexBaseDto.fetchrate"/>')" class="info">信息</a></div></div></td>
		                        <td class="delDown"><div>
		                           <s:if test='#indexKRIDto.cdIndexAttBaseDtos.size()!=0&&#indexKRIDto.cdIndexAttBaseDtos[0].attcode!=null'>
		                              <a style="cursor:pointer;"  onclick="alertIndexAtt(this,'<s:property value="#indexKRIDto.cdIndexBaseDto.indexname"/>');" class="paper-clip">
                                       </a>
                                        <ul style="display: none">
                                            <s:iterator value="#indexKRIDto.cdIndexAttBaseDtos" var="_cdIndexAttBase">
                                               <li><a target="_blank" href="${ctx}/monitorwarn/indexAtt_getIndexAtt.do?searchDto.indexCode=<s:property value="#indexKRIDto.indexcode" />&searchDto.attCode=<s:property value="#_cdIndexAttBase.attcode" />&searchDto.attType=<s:property value="#_cdIndexAttBase.atttype" />&searchDto.statDate=<s:date name="#indexKRIDto.statdate" format="yyyyMM"/>&searchDto.compareType=M"  ><s:property value="#_cdIndexAttBase.attname" />_<s:property value="#indexKRIDto.statdate.month+1" />月    (本年环比) </a></li>
                                                <li><a target="_blank" href="${ctx}/monitorwarn/indexAtt_getIndexAtt.do?searchDto.indexCode=<s:property value="#indexKRIDto.indexcode" />&searchDto.attCode=<s:property value="#_cdIndexAttBase.attcode" />&searchDto.attType=<s:property value="#_cdIndexAttBase.atttype" />&searchDto.statDate=<s:date name="#indexKRIDto.statdate" format="yyyyMM"/>&searchDto.compareType=Y"  ><s:property value="#_cdIndexAttBase.attname" />_(历史同比)</a></li>
                                            </s:iterator>
                                        </ul>
                                    </s:if>
		                        </div></td>
		                        <td><div><a style="cursor:pointer;"  onclick="divLike(this,'<s:property value="#indexKRIDto.indexcode" />');" <s:if test="#request.searchDto.haveDivs.lastIndexOf(#indexKRIDto.indexcode)!=-1"> class="like"</s:if><s:else> class="like-no" </s:else>></a></div></td>
	                         </tr>
                      </s:iterator>
                    </table>
                    </div>
   </div> 
      <!--右侧浮动-->
<div class="right_float2" style="height:110px;bottom:40px">
	<ul>
    	<li>
        	<a href="javascript:KRIIndex()">关键指标</a>
        </li>
        <li>
        	<a href="javascript:allIndex()">全集指标</a>
        </li>
    </ul>
</div>             
         