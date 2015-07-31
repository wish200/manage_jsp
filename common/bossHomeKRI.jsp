<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<!--总裁 主页面-KRI显示页面-->
<title>主页</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/newrisk/jsp/common/temptaglibs2.jsp"%>
 <%@include file="/newrisk/jsp/common/print.jsp"%><!--引入打印预览 -->
<script src="${ctx}/newrisk/resource/js/FusionCharts.js"></script> 
<script type="text/javascript" src="${ctx }/newrisk/resource/js/json2.js"></script>
<script src="${ctx}/newrisk/resource/js/Raphael.js"></script> 
<script src="${ctx}/newrisk/resource/js/PopleReport.js"></script> 
<script type="text/javascript">
$(function(){
    addTime(6,"#yeard","#monthd");
    tdFixedCopy2();
    var dd='${flashData}'; 
    var jsond=JSON.parse(dd);
    $(".u322_normal1").click(function(){
                var html=$(this).html();
                $(".showbox").animate({top:150,opacity:'show',width:250,height:220,right:400},500);
                $("body").prepend("<div class='mask'></div>");
                $('.mainlist').html(html);
                $(".mask").css({opacity:"0.5"}).css("height",'');
                $(".timeout").click(function(){
				  $("body").append("<div id='blackO' class='black_overlay'><div style='position:fixed;top:55%; left:40%;background-color: fffff'> 系统正在加载，请稍后.....<img src='../risk/images/timeout.gif' height='40' width='40' alt='正在加载。。' /></div></div>");
				  $(".black_overlay").height($(document).height());
		          $(".black_overlay").show(); 
	            });	
                return false;
           });
            $(".timeout").click(function(){
				  $("body").append("<div id='blackO' class='black_overlay'><div style='position:fixed;top:55%; left:40%;background-color: fffff'> 系统正在加载，请稍后.....<img src='../risk/images/timeout.gif' height='40' width='40' alt='正在加载。。' /></div></div>");
				  $(".black_overlay").height($(document).height());
		          $(".black_overlay").show(); 
	        });	
            $(".showbox .close").click(function(){
                $(this).parents(".showbox").animate({top:0,opacity: 'hide',width:0,height:0,right:0},500);
                $(".mask").fadeOut("fast");
            });
         /**收藏*/
	     $("div[name=DIVc]").click(function(){
	                         var className= $(this).attr("class");
	                         var indexCode=$(this).find('input').val();
	                         var data={
	                             'ccDivBaseDto.indexcode':indexCode
	                         };
	                         if(className=='u006_normal'){
	                             if(confirm("是否收藏?")){
	                             $(this).attr("class","u005_normal");
	                             asy_Ajax('${ctx}/monitorwarn/index_addDiv.do',data,function(){});
	                             return true;
	                             }
	                         }else{
	                             if(confirm("是否取消收藏?")){
	                             $(this).attr("class","u006_normal");
	                             asy_Ajax('${ctx}/monitorwarn/index_removeDiv.do',data,function(){});
	                             return true;
	                             }
	                         }
	                });
	            $('#bossHomeKRi .search a.a_sea').click(function(){
		     		$(this).find('i').toggleClass('active');
		     		$('#bossHomeKRi .searchCont').slideToggle();	
		     	});
            var con = document.getElementById("container") ;
            var bubble = new Bubble(con , 400 , 400) ;
            bubble.render(jsond) ;

});
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
function BossHomeKRICheck(){//查询功能
	var statDate=$('#yeard').val()+$('#monthd').val();
	var _this = $('#bossHomeKRi .btnSearch');
	if(statDate==''||statDate==null){
		  alert("请选择数据期次！");
		  return false;
	}
	_this.val('查询中...').addClass('btnDis').attr('disabled', 'disabled');
    asy_Ajax('${ctx}/common/login_getHomeKRI.do',{'searchDto.statDate':statDate},function(data){
		$('#KRIShowDiv').html(data);
	});
	setTimeout(function() {
		$('#bossHomeKRi .searchCont').slideUp(function() {
			$('#bossHomeKRi .search a.a_sea').find('i').removeClass('active');
			_this.val('查询').removeClass('btnDis').removeAttr('disabled');
		});
	}, 2000);
}
function BossHomeExcelDown(){//下载功能
     var printDiv=$('#printBossHomeKRIDiv');//旧的对象
     var copyPrintDiv=printDiv.clone();//复制的对象
     copyPrintDiv.find("input,a").remove();
     copyPrintDiv.find('.u322_normal1').remove();
     tableToExcel(copyPrintDiv);
}
function  tdFixedCopy2(){//表头固定
    var tdwidth=$('#bossHomeKRi .tdTitle').find('td');
    for(var i=0;i<tdwidth.size();i++){
       tdwidth.eq(i).attr("width",tdwidth.eq(i).width()); 
    } 
	var table='<div style="padding:10px;"><table id="fixed2" style="position:fixed;z-index:999;top:0;display:none" class="tabBasic tab_bg" cellpadding="0" cellspacing="0">';
	var tr=$('#bossHomeKRi .title')[0].outerHTML+$('#bossHomeKRi .tdTitle')[0].outerHTML;
    var entable='</table></div>';
    $('#bossHomeKRi').append(table+tr+entable);
 };
  //发送邮件
function sendEmailKRI(){
 var statDate='${searchDto.statDate}';
 alert("发送成功！");
 asy_Ajax('${ctx}/monitorwarn/index_sendEmailKPI.do',{'searchDto.statDate':statDate},'html',function(){
 });
}
</script>
</head> 
       <div id="bossHomeKRi">
      <!--查询条件DIV-->
	       <div id="searchDIv" class="search" style="width:97.8%;margin:auto;">
            <h2>
                <a class="a_sea active">查询</a>
                <a href="javascript:BossHomeExcelDown();" class="a_down"> 下 载 </a>
                <a href="javascript:OnePrint('printBossHomeKRIDiv');" class="a_print">打 印</a>
                <a href="javascript:sendEmailKRI();" class="a_send">发送邮件</a>
            </h2>
            <div class="searchCont">
                <table class="tabSearch" width="100%" cellpadding="0" cellspacing="0" >
                    <tr>
                           <td width="100" align="right">数据期次：</td>
                           <td >
                               <select width="75px"  id="yeard" >
                                   <option value="">请选择</option>
                               </select>年
                                <select width="75px" id="monthd">
                                   <option value="">请选择</option>
                               </select>月
                           </td>
                           <td class="searchBot">
	                           <input onclick="BossHomeKRICheck()"  class="btn btnSearch" type="button" value="查&nbsp;询" />
                           </td>
                        </tr>
                </table>
            </div>
          </div>
       <div id="printBossHomeKRIDiv">
         	<table id="tabBasic1" class="tabBasic"  style="width:97.9%;margin:auto;margin-top:10px;">
                	<tr class="title"  name="fixedHead"  > 
	                	<td colspan="14">
	                       KRI指标表<s:if test="#request.indexKRIDtos.size>0">
	                    <span style="font-size:12px;color:#993333">（<s:date name="#request.indexKRIDtos[0].statdate" format="yyyyMM"/>）</span>
	                    </s:if>
	                    </td> 
                     </tr>
                    <tr class="tdTitle" name="fixedHead">
                        <td width="26px" style="white-space:nowrap;" >序号</td>
                        <td width="28px" style="white-space:nowrap;" >预警</td>
                        <td width="105px" style="white-space:nowrap;" >一级风险</td>
                        <td width="118px" style="white-space:nowrap;" >二级风险</td>
                        <td width="221px" style="white-space:nowrap;" >指标名称</td>
                        <td width="54px" style="white-space:nowrap;" >累计值</td>
                        <td width="54px" style="white-space:nowrap;" >同比值</td>
                        <td width="53px" style="white-space:nowrap;" >环比值</td>
                        <td width="53px" style="white-space:nowrap;" >更新频率</td>
                        <td width="78px" style="white-space:nowrap;" >指标详细信息</td>
                        <td  width="29px" style="white-space:nowrap;" >附表</td>
                        <td width="28px"  style="white-space:nowrap;" >收藏</td>
                    </tr>
					
					<s:iterator value="#request.indexKRIDtos" var="indexKRIDto" status="status">
                        <tr>
                            <td > <s:property value="#status.index+1"/> </td>
                            <td  class="tdCenter">
                                  <div style="display: none"><s:if test='"R".equals(#indexKRIDto.color)'>红</s:if><s:elseif test='"G".equals(#indexKRIDto.color)'>绿</s:elseif><s:elseif test='"Y".equals(#indexKRIDto.color)'>黄</s:elseif></div>
                                <s:if test='"R".equals(#indexKRIDto.color)'>
                                    <div class="u008_normal"/>
                                    
                                </s:if>
                                <s:elseif test='"G".equals(#indexKRIDto.color)'>
                                    <div class="u00G_normal"/>
                                </s:elseif>
                                <s:elseif test='"Y".equals(#indexKRIDto.color)'>
                                                    <div class="u001_normal"/>
                                                </s:elseif>
                                                <s:else>
                                                   --
                                                </s:else>
                            </td>
                            <td align="left"><s:property value="#indexKRIDto.cdIndexBaseDto.lev1riskname"/></td>
                            <td align="left"> <s:property value="#indexKRIDto.cdIndexBaseDto.lev2riskname"/> </td>
                            <td align="left"> <s:property value="#indexKRIDto.cdIndexBaseDto.indexname"/> </td>
							<td>
                                     ${indexKRIDto.indexvalue}
                            </td>
                             <td>
                                     ${indexKRIDto.lyearvalue}
                            </td>
                            <td>
                                    ${indexKRIDto.lmonvalue}
                            </td> 
							<td>
                                <s:if test='#indexKRIDto.cdIndexBaseDto.fetchrate.equals("M")'>
                                    月度
                                </s:if>
                                <s:elseif test='#indexKRIDto.cdIndexBaseDto.fetchrate.equals("Q")'>
                                    季度
                                </s:elseif>
                                <s:elseif test='#indexKRIDto.cdIndexBaseDto.fetchrate.equals("H")'>
                                    半年
                                </s:elseif>
                                <s:elseif test='#indexKRIDto.cdIndexBaseDto.fetchrate.equals("Y")'>
                                    年度
                                </s:elseif>
                            </td>
                            <td  class="tdCenter">
                                <a class="timeout" href="${ctx}/monitorwarn/index_getIndexDetails.do?searchDto.indexCode=<s:property value="#indexKRIDto.indexcode"/>&searchDto.statDate=<s:date name="#indexKRIDto.statdate" format="yyyyMM"/>&searchDto.fetchrate=<s:property value="#indexKRIDto.cdIndexBaseDto.fetchrate"/>">
                                    <div class="u321_normal"></div>
                                </a>
                            </td>
                            <td  class="tdCenter">
                                <s:if test='#indexKRIDto.cdIndexAttBaseDtos.size()!=0&&#indexKRIDto.cdIndexAttBaseDtos[0].attcode!=null'>
                                    <div class="u322_normal1">
                                        <span></span>
                                        <ul>
                                            <s:iterator value="#indexKRIDto.cdIndexAttBaseDtos" var="_cdIndexAttBase">
                                                <li style="word-break:keep-all;overflow:hidden;"><a class="timeout" href="${ctx}/monitorwarn/indexAtt_getIndexAtt.do?searchDto.indexCode=<s:property value="#indexKRIDto.indexcode" />&searchDto.attCode=<s:property value="#_cdIndexAttBase.attcode" />&searchDto.attType=<s:property value="#_cdIndexAttBase.atttype" />&searchDto.statDate=<s:date name="#indexKRIDto.statdate" format="yyyyMM"/>&searchDto.compareType=M"  > <s:property value="#_cdIndexAttBase.attname" /><s:property value="#indexKRIDto.cdIndexBaseDto.indexname"/>_<s:property value="#indexKRIDto.statdate.month+1" />月    (本年环比) </a></li>
                                                <li><a class="timeout" href="${ctx}/monitorwarn/indexAtt_getIndexAtt.do?searchDto.indexCode=<s:property value="#indexKRIDto.indexcode" />&searchDto.attCode=<s:property value="#_cdIndexAttBase.attcode" />&searchDto.attType=<s:property value="#_cdIndexAttBase.atttype" />&searchDto.statDate=<s:date name="#indexKRIDto.statdate" format="yyyyMM"/>&searchDto.compareType=Y"  ><s:property value="#_cdIndexAttBase.attname" /><s:property value="#indexKRIDto.cdIndexBaseDto.indexname"/>_(历史同比)</a></li>
                                            </s:iterator>
                                        </ul>
                                    </div>
                                    </s:if>
                            </td>
                            <td  class="tdCenter">
                                <s:if test="#request.searchDto.haveDivs.lastIndexOf(#indexKRIDto.indexcode)!=-1">
                                    <a><div name="DIVc" class="u005_normal"><input style="display: none"  value="<s:property value="#indexKRIDto.indexcode"/>"/></div> </a> 
                                </s:if>
                                <s:else>
                                    <a> <div  name="DIVc" class="u006_normal"><input style="display: none"  value="<s:property value="#indexKRIDto.indexcode"/>"/></div> </a>
                                </s:else>
                            </td>
                        </tr>
                        
                    </s:iterator>
                   
                    <tr>
                        <td colspan="14" style="font-size: 15px">KRI主指标分布图 </td>
                    </tr>
                    <tr>
                        <td  colspan="14" id="container">
                        </td>
                    </tr>
				</table>
				</div>
              </div>                   
        </html>