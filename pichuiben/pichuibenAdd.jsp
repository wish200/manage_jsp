<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告-新增 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/js/introduce/ajaxfileupload.js"></script>
<script type="text/javascript" src="/htmanage/js/common/app.js"></script>

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


//--确定按钮
function keep(){
	var ok=haveData("picbookname", "绘图名称不能为空！")
    && haveData("audioname", "绘音名称不能为空！");
	if(ok){ 
			  $("#pichuibenForm").ajaxSubmit({
			          type : 'post',  
			          url : '${ctx}/pichuiben/pichuiben_add.do',  
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "系统错误");  
			          },
			          success: function(data){
			               alert("保存成功");
			               publicURL="${ctx}/pichuiben/pichuiben_getList.do";
			               $("#pichuibenForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appPicHuibenBaseDto.huibenid"]').val(data);
			               $('#cancleBtn').hide();
			               $('#keepBtn').hide();
			               $('#returnBtn').show();
			               $('#subBtn').show();
			          }
			  });
    }
}
//--提交按钮
function submit(){
	 $("#pichuibenForm").find('input,select,textarea').attr('disabled',false);
	 $("#pichuibenForm").ajaxSubmit({
         type : 'post',  
         url : '${ctx}/pichuiben/pichuiben_send.do',  
         error: function(XmlHttpRequest, textStatus, errorThrown){  
              alert("系统错误");  
         },
         success: function(data){
              alert("提交成功");
              returnc();
         }
     });
}
//--取消按钮
function cancel(){
	if(confirm("取消不保存本次操作")){
		asy_Ajax(publicURL,{},'html',function(data){
			 $("#content").html(data);
		});
	}
}
//--返回按钮
function returnc(){
	asy_Ajax(publicURL,{},'html',function(data){
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
			          url : '${ctx}/pichuiben/pichuiben_changeuser.do', 
			          data:{userid:userid1},
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "获取用户信息错误");  
			          },
			          success: function(data){ 
			          		
			               //$("#pichuibenForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appPicHuibenBaseDto.nickname"]').val(data.nickname);
			               $('input[name="appPicHuibenBaseDto.userpic"]').val(data.userpic);
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
			          url : '${ctx}/pichuiben/pichuiben_changepicbook.do', 
			          data:{picbookid:picbookid1},
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "获取用户信息错误");  
			          },
			          success: function(data){ 
			          		
			               //$("#pichuibenForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appPicHuibenBaseDto.picbookname"]').val(data.picbookname);
			               $('input[name="appPicHuibenBaseDto.picscene"]').val(data.picscene);
			               $('input[name="appPicHuibenBaseDto.picbookurl"]').val(data.picbookurl);
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
			          url : '${ctx}/pichuiben/pichuiben_changeaudio.do', 
			          data:{audioid:audioid1},
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "获取用户信息错误");  
			          },
			          success: function(data){ 
			          		
			               //$("#pichuibenForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appPicHuibenBaseDto.audioname"]').val(data.audioname);
			               $('input[name="appPicHuibenBaseDto.audiourl"]').val(data.audiourl);
			               $('textarea[name="appPicHuibenBaseDto.audiolength"]').val(data.audiolength);
			               $('input[name="appPicHuibenBaseDto.audiocontent"]').val(data.audiocontent);
			               
			          }
			  });
    }
    

</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;自说自话-绘本信息</th>
                    </tr>
                  </table>
                </div>
          <form id="pichuibenForm" method="post">  
                  <!--新生成的公告代码-->
				  <input id="huibenid" name="appPicHuibenBaseDto.huibenid" value="" type="hidden" />  
                <table class="school_task ostyle">
                  <tr>
                    <th>状态：</th>
                    <td>
                    	<select id="status" class="selector" name="appPicHuibenBaseDto.status">
                    	<option value="0">无效</option>
                    	<option value="1" selected>有效</option>
                    	</select>
	                   <span style="color:red">*</span>
                    
                    </td>
                    <th>小红花数量：</th>
                    <td>
		               <input id="flowercnt" name="appPicHuibenBaseDto.flowercnt" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr> 
                  <div style="border-bottom:1px solid black"></div> 
                  <tr>
                  	<th>用户ID：</th>
                    <td>
		               <input id="userid" name="appPicHuibenBaseDto.userid" type="text" onchange="changeuser(this)"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>用户名称：</th>
                    <td>
		               <input id="nickname" name="appPicHuibenBaseDto.nickname" type="text" /> 
                    </td>
                  </tr>
                  <tr>
                     <th>用户头像地址：</th>
                     <td colspan="3">
                     <input id="userpic" type="text"  style="width:80%;"  readonly="readonly" name="appPicHuibenBaseDto.userpic" value="${appPicHuibenBaseDto.userpic }"/>
                     </td>
                  </tr>
                  <tr>
                     <th>用户头像图片：</th>
                     <td colspan="3">
	                    <span id='filespan3' style="display:none">
	                    <img id="userpicimg" hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appPicHuibenBaseDto.userpic }"   onclick="selectForward(this)"/>
	                    </span>
                     </td>
                  </tr> 
                  
                  <tr>
                  	<th>绘画ID：</th>
                    <td>
		               <input id="picbookid" name="appPicHuibenBaseDto.picbookid" type="text" onchange="changepicbook(this)"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>绘画名称：</th>
                    <td>
		               <input id="picbookname" name="appPicHuibenBaseDto.picbookname" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                     <th>绘画场景：</th>
                     <td colspan="3">
                     <input id="picscene" type="text"  style="width:80%;"  readonly="readonly" name="appPicHuibenBaseDto.picscene" />
                     </td>
                  </tr>
                  <tr>
                     <th>绘画图片地址：</th>
                     <td colspan="3">
                     <input id="picbookurl" type="text"  style="width:80%;"  readonly="readonly" name="appPicHuibenBaseDto.picbookurl" />
                     </td>
                  </tr>
                  <tr>
                     <th>绘画图片：</th>
                     <td colspan="3">
	                    <span id='filespan1' style="display:none">
	                    <img id="picbookimg" hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appPicHuibenBaseDto.picbookurl }" onclick="selectForward(this)"  />
	                    </span>
                     </td>
                  </tr>
                  <tr>
                    <th>绘音编号：</th>
                    <td>
		               <input id="audioid" name="appPicHuibenBaseDto.audioid" type="text" onchange="changeaudio(this)"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>绘音名称：</th>
                    <td>
		               <input id="audioname" name="appPicHuibenBaseDto.audioname" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                    <th>时长：</th>
                    <td>
		               <input id="audiolength" name="appPicHuibenBaseDto.audiolength" type="text" value="${appPicHuibenBaseDto.audiolength }"/>
		               
                    </td>
                  </tr>
                  <tr>
                    <th>绘音地址：</th>
                     <td colspan="3">
	                    <input id="audiourl" type="text"  style="width:80%;"  readonly name="appPicHuibenBaseDto.audiourl" 
	                    onclick="selectForward1('${ctx}/jsp/program/play.jsp?name='+$('#audioname').val()+'&path='+$(this).val())"/>
                     </td>
                  </tr>
                  <tr class="height_70">
                    <th>绘音内容：</th>
                    <td colspan="3"><textarea style="height:300px;position:relative;float:left" id="audiocontent" name="appPicHuibenBaseDto.audiocontent"></textarea>
                    </td>
                  </tr>
                  
                </table>
           </form>     
                  <div class="manual_button">
                        <a id="cancleBtn" href="javascript:cancel()" class="cancel">取&nbsp;&nbsp;消</a>
                        <a id="keepBtn" href="javascript:keep()" class="save">保&nbsp;&nbsp;存</a>
                        <a id="returnBtn" style="display:none" href="javascript:returnc()" class="cancel">返&nbsp;&nbsp;回</a>
                        <a id="subBtn" style="display:none" href="javascript:submit()" class="save">发&nbsp;&nbsp;布</a>
                  </div>
                </div>
            </div>
            
