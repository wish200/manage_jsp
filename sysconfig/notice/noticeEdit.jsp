<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-编辑 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/risk/resource/js/WdatePicker.js"></script>
<script type="text/javascript">
Date.prototype.pattern=function(fmt) {           
    var o = {           
    "M+" : this.getMonth()+1, //月份           
    "d+" : this.getDate(), //日           
    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时           
    "H+" : this.getHours(), //小时           
    "m+" : this.getMinutes(), //分           
    "s+" : this.getSeconds(), //秒           
    "q+" : Math.floor((this.getMonth()+3)/3), //季度           
    "S" : this.getMilliseconds() //毫秒           
    };           
    var week = {           
    "0" : "/u65e5",           
    "1" : "/u4e00",           
    "2" : "/u4e8c",           
    "3" : "/u4e09",           
    "4" : "/u56db",           
    "5" : "/u4e94",           
    "6" : "/u516d"          
    };           
    if(/(y+)/.test(fmt)){           
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));           
    }           
    if(/(E+)/.test(fmt)){           
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);           
    }           
    for(var k in o){           
        if(new RegExp("("+ k +")").test(fmt)){           
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));           
        }           
    }           
    return fmt;           
};
//公告摘要-校验规则
$('#postdesc').keyup(function(){
		  var value=$(this).val().replace(/[^\x00-\xff]/g, 'xx');
		  if(value.length>256){
			   alert("公告摘要不能超过256个字符！");
			   var valuetemp=$(this).val();
			   valuetemp=valuetemp.substring(0,128);
			   $(this).val(valuetemp);
		  }
 });
 //内容-校验规则
$('#remark').keyup(function(){
		  var value=$(this).val().replace(/[^\x00-\xff]/g, 'xx');
		  if(value.length>256){
			   alert("内容不能超过256个字符！");
			   var valuetemp=$(this).val();
			   valuetemp=valuetemp.substring(0,128);
			   $(this).val(valuetemp);
		  }
 });
//截止时间
$('input[name="ccSystemPostBaseDto.enddate"]').blur(function(){
  var selectDate=$(this).val();
  var nowDate = new Date(); 
  nowDate=nowDate.pattern("yyyy-MM-dd");
  if(selectDate<=nowDate&&selectDate!=''){
     alert("截止日期不能小于等于当期日期！");
     $(this).val('');
  }
});
//--确定按钮
function keep(){
	 var selectDate=$('input[name="ccSystemPostBaseDto.enddate"]').val();
	 var nowDate = new Date(); 
	 nowDate=nowDate.pattern("yyyy-MM-dd");
     if(selectDate<=nowDate&&selectDate!=''){
     alert("截止日期不能小于等于当期日期！");
     $('input[name="ccSystemPostBaseDto.enddate"]').val("");
     return;
     }
	var ok=haveData("postdesc", "公告摘要不能为空！")
    && haveData("enddate", "截止日期不能为空！")
    && haveData("remark", "内容不能为空！");
	if(ok){
			  $("#noticeForm").ajaxSubmit({
			          type : 'post',  
			          url : '${ctx}/sysconfig/sysPosMan_updateSysPost.do',  
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "系统错误");  
			          },
			          success: function(data){
			               alert("修改成功");
			               asy_Ajax("${ctx}/sysconfig/sysPosMan_getSystrmPoseList.do",{},'html',function(data){
			          		 $("#content").html(data);
			          		 publicURL="${ctx}/sysconfig/sysPosMan_getSystrmPoseList.do";
			               });
			          }
			  });
    }
}
//--返回按钮
function returnc(){
    if(typeof(publicURL)=='undefined'){
		   publicURL="${ctx}/sysconfig/sysPosMan_getSystrmPoseList.do";
	}
	asy_Ajax(encodeURI(publicURL),{},'html',function(data){
		 $("#content").html(data);
	});
}
</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;公告信息</th>
                    </tr>
                  </table>
                </div>
          <form id="noticeForm" method="post">  
                <!--新生成的公告代码-->
				<input id="systemcode" name="ccSystemPostBaseDto.systemcode" value="${ccSystemPostBaseDto.systemcode }" type="hidden" />  
                <table class="school_task ostyle">
                  <tr>
                    <th>公告摘要：</th>
                    <td>
		               <input id="postdesc" name="ccSystemPostBaseDto.postdesc" value="${ccSystemPostBaseDto.postdesc }" type="text" />
		               <span style="color:red">*</span>
                    </td>
                    <th>截止日期：</th>
                    <td>
                       <input id="enddate" class="Wdate" onclick="WdatePicker({startDate:'<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>'})"  name="ccSystemPostBaseDto.enddate" value="<s:date name="ccSystemPostBaseDto.enddate" format="yyyy-MM-dd"/>" type="text" />
                       <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr class="height_70">
                    <th>内容：</th>
                    <td colspan="3">
                    <textarea  style="height:300px;position:relative;float:left" id="remark" name="ccSystemPostBaseDto.remark">${ccSystemPostBaseDto.remark }</textarea>
                     <span style="color:red;position:relative;float:left">*</span>
                    </td>
                  </tr>
                </table>
           </form>     
                  <div class="manual_button">
                        <a id="returnBtn" href="javascript:returnc()" class="cancel">返&nbsp;&nbsp;回</a>
                        <a id="keepBtn" href="javascript:keep()" class="save" >确&nbsp;&nbsp;定</a>
                  </div>
                </div>
            </div>
