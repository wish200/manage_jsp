<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@taglib prefix="s" uri="/struts-tags"%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<!--主页全部的KRI指标显示-->
<title>关键风险预警指标</title>
<%@include file="/newrisk/jsp/common/taglibs.jsp"%>
<script type="text/javascript">
//--打印
function wordpress(printHTML){
    LODOP=getLodop();
    CreateOneFormPage(printHTML);
	LODOP.PREVIEW();
}
//创建一个打印预览区域
function CreateOneFormPage(printHTML){
        var style="<link href='${ctx}/newrisk/style/style.css' rel='stylesheet' />";//引用css样式
        var printHtml;//打印预览页面
        printHtml=$(".risk_form").clone();
        printHtml.find("#form_tit").removeClass('address');
	    printHtml.find('#form_thead').removeClass('address');
	    printHtml=style+printHtml.html();
        LODOP.SET_PRINT_PAGESIZE(1,3200,3200,"");
        LODOP.SET_PRINT_MODE("PRINT_PAGE_PERCENT","Auto-Width");
		LODOP.SET_PRINT_TEXT_STYLE(1,"宋体",18,1,0,0,1);
		LODOP.SET_PRINT_STYLE("Stretch",'0');
		LODOP.ADD_PRINT_HTML(5,5,"100%","100%",printHtml); 
		
};
//查询按钮
function searchKRI(){
    $('#popWindow').remove();
	$('.black_overlay').remove();
    asy_Ajax("${ctx}/newrisk/jsp/common/windKRIsearch.jsp","","html",function(data){
        $('body').append("<div id='popWindow'></div>");
		$('body').append("<div class='black_overlay'><div class='loading'></div></div>");
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
        if(indexName.length>9){
            var ff=indexName.substring(0,9);
             $("#title").html("("+ff+"...)附表列表");
             $("#title").attr("title",indexName);
        }else{
             $("#title").html("("+indexName+")附表列表");
        }
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
 //--下载
function download(printHTML){   
     var printHtml;//下载页面
     if(typeof(printHTML)!='undefined'){
        printHtml=printHTML;
     }else{
        var Copy=$(".report_form").clone();
        Copy.find("#form_thead").remove();
	    printHtml=Copy.html();
     }
     if(confirm('是否要导出到excel？')!=0)
		  { 
		   window.clipboardData.setData("Text",printHtml);
		   try
		   {
		    ExApp = new ActiveXObject("Excel.Application");
		    var ExWBk = ExApp.workbooks.add();
		    var ExWSh = ExWBk.worksheets(1);
		    ExApp.DisplayAlerts = false;
		    ExApp.visible = true;
		   }  
		   catch(e)
		   {
		    alert("导出没有成功！1.您的电脑没有安装Microsoft Excel软件！2.请设置Internet选项自定义级别，对没有标记安全级别的  ActiveX控件进行提示。");
		    return ;
		   } 
		    ExWBk.worksheets(1).Paste;
		   }else
		   { 
		   return;
	}
}
function downloadOW(){
   var printHtml=$('.risk_form');
   var printHtmlCopy=printHtml.clone();
   printHtmlCopy.find('.delDown').each(function(){
     $(this).remove();
   });
   printHtmlCopy.find("#Doing").remove();
   printHtmlCopy.find('.color').each(function(){
     var value=$(this).find("#colorValue").val();
     if(value=='G'){$(this).html("绿");}
     else if(value=='R'){$(this).html("红");}
     else if(value=='Y'){$(this).html("黄");}
     else{$(this).html("");}
   });
   printHtmlCopy.find("#form_thead").remove();
   download(printHtmlCopy.html());
} 
$(function(){
    $(window).scroll(function(){
        var scroH = $(this).scrollTop();
        if (scroH>=5){
        $("#form_tit").addClass('address').css("top",scroH-20); 
        $('#form_thead').addClass('address').css("top",scroH+49-20); 
        }else if(scroH<5){
        $("#form_tit").removeClass('address'); 
        $('#form_thead').removeClass('address');
        }
    });
});
</script>
</head>
<body id="kripage" >
<div class="box">
    <div  class="content">
        <div class="wrap_con">
            <div class="base_con">
                <div class="risk_form">
                <input id="Doing" type="hidden" value="${searchDto.doing }"/>
                   <div id="form_tit" class="form_tit" >
                        <table>
                          <tr>
                            <th id="downTitle">&nbsp;&nbsp;${searchDto.comname}关键风险预警指标(${searchDto.statDate}) </th>
                            <th width="6.3%"><div><a href="javascript:searchKRI();" title="搜索" class="search"></a></div></th>
                            <th width="6.3%"><div><a href="javascript:downloadOW();" title="下载" class="download"></a></div></th>
                            <th width="6.3%"><div><a href="javascript:wordpress();" title="打印" class="wordpress"></a></div></th>
                            <th width="6.3%"><div><a href="javascript:sendEmail();" title="发送邮件" class="mail"></a></div></th>
                          </tr>
                        </table>
                    </div>
                    <div id="form_thead" >
                        <table class="form_table">
                          <thead >
                            <tr>
                            <td width="4.8%">序号</td>
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
                            <td width="6.2%">收藏</td>
                          </tr>
                          </thead>
                      </table>
                    </div>
                    <table class="form_table">
                      <thead >
                        <tr>
                          <td width="4.8%">序号</td>
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
                            <td width="6.2%">收藏</td>
                      </tr>
                      </thead>
                      <s:iterator value="#request.indexKRIDtos" var="indexKRIDto" status="status" >
	                         <tr>
		                        <td> <s:property value="#status.index+1"/></td>
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
		                        <td class="delDown"><div><div><a target="_blank"  href="${ctx}/monitorwarn/index_getIndexDetails.do?searchDto.comCode=${searchDto.comCode}&searchDto.indexCode=<s:property value="#indexKRIDto.indexcode"/>&searchDto.statDate=<s:date name="#indexKRIDto.statdate" format="yyyyMM"/>&searchDto.fetchrate=<s:property value="#indexKRIDto.cdIndexBaseDto.fetchrate"/>" class="info">信息</a></div></div></td>
		                        <td class="delDown"><div>
		                           <s:if test='#indexKRIDto.cdIndexAttBaseDtos.size()!=0&&#indexKRIDto.cdIndexAttBaseDtos[0].attcode!=null'>
		                              <a style="cursor:pointer;"  onclick="alertIndexAtt(this,'<s:property value="#indexKRIDto.cdIndexBaseDto.indexname"/>');" class="paper-clip">
                                       </a>
                                        <ul style="display: none">
                                            <s:iterator value="#indexKRIDto.cdIndexAttBaseDtos" var="_cdIndexAttBase">
                                               <li><a target="_blank" href="${ctx}/monitorwarn/indexAtt_getIndexAtt.do?searchDto.comCode=${searchDto.comCode}&searchDto.indexCode=<s:property value="#indexKRIDto.indexcode" />&searchDto.attCode=<s:property value="#_cdIndexAttBase.attcode" />&searchDto.attType=<s:property value="#_cdIndexAttBase.atttype" />&searchDto.statDate=<s:date name="#indexKRIDto.statdate" format="yyyyMM"/>&searchDto.compareType=M"  ><s:property value="#_cdIndexAttBase.attname" />_<s:property value="#indexKRIDto.statdate.month+1" />月    (本年环比) </a></li>
                                                <li><a target="_blank" href="${ctx}/monitorwarn/indexAtt_getIndexAtt.do?searchDto.comCode=${searchDto.comCode}&searchDto.indexCode=<s:property value="#indexKRIDto.indexcode" />&searchDto.attCode=<s:property value="#_cdIndexAttBase.attcode" />&searchDto.attType=<s:property value="#_cdIndexAttBase.atttype" />&searchDto.statDate=<s:date name="#indexKRIDto.statdate" format="yyyyMM"/>&searchDto.compareType=Y"  ><s:property value="#_cdIndexAttBase.attname" />_(历史同比)</a></li>
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
        </div>
    </div>
</div>
<div class=" footer">版权所有 中国人民财产保险股份有限公司</div>
</body>
</html>
