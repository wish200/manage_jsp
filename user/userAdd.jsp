<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告-新增 -->

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

//--确定按钮
function keep(){
	var ok=haveData("nickname", "昵称不能为空！")
	if(ok){
			  $("#userForm").ajaxSubmit({
			          type : 'post',  
			          url : '${ctx}/user/user_add.do',  
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "系统错误");  
			          },
			          success: function(data){
			               alert("保存成功");
			               publicURL="${ctx}/user/user_getList.do";
			               $("#userForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appUserBaseDto.userid"]').val(data);
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
	 $("#userForm").find('input,select,textarea').attr('disabled',false);
	 $("#userForm").ajaxSubmit({
         type : 'post',  
         url : '${ctx}/user/user_send.do',  
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

 

</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;app用户信息</th>
                    </tr>
                  </table>
                </div>
          <form id="userForm" method="post">  
                  <!--新生成的公告代码-->
				   
                <table class="school_task ostyle">
                  <tr>
                    <th>用户ID：</th>
                    <td>
		               <input id="userid" name="appUserBaseDto.userid" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>昵称：</th>
                    <td>
		               <input id="nickname" name="appUserBaseDto.nickname" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                    <th>密码：</th>
                    <td>
		               <input id="password" name="appUserBaseDto.password" type="password"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>电话：</th>
                    <td>
		               <input id="phonenumber" name="appUserBaseDto.phonenumber" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                    <th>生日：</th>
                    <td>
		               <input id="birthday" name="appUserBaseDto.birthday" type="text"/>
                    </td>
                    <th>真实姓名：</th>
                    <td>
		               <input id="realname" name="appUserBaseDto.realname" type="text"/>
                    </td>
                  </tr>
                   <tr>
                    <th>微信：</th>
                    <td>
		               <input id="weixin" name="appUserBaseDto.weixin" type="text"/>
                    </td>
                    <th>性别：</th>
                    <td>
		                <select id="sex" class="selector" name="appUserBaseDto.sex">
                    	<option value="1">男</option>
                    	<option value="2" >女</option>
                    	<option value="0">保密</option>
                    	</select>
                    </td>
                  </tr>
                  <tr>
                    <th>QQ：</th>
                    <td>
		               <input id="qq" name="appUserBaseDto.qq" type="text"/>
                    </td>
                    <th>email：</th>
                    <td>
		               <input id="mail" name="appUserBaseDto.mail" type="text"/>
                    </td>
                  </tr>
                  <tr>
                    <th>省：</th>
                    <td>
		               <input id="province" name="appUserBaseDto.province" type="text"/>
                    </td>
                    <th>城市：</th>
                    <td>
		               <input id="city" name="appUserBaseDto.city" type="text"/>
                    </td>
                  </tr>
                   
                   <tr>
                     <th>头像图片：</th>
                     <td colspan="3">
                    	<input type="file" name="Filedata1" id="Filedata1"  style="width:50%; border:#cccccc solid 1px;padding: 7px 5px;"/>
	                    <span class="filebtn"> <input type="button" value="上传" onclick="fileUpload('1','userpic','pic')"></span>
	                    <span style="color:red" >*</span>
	                    <span><img src="${ctx }/images/loading.gif" id="loading1" style="display: none;"></span>
	                     原图：<input type="checkbox" id="isorigin1" name="isorigin1" >
	                    <input id="userpic" type="hidden" name="appUserBaseDto.userpic" >
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
	                    <input id="backgroundpic" type="hidden" name="appUserBaseDto.backgroundpic" >
                     </td>
                  </tr>
                 
                  
                  
                  <tr class="height_70">
                    <th>简介：</th>
                    <td colspan="3"><textarea style="height:300px;position:relative;float:left" id="description" name="appUserBaseDto.description"></textarea>
                    <span style="color:red;position:relative;float:left">*</span>
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
