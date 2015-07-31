<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-编辑 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/resource/js/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/introduce/ajaxfileupload.js"></script>
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
	
	var ok=haveData("channelname", "名称不能为空！")
    && haveData("channeldesc", "简介不能为空！");
	if(ok){
			  $("#noticeForm").ajaxSubmit({
			          type : 'post',  
			          url : '${ctx}/channel/channel_update.do',  
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "系统错误");  
			          },
			          success: function(data){
			               alert("修改成功");
			               asy_Ajax("${ctx}/channel/channel_getList.do",{},'html',function(data){
			          		 $("#content").html(data);
			          		 publicURL="${ctx}/channel/channel_getList.do";
			               });
			          }
			  });
    }
}
//--返回按钮
function returnc(){
    if(typeof(publicURL)=='undefined'){
		   publicURL="${ctx}/channel/channel_getList.do";
	}
	asy_Ajax(encodeURI(publicURL),{},'html',function(data){
		 $("#content").html(data);
	});
}



$("#status").val("${appChannelBaseDto.status }");
$("#sort").val("${appChannelBaseDto.sort}");
</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;电台信息</th>
                    </tr>
                  </table>
                </div>
          <form id="noticeForm" method="post">  
                <!--新生成的公告代码-->
				<input id="channel" name="appChannelBaseDto.channelid" value="${appChannelBaseDto.channelid }" type="hidden" />  
                <table class="school_task ostyle">
                  <tr>
                    <th>电台名称：</th>
                    <td>
		               <input id=channelname name="appChannelBaseDto.channelname" value="${appChannelBaseDto.channelname }" type="text" />
		               <span style="color:red">*</span>
                    </td>
                    <th>状态：</th>
                    <td>
                    	<select id="status" class="selector" name="appChannelBaseDto.status">
                    	<option value="0">无效</option>
                    	<option value="1" selected>有效</option>
                    	</select>
	                   <span style="color:red">*</span>
                    
                    </td>
                  </tr>
                  
                  <tr>
                    <th>电台主播：</th>
                    <td>
		               <input id="djname" name="appChannelBaseDto.djname" value="${appChannelBaseDto.djname }" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>主播描述：</th>
                    <td>
		               <input id="djdesc" name="appChannelBaseDto.djdesc" value="${appChannelBaseDto.djdesc}" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                    <th>节目数量：</th>
                    <td>
		               <input id="programcnt" name="appChannelBaseDto.programcnt" value="${appChannelBaseDto.programcnt}" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>粉丝数量：</th>
                    <td>
		               <input id="fanscnt" name="appChannelBaseDto.fanscnt" value="${appChannelBaseDto.fanscnt}" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                    <th>小红花数量：</th>
                    <td>
		               <input id="flowercnt" name="appChannelBaseDto.flowercnt" value="${appChannelBaseDto.flowercnt}" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>优先级：</th>
                    <td>
		                <select id="sort" class="selector" name="appChannelBaseDto.sort">
                    	<option value="1">1</option>
                    	<option value="2" selected>2</option>
                    	<option value="3" selected>3</option>
                    	<option value="4" selected>4</option>
                    	</select>
                    </td>
                  </tr>
                  <tr>
                     <th>电台标识图片：</th>
                     <td colspan="3">
                    	<input type="file" name="Filedata1" id="Filedata1"  style="width:50%; border:#cccccc solid 1px;padding: 7px 5px;"/>
	                    <span class="filebtn"> <input type="button" value="上传" onclick="fileUpload('1','channelpic','pic')"></span>
	                    <span style="color:red" >*</span>
	                    <span><img src="${ctx }/images/loading.gif" id="loading1" style="display: none;"></span>
	                    原图：<input type="checkbox" id="isorigin1" name="isorigin1" >
	                    <input id="channelpic" type="hidden" name="appChannelBaseDto.channelpic" value="${appChannelBaseDto.channelpic}" >
	                    <span id='filespan1'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appChannelBaseDto.channelpic }" onclick="selectForward(this)"  />
	                    </span>
                     </td>
                  </tr>
                   <tr>
                     <th>电台背景图片：</th>
                     <td colspan="3">
                    	<input type="file" name="Filedata2" id="Filedata2"  style="width:50%; border:#cccccc solid 1px;padding: 7px 5px;"/>
	                    <span class="filebtn"> <input type="button" value="上传" onclick="fileUpload('2','backgroundpic','pic')"></span>
	                    <span style="color:red" >*</span>
	                    <span><img src="${ctx }/images/loading.gif" id="loading2" style="display: none;"></span>
	                    原图：<input type="checkbox" id="isorigin2" name="isorigin2" >
	                    <input id="backgroundpic" type="hidden" name="appChannelBaseDto.backgroundpic" value="${appChannelBaseDto.backgroundpic}" >
	                    <span id='filespan2'>
	                    <img hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appChannelBaseDto.backgroundpic }" onclick="selectForward(this)"  />
	                    </span>
                     </td>
                  </tr>
                  
                  <tr class="height_70">
                    <th>简介：</th>
                    <td colspan="3"><textarea style="height:300px;position:relative;float:left" id="channeldesc" name="appChannelBaseDto.channeldesc">${appChannelBaseDto.channeldesc }</textarea>
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
