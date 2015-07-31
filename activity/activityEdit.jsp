<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-编辑 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/resource/js/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/common/app.js"></script>
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
	 var selectDate=$('input[name="appActivityBaseDto.activitytime"]').val();
	 var nowDate = new Date(); 
	 nowDate=nowDate.pattern("yyyy-MM-dd");
     if(selectDate<=nowDate&&selectDate!=''){
     alert("活动日期不能小于等于当期日期！");
     $('input[name="appActivityBaseDto.activitytime"]').val("");
     return;
     }
	var ok=haveData("activityname", "活动名称不能为空！")
    && haveData("activitytime", "活动时间不能为空！")
    && haveData("activitydesc", "内容不能为空！");
	if(ok){
			  $("#noticeForm").ajaxSubmit({
			          type : 'post',  
			          url : '${ctx}/activity/activity_update.do',  
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "系统错误");  
			          },
			          success: function(data){
			               alert("修改成功");
			               asy_Ajax("${ctx}/activity/activity_getList.do",{},'html',function(data){
			          		 $("#content").html(data);
			          		 publicURL="${ctx}/activity/activity_getList.do";
			               });
			          }
			  });
    }
}
//--返回按钮
function returnc(){
    if(typeof(publicURL)=='undefined'){
		   publicURL="${ctx}/activity/activity_getList.do";
	}
	asy_Ajax(encodeURI(publicURL),{},'html',function(data){
		 $("#content").html(data);
	});
}



$("#activitytype").val("${appActivityBaseDto.activitytype }");
$("#validstatus").val("${appActivityBaseDto.validstatus }");
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
				<input id="activity" name="appActivityBaseDto.activityid" value="${appActivityBaseDto.activityid }" type="hidden" />  
                <table class="school_task ostyle">
                  <tr>
                    <th>活动名称：</th>
                    <td>
		               <input id=activityname name="appActivityBaseDto.activityname" value="${appActivityBaseDto.activityname }" type="text" />
		               <span style="color:red">*</span>
                    </td>
                    <th>活动时间：</th>
                    <td>
                       <input id="activitytime" class="Wdate" onclick="WdatePicker({activitytime:'<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>'})"  name="appActivityBaseDto.activitytime" value="<s:date name="appActivityBaseDto.activitytime" format="yyyy-MM-dd hh:mm:ss"/>" type="text" />
                       <span style="color:red">*</span>
                    </td>
                  </tr>
                  
                  <tr>
                    <th>活动类型：</th>
                    <td>
		               <select id="activitytype" name="appActivityBaseDto.activitytype" type="select">
		               	<option value="1" >一起玩</option>
                    	<option value="2">小朋友圈</option>
		               </select>
		               <span style="color:red">*</span>
                    </td>
                    <th>状态：</th>
                    <td>
                       <select id="validstatus" class="selector" name="appActivityBaseDto.validstatus">
                    	<option value="0">无效</option>
                    	<option value="1" >有效</option>
                    	</select>                       
                       <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                     <th>活动图片：</th>
                     <td colspan="3">
                    	<input type="file" name="Filedata1" id="Filedata1"  style="width:50%; border:#cccccc solid 1px;padding: 7px 5px;"/>
	                    <span class="filebtn"> <input type="button" value="上传" onclick="fileUpload('1','activitypicurl','pic')"></span>
	                    <span style="color:red" >*</span>
	                    <span><img src="${ctx }/images/loading.gif" id="loading1" style="display: none;"></span>
	                    	原图：<input type="checkbox" id="isorigin1" name="isorigin1" >
	                    <input id="activitypicurl" type="hidden" name="appActivityBaseDto.activitypicurl"  value="${appActivityBaseDto.activitypicurl }"/>
	                    <span id='filespan1'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appActivityBaseDto.activitypicurl }" onclick="selectForward(this)"  />
	                    </span>
                     </td>
                  </tr>
                  
                  <tr class="height_70">
                    <th>内容：</th>
                    <td colspan="3">
                    <textarea  style="height:300px;position:relative;float:left" id="activitydesc" name="appActivityBaseDto.activitydesc">${appActivityBaseDto.activitydesc }</textarea>
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
