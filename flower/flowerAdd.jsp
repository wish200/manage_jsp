<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告-新增 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/resource/js/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/introduce/ajaxfileupload.js"></script>
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
	var ok=haveData("nickname", "用户昵称不能为空！")
	if(ok){
			  $("#flowerForm").ajaxSubmit({
			          type : 'post',  
			          url : '${ctx}/flower/flower_add.do',  
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "系统错误");  
			          },
			          success: function(data){
			               alert("保存成功");
			               publicURL="${ctx}/flower/flower_getList.do";
			               $("#flowerForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appFlowerBaseDto.busiid"]').val(data);
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
	 $("#flowerForm").find('input,select,textarea').attr('disabled',false);
	 $("#flowerForm").ajaxSubmit({
         type : 'post',  
         url : '${ctx}/flower/flower_send.do',  
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
                      <th>&nbsp;&nbsp; 小红花信息</th>
                    </tr>
                  </table>
                </div>
          <form id="flowerForm" method="post">  
                 
                <table class="school_task ostyle">
                  
                  <tr>
                    <th>评论用户：</th>
                    <td>
		               <input id="userid" name="appFlowerBaseDto.userid" type="text" />
		               <span style="color:red">*</span>
                    </td>
                    <th>用户昵称：</th>
                    <td>
		               <input id="nickname" name="appFlowerBaseDto.nickname" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                    <th>业务ID：</th>
                    <td>
		               <input id="busiid" name="appFlowerBaseDto.busiid" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>模块：</th>
                    <td>
                    	<select id="modular" class="selector" name="appFlowerBaseDto.modular">
                    	<option value="1">看图说话</option>
                    	<option value="2" >听听画画</option>
                    	<option value="3" >有效</option>
                    	</select>
	                   <span style="color:red">*</span>
                    
                    </td>
                  </tr>
                  
                  
                  <tr>
                    <th>发布时间：</th>
                    <td>
		               <input id="commentime" name="appFlowerBaseDto.commentime" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>小红花数量：</th>
                    <td>
                    	<input id="flowercnt" name="appFlowerBaseDto.flowercnt" type="text"/>
                    
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
