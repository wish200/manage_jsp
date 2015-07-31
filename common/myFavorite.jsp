<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--收藏夹-->

<div><!--存放js-->
<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript">
headerFixed();//表格表头固定
//--查询页面
function searchPage(){
    $('#popWindow').remove();
    $('.black_overlay').remove();
    asy_Ajax("${ctx}/newrisk/jsp/common/windSearchMyF.jsp",{},'html',function(data){
	   	 $('body').append("<div id='popWindow'></div>");
	   	 $('body').append("<div class='black_overlay'></div>");
	   	 $('#popWindow').html(data);
	});  
}
//返回首页
function returnUrl(){
      window.location='${ctx}/common/login_login.do';
}
function divnNotLike(trData,indexCode){
     var _ajaxData={'ccDivBaseDto.indexcode':indexCode};
       if(confirm("是否取消收藏?")){
             asy_Ajax('${ctx}/monitorwarn/index_removeDiv.do',_ajaxData,'html',function(){
                $(trData).parents('tr').remove();
             });
       } 
}

</script>
</div>

<div class="report_form">
		<div id="form_tit" class="form_tit">
			<table>
				<tr>
					<th>&nbsp;&nbsp;收藏夹列表(${searchDto.statDate})</th>
					     <th width="6.3%"><div><a href="javascript:returnUrl();" class="arrow_left"></a></div></th>
					<th width="6.3%"><div><a href="javascript:searchPage()" class="search"></a></div></th>
				</tr>
			</table>
		</div>


		<div id="form_thead">
			<table class="form_table">
				<thead>
					 <tr>
                            <td width="4.8%">序号</td>
                            <td width="4.8%">预警</td>
                            <td width="9.5%">一级风险</td>
                            <td width="10.5%">二级风险</td>
                            <td width="20.2%">指标名称</td>
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
			<thead>
						 <tr>
                            <td width="4.8%">序号</td>
                            <td width="4.8%">预警</td>
                            <td width="9.5%">一级风险</td>
                            <td width="10.5%">二级风险</td>
                            <td width="20.2%">指标名称</td>
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
                            <td > <s:property value="#status.index+1"/> </td>
                            <td class="color">
                                <input id="colorValue" value="${indexKRIDto.color}" type="hidden"/>
                                <s:if test='"R".equals(#indexKRIDto.color)'> <div  class="alert_red"></div></s:if>
                                <s:elseif test='"G".equals(#indexKRIDto.color)'><div class="alert_green"></div></s:elseif>
                                <s:elseif test='"Y".equals(#indexKRIDto.color)'><div class="alert_yellow"></div></s:elseif>
                                <s:else>--</s:else></td>
                            <td><s:property value="#indexKRIDto.cdIndexBaseDto.lev1riskname"/></td>
                            <td> <s:property value="#indexKRIDto.cdIndexBaseDto.lev2riskname"/> </td>
                            <td style="padding:0px 8px;text-align:left"> <s:property value="#indexKRIDto.cdIndexBaseDto.indexname"/> </td>
                             <td>
                                 ${indexKRIDto.indexvalue}
                            </td>
                             <td>
                                  ${indexKRIDto.lyearvalue}
                            </td>
                            <td>
                                ${indexKRIDto.lmonvalue}
                            </td> 
                            <td><s:if test='#indexKRIDto.cdIndexBaseDto.fetchrate.equals("M")'>月度
                                </s:if><s:elseif test='#indexKRIDto.cdIndexBaseDto.fetchrate.equals("Q")'> 季度
                                </s:elseif><s:elseif test='#indexKRIDto.cdIndexBaseDto.fetchrate.equals("H")'>半年
                                </s:elseif><s:elseif test='#indexKRIDto.cdIndexBaseDto.fetchrate.equals("Y")'>年度
                                </s:elseif></td>
                                <td class="delDown"><div><div>
  <a target="_blank" href="${ctx}/monitorwarn/index_getIndexDetails.do?searchDto.comCode=${searchDto.comCode}&searchDto.indexCode=<s:property value="#indexKRIDto.indexcode"/>&searchDto.statDate=<s:date name="#indexKRIDto.statdate" format="yyyyMM"/>&searchDto.fetchrate=<s:property value="#indexKRIDto.cdIndexBaseDto.fetchrate"/>" class="info">信息</a>                            
<%--   <a target="_blank" href="${ctx}/monitorwarn/index_getIndexDetails.do?searchDto.indexCode=<s:property value="#indexKRIDto.indexcode"/>&searchDto.statDate=<s:date name="#indexKRIDto.statdate" format="yyyyMM"/>&searchDto.fetchrate=<s:property value="#indexKRIDto.cdIndexBaseDto.fetchrate"/>" class="info">信息</a></div></div></td>
 --%>                                <td class="delDown"><div>
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
                                <td><div><a style="cursor:pointer;"  onclick="divnNotLike(this,'<s:property value="#indexKRIDto.indexcode" />');"  class="like" ></a></div></td>
                        </tr>
                    </s:iterator>
		</table>
</div>