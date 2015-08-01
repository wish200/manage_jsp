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
	
	var ok=haveData("picbookname", "绘画名称不能为空！")
    && haveData("audioname", "绘音名称不能为空！");
	if(ok){
			  $("#audiohuibenForm").ajaxSubmit({
			          type : 'post',  
			          url : '${ctx}/audiohuiben/audiohuiben_update.do',  
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "系统错误");  
			          },
			          success: function(data){
			               alert("修改成功");
			               asy_Ajax("${ctx}/audiohuiben/audiohuiben_getList.do",{},'html',function(data){
			          		 $("#content").html(data);
			          		 publicURL="${ctx}/audiohuiben/audiohuiben_getList.do";
			               });
			          }
			  });
    }
}
//--返回按钮
function returnc(){
    if(typeof(publicURL)=='undefined'){
		   publicURL="${ctx}/audiohuiben/audiohuiben_getList.do";
	}
	asy_Ajax(encodeURI(publicURL),{},'html',function(data){
		 $("#content").html(data);
	});
}
 

	
    function changeuser(e){
    	var userid1 = e.value;
    	if(userid1==''){
    		alert("用户id不能为空");
    		return;
    	}
    	$.ajax({
			          type : 'post',  
			          url : '${ctx}/audiohuiben/audiohuiben_changeuser.do', 
			          data:{userid:userid1},
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "获取用户信息错误");  
			          },
			          success: function(data){ 
			          		
			               //$("#audiohuibenForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appAudioHuibenBaseDto.nickname"]').val(data.nickname);
			               $('input[name="appAudioHuibenBaseDto.userpic"]').val(data.userpic);
			               $('#userpicimg').attr('src',data.userpic)
			               $('#filespan3').show();
			          }
			  });
    }
    function changepicbook(e){
    	var picbookid1 = e.value;
    	if(picbookid1==''){
    		alert("不能为空");
    		return;
    	}
    	$.ajax({
			          type : 'post',  
			          url : '${ctx}/audiohuiben/audiohuiben_changepicbook.do', 
			          data:{picbookid:picbookid1},
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "获取用户信息错误");  
			          },
			          success: function(data){ 
			          		
			               //$("#audiohuibenForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appAudioHuibenBaseDto.picbookname"]').val(data.picbookname);
			               $('input[name="appAudioHuibenBaseDto.picscene"]').val(data.picscene);
			               $('input[name="appAudioHuibenBaseDto.picbookurl"]').val(data.picbookurl);
			               $('#picbookimg').attr('src',data.picbookurl)
			               $('#filespan1').show();
			          }
			  });
    }
    function changeaudio(e){
    	var audioid1 = e.value;
    	if(audioid1==''){
    		alert("id不能为空");
    		return;
    	}
    	$.ajax({
			          type : 'post',  
			          url : '${ctx}/audiohuiben/audiohuiben_changeaudio.do', 
			          data:{audioid:audioid1},
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "获取用户信息错误");  
			          },
			          success: function(data){ 
			          		
			               //$("#audiohuibenForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appAudioHuibenBaseDto.audioname"]').val(data.audioname);
			               $('input[name="appAudioHuibenBaseDto.audiourl"]').val(data.audiourl);
			               $('input[name="appAudioHuibenBaseDto.audiolength"]').val(data.audiolength);
			               $('textarea[name="appAudioHuibenBaseDto.audiocontent"]').val(data.audiocontent);
			               
			          }
			  });
    }

$("#status").val("${appAudioHuibenBaseDto.status }");
</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;绘本信息</th>
                    </tr>
                  </table>
                </div>
          <form id="audiohuibenForm" method="post">  
                <!--新生成的公告代码-->
				<input id="audiohuiben" name="appAudioHuibenBaseDto.huibenid" value="${appAudioHuibenBaseDto.huibenid }" type="hidden" />  
                <table class="school_task ostyle">
                  <tr>
                    <th>状态：</th>
                    <td>
                    	<select id="status" class="selector" name="appAudioHuibenBaseDto.status">
                    	<option value="0">无效</option>
                    	<option value="1" selected>有效</option>
                    	</select>
	                   <span style="color:red">*</span>
                    
                    </td>
                    <th>小红花数量：</th>
                    <td>
		               <input id="flowercnt" name="appAudioHuibenBaseDto.flowercnt" type="text" value="${appAudioHuibenBaseDto.flowercnt }"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr> 
                  <div style="border-bottom:1px solid black"></div> 
                  <tr>
                  	<th>用户ID：</th>
                    <td>
		               <input id="userid" name="appAudioHuibenBaseDto.userid" type="text" value="${appAudioHuibenBaseDto.userid }" onchange="changeuser(this)"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>用户名称：</th>
                    <td>
		               <input id="nickname" name="appAudioHuibenBaseDto.nickname"  value="${appAudioHuibenBaseDto.nickname }" type="text" /> 
                    </td>
                  </tr>
                  <tr>
                     <th>用户头像地址：</th>
                     <td colspan="3">
                     <input id="userpic" type="text"  style="width:80%;" readonly="readonly" name="appAudioHuibenBaseDto.userpic" value="${appAudioHuibenBaseDto.userpic }"/>
                     </td>
                  </tr>
                  <tr>
                     <th>用户头像图片：</th>
                     <td colspan="3">
	                    <span id='filespan3'>
	                    <img id="userpicimg" hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appAudioHuibenBaseDto.userpic }"   onclick="selectForward(this)"/>
	                    </span>
                     </td>
                  </tr> 
                  
                  <tr>
                  	<th>绘画ID：</th>
                    <td>
		               <input id="picbookid" name="appAudioHuibenBaseDto.picbookid" type="text" value="${appAudioHuibenBaseDto.picbookid }" onchange="changepicbook(this)"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>绘画名称：</th>
                    <td>
		               <input id="picbookname" name="appAudioHuibenBaseDto.picbookname" type="text" value="${appAudioHuibenBaseDto.picbookname }"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                     <th>绘画场景：</th>
                     <td colspan="3">
                     <input id="picscene" type="text" style="width:80%;" readonly="readonly" name="appAudioHuibenBaseDto.picscene" value="${appAudioHuibenBaseDto.picscene }"
                     </td>
                  </tr>
                  <tr>
                     <th>绘画图片地址：</th>
                     <td colspan="3">
                     <input id="picbookurl" type="text" style="width:80%;" readonly="readonly" name="appAudioHuibenBaseDto.picbookurl" value="${appAudioHuibenBaseDto.picbookurl }"
                     </td>
                  </tr>
                  <tr>
                     <th>绘画图片：</th>
                     <td colspan="3">
	                    <span id='filespan1' >
	                    <img hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appAudioHuibenBaseDto.picbookurl }" onclick="selectForward(this)"  />
	                    </span>
                     </td>
                  </tr>
                  <tr>
                    <th>绘音编号：</th>
                    <td>
		               <input id="audioid" name="appAudioHuibenBaseDto.audioid" type="text" value="${appAudioHuibenBaseDto.audioid }" onchange="changeaudio(this)"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>绘音名称：</th>
                    <td>
		               <input id="audioname" name="appAudioHuibenBaseDto.audioname" type="text" value="${appAudioHuibenBaseDto.audioname }"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                    <th>时长：</th>
                    <td>
		               <input id="audiolength" name="appAudioHuibenBaseDto.audiolength" type="text" value="${appAudioHuibenBaseDto.audiolength }"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                    <th>绘音地址：</th>
                     <td colspan="3">
	                    <input id="audiourl" type="text" style="width:80%;" readonly="readonly" name="appAudioHuibenBaseDto.audiourl"  value="${appAudioHuibenBaseDto.audiourl }"
	                    onclick="selectForward1('${ctx}/jsp/program/play.jsp?name=${appAudioHuibenBaseDto.audiourl }&path=${appAudioHuibenBaseDto.audiourl }')"/>
                     </td>
                     
                  </tr>
                  <tr class="height_70">
                    <th>绘音内容：</th>
                    <td colspan="3"><textarea style="height:300px;position:relative;float:left" id="audiocontent" name="appAudioHuibenBaseDto.audiocontent">${appAudioHuibenBaseDto.audiocontent }</textarea>
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
