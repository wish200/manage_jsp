<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告-新增 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
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
	var ok=haveData("picbookname", "名称不能为空！")
    && haveData("uploadtime", "发布时间不能为空！")
    && haveData("picscene", "场景不能为空！");
	if(ok){
			  $("#picbookForm").ajaxSubmit({
			          type : 'post',  
			          url : '${ctx}/picbook/picbook_add.do',  
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "系统错误");  
			          },
			          success: function(data){
			               alert("保存成功");
			               publicURL="${ctx}/picbook/picbook_getList.do";
			               $("#picbookForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appPicbookBaseDto.picbookid"]').val(data);
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
	 $("#picbookForm").find('input,select,textarea').attr('disabled',false);
	 $("#picbookForm").ajaxSubmit({
         type : 'post',  
         url : '${ctx}/picbook/picbook_Post.do',  
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
			          url : '${ctx}/picbook/picbook_changeuser.do', 
			          data:{userid:userid1},
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "获取用户信息错误");  
			          },
			          success: function(data){ 
			          		
			               //$("#huibenForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appPicbookBaseDto.nickname"]').val(data.nickname);
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
                      <th>&nbsp;&nbsp;绘图信息</th>
                    </tr>
                  </table>
                </div>
          <form id="picbookForm" method="post">  
                  <!--新生成的公告代码-->
				  <input id="picbookid" name="appPicbookBaseDto.picbookid" value="" type="hidden" />
				   
                <table class="school_task ostyle">
                  <tr>
                    <th>绘画名称：</th>
                    <td>
		               <input id="picbookname" name="appPicbookBaseDto.picbookname" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>发布时间：</th>
                    <td>
                      <input id="uploadtime" class="Wdate" name="appPicbookBaseDto.uploadtime" type="text"  value="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
                       <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                    <th>所属用户ID：</th>
                    <td>
		               <input id="userid" name="appPicbookBaseDto.userid" type="text"  onchange="changeuser(this)"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>用户昵称：</th>
                    <td>
                      <input id="nickname" name="appPicbookBaseDto.nickname" type="text"/>
                       <span style="color:red">*</span>
                    </td>
                  </tr>
                  
                  <tr>
                    <th>绘图来源：</th>
                    <td>
                    <select id="picbooksource" class="selector" name="appPicbookBaseDto.picbooksource">
                    	<option value="1">看图说话</option>
                    	<option value="2">听听画画</option>
                    	<option value="3">自说自话</option>
                    </select>
	                   <span style="color:red">*</span>
                    </td>
                    <th>状态：</th>
                    <td>
                    	<select id="picbookstatus" class="selector" name="appPicbookBaseDto.picbookstatus">
                    	<option value="0">无效</option>
                    	<option value="1" selected>有效</option>
                    	</select>
	                   <span style="color:red">*</span>
                    
                    </td>
                  </tr>
                  <tr>
                    <th>小红花数量：</th>
                    <td>
                    	<input id="flowercnt" name="appPicbookBaseDto.flowercnt" type="text"/>
                    </td>
                   
                  </tr>
                   <tr>
                     <th>图片：</th>
                     <td colspan="3">
                    	<input type="file" name="Filedata1" id="Filedata1"  style="width:50%; border:#cccccc solid 1px;padding: 7px 5px;"/>
	                    <span class="filebtn"> <input type="button" value="上传" onclick="fileUpload('1','picbookurl','pic')"></span>
	                    <span style="color:red" >*</span>
	                    <span><img src="${ctx }/images/loading.gif" id="loading1" style="display: none;"></span>
	                    	原图：<input type="checkbox" id="isorigin1" name="isorigin1" >
	                    <input id="picbookurl" type="hidden" name="appPicbookBaseDto.picbookurl" >
                     </td>
                  </tr>
                  
                  <tr class="height_70">
                    <th>场景：</th>
                    <td colspan="3"><textarea style="height:300px;position:relative;float:left" id="picscene" name="appPicbookBaseDto.picscene"></textarea>
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
